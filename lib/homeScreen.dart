import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:web_dashboard/instance/forceRefresh/refreshTokenDueLongPeriod.dart';
import 'package:web_dashboard/model/alert/alert.dart';
import 'package:web_dashboard/model/staticData/download%20copy.dart';
import 'package:web_dashboard/screens/alert/alertScreen.dart';
import 'package:web_dashboard/screens/cleaner/cleanerScreen.dart';
import 'package:web_dashboard/screens/location/locationScreen.dart';
import 'package:web_dashboard/screens/settings/settingsScreen.dart';
import 'package:web_dashboard/service/alertLog-api.dart';
import 'package:web_dashboard/sharedPreference/sharedPreferences.dart';

// Initialize the SharedPreferences
final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

// Determine where does this used
Download2 staticDataHS = Download2('siteId', 'name');

// Avoid multiple call on forceRefresh
int counterRunRefresh = 0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  // Bottom Tab Controller
  late TabController tabController;
  // Current Screen Name
  late String currentTitle;
  // Current Screen Page
  int currentPage = 0;
  // List of Screen Name
  List<String> titleList = [
    'Locations',
    "Cleaners",
    "Alert Logs",
    "Settings",
  ];
  // List of Screen
  List<Widget> pages = [
    const LocationScreen(),
    const CleanerScrren(),
    const AlertLog(),
    const Settings(),
  ];

  @override
  void initState() {
    /**
     * Get the static data from Shared Preferences
     * For the whole app use -> staticDataHS
     */
    initStaticData();

    super.initState();
  }

  /// Functions
  initStaticData() async {
    staticDataHS = (await sharedPreference.getDataFromSharedPreferences())!;
  }

  // Changing when bottom tab is clicked
  void _onItemTapped(int index) {
    setState(() {
      currentPage = index;
    });
  }

  // API Functions
  Future<int> getTotalAlertsAPI() async {
    int totalAlerts = 0;
    http.Response res = await getUnacknowledgedAlerts(0, paginationLimit);
    if (res.statusCode == 200) {
      AlertDetails alertDetails =
          AlertLogs.fromJson(jsonDecode(res.body)).data!;
      totalAlerts = alertDetails.total!;
      return totalAlerts;
    }
    if (res.statusCode == 403) {
      counterRunRefresh++;
      if (counterRunRefresh == 1) {
        debugPrint('Refreshing the idToken...');
        Map<String, String> refreshingToken = {};
        if (context.mounted) {
          refreshingToken =
              await refreshTokenDueLongPeriod.forceRefresh(context);
        }
        if (refreshingToken.containsKey('hasRefresh')) {
          setState(() {
            counterRunRefresh = 0;
          });
        } else {
          debugPrint('There is no hasRefresh key in the map');
        }
      }
      return totalAlerts;
    }
    return totalAlerts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(currentPage),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.blue[700],
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.location_city,
            ),
            label: 'Location',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.userGroup,
              size: 19,
            ),
            label: 'Cleaners',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: <Widget>[
                const Icon(
                  Icons.notifications,
                ),
                Positioned(
                  right: 0,
                  child: FutureBuilder(
                    future: getTotalAlertsAPI(),
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        int totalAlerts = snapshot.data!;
                        return Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 14,
                            minHeight: 14,
                          ),
                          child: Text(
                            totalAlerts.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                      return const Text('');
                    },
                  ),
                )
              ],
            ),
            label: 'Alert Logs',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: 'Settings',
          ),
        ],
        currentIndex: currentPage,
        onTap: _onItemTapped,
        iconSize: 26,
        elevation: 5,
      ),
    );
  }
}
