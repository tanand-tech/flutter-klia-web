import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_dashboard/instance/forceRefresh/refreshTokenDueLongPeriod.dart';
import 'package:web_dashboard/model/alert/alert.dart';
import 'package:web_dashboard/model/universalMessage.dart';
import 'package:web_dashboard/service/alertLog-api.dart' as api;
import 'package:web_dashboard/util/util.dart';

// Declare the Alert Type
enum AlertType { unaknowledge, aknowledge, all }

// Set the default alert type as unackownledge
String alertTypeInString = 'Unack';

// To store the alert
List<Alerts> fullAlertList = [];

// Detect the number of alert is displaying
int totalAlert = 0;
int currentAlert = 0;

// Avoid multiple call on forceRefresh
int counterRunRefresh = 0;

class AlertLog extends StatefulWidget {
  const AlertLog({super.key});
  @override
  State<AlertLog> createState() => _AlertLogState();
}

class _AlertLogState extends State<AlertLog> {
  // Scroll Controller
  late ScrollController controller;

  // For API used
  // Page limit
  final int paginationLimit = 20;

  // Initial Page
  int page = 0;

  // Default AlertType is unaknowledge
  AlertType? alertType = AlertType.unaknowledge;

  // Set visibility of the refresh button
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    /**
     * Declare the controller
     * Add listener
     */
    controller = ScrollController()..addListener(handleScrolling);
  }

  // Functions
  // For Scrolling purpose
  void handleScrolling() {
    /**
     * Detect if the page is scroll till the end
     * Page++ only if the currentAlert < totalAlert
     */
    if (controller.offset >= controller.position.maxScrollExtent) {
      if (currentAlert < totalAlert) {
        setState(() {
          page += 1;
        });
      }
    }
  }

  // Set the card colors
  Color? setCardColors(Alerts alert) {
    /**
     * Unacknowledged Alert == RED
     * Acknowledged Alert == WHITE
     */
    if (alert.acknowledgedBy?.name != null) {
      return Colors.white;
    }
    return Colors.red[700];
  }

  // Set the word colors
  Color? setWordsColor(Alerts alert) {
    /**
     * Unacknowledged Alert == WHITE
     * Acknowledged Alert == BLACK
     */
    if (alert.acknowledgedBy?.name != null) {
      return Colors.black;
    }
    return Colors.white;
  }

  // Widgets
  // List View of the alerts
  Widget getUnackAlertsType() {
    return FutureBuilder(
      future: getDataFromAPI(alertTypeInString),
      builder: ((context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return alertList(snapshot.data);
        }
        return loadingCard();
      }),
    );
  }

  // Widget
  // Display the alert list
  Widget alertList(List<Alerts> alerts) {
    /**
     * For loop the list to display the alert
     */
    return Column(
      children: [
        for (var alert in alerts) singleAlert(alert),
      ],
    );
  }

  // Display the alerts one by one from the alert list
  Widget singleAlert(Alerts alert) {
    return GestureDetector(
      /**
       * Enable the alert to be able to tap on
       * Click to show the Acknowledge Alert Dialog
       * Ask the user to acknowledge or not
       */
      onTap: () {
        if (alert.acknowledgedBy?.name == null) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return showAcknowledgeAlertDialog(alert);
            },
          );
        }
      },
      child: Card(
        elevation: 6,
        shadowColor: Colors.grey[400],
        color: setCardColors(alert),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AutoSizeText(
                  "${alert.type} @${alert.roomId}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: setWordsColor(alert),
                    fontSize: 14,
                    overflow: TextOverflow.visible,
                  ),
                  minFontSize: 10,
                ),
                AutoSizeText(
                  "${convertTimestampToDateTime(alert.timestamp!)}",
                  style: TextStyle(
                    color: setWordsColor(alert),
                    fontSize: 10,
                    overflow: TextOverflow.visible,
                  ),
                  minFontSize: 8,
                ),
              ],
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                "${alert.message}",
                style: TextStyle(
                    fontSize: 13,
                    color: setWordsColor(alert),
                    overflow: TextOverflow.visible),
                minFontSize: 10,
              ),
              if (alert.acknowledgedBy?.name != null) ...[
                AutoSizeText(
                  "Acknowledged: ${alert.acknowledgedBy!.name}, ${convertTimestampToDateTime(alert.acknowledgedTimestamp!)}",
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: setWordsColor(alert),
                      overflow: TextOverflow.visible),
                  minFontSize: 9,
                ),
              ] else ...[
                AutoSizeText(
                  "Acknowledged: -",
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: setWordsColor(alert),
                      overflow: TextOverflow.visible),
                  minFontSize: 9,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Widget
  // Display the Acknowledge Alert Dialog
  Widget showAcknowledgeAlertDialog(Alerts alert) {
    /**
     * Set up the buttons for search box
     * Cancel Button && Ok Button
     */
    Widget cancelButton = TextButton(
      child: const Text(
        "Cancel",
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Acknowledge"),
      onPressed: () {
        /**
         * Click to acknowledge the alert
         */
        int alertIdInt = alert.id!;
        String alertId = alertIdInt.toString();
        putAcknowledgeAPI(alertId).then((value) {
          if (value == 'Successful') {
            debugPrint('$alertId has $value acknowledged!');
            setState(() {
              fullAlertList = [];
              alertTypeInString = 'Unack';
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(showSnackBar(value));
          }
        });
        Navigator.of(context).pop();
      },
    );

    /**
     * Set up the AlertDialog and return as a Widget
     */
    return AlertDialog(
      title: Text("${alert.type} @${alert.roomId}"),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SizedBox(
            height: 80,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(alert.message!),
          );
        },
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
  }

  // Widget
  // Display the filter choice
  Widget showFilterChoice() {
    /**
     * Set up the buttons for search box
     * Cancel Button && Ok Button
     */
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Ok"),
      onPressed: () {
        switch (alertType) {
          case AlertType.unaknowledge:
            {
              setState(() {
                fullAlertList = [];
                alertTypeInString = 'Unack';
              });
            }
            break;
          case AlertType.aknowledge:
            {
              setState(() {
                fullAlertList = [];
                alertTypeInString = 'Ack';
              });
            }
            break;
          case AlertType.all:
            {
              setState(() {
                fullAlertList = [];
                alertTypeInString = 'All';
              });
            }
            break;
          default:
            break;
        }
        Navigator.of(context).pop();
      },
    );

    return AlertDialog(
      title: const Text('Filter'),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              children: [
                ListTile(
                  title: const Text('Unacknowledged'),
                  leading: Radio<AlertType>(
                    value: AlertType.unaknowledge,
                    groupValue: alertType,
                    onChanged: (AlertType? value) {
                      setState(() {
                        alertType = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Acknowledged'),
                  leading: Radio<AlertType>(
                    value: AlertType.aknowledge,
                    groupValue: alertType,
                    onChanged: (AlertType? value) {
                      setState(() {
                        alertType = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('All'),
                  leading: Radio<AlertType>(
                    value: AlertType.all,
                    groupValue: alertType,
                    onChanged: (AlertType? value) {
                      setState(() {
                        alertType = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
  }

  // Widget
  // Show When API is not working well
  Widget loadingCard() {
    return Card(
      elevation: 6,
      shadowColor: Colors.grey[400],
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          margin: const EdgeInsets.all(5.0),
          child: const Text(
            'Loading Alert Logs...',
            overflow: TextOverflow.fade,
            softWrap: false,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  // API Functions
  Future<List<Alerts>?> getDataFromAPI(String type) async {
    switch (type) {
      case 'Unack':
        {
          http.Response res =
              await api.getUnacknowledgedAlerts(page, paginationLimit);
          if (res.statusCode == 200) {
            /**
             * Unacknowledge Alerts
             * Decode the response body and assign into Alert Details
             * Get the Alert List 
             * Set the totalAlert, in case needed when user wish to see the full list
             */
            AlertDetails alertDetails =
                AlertLogs.fromJson(jsonDecode(res.body)).data!;
            List<Alerts> alertList = alertDetails.alerts!;
            totalAlert = alertDetails.total!;
            fullAlertList.addAll(alertList);
            currentAlert = fullAlertList.length;
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
                debugPrint(
                    'Could not get the refresh token in the shared preferences..');
                debugPrint('Cannot refresh the id token');
              }
            }
          }
          return fullAlertList;
        }
      case 'Ack':
        {
          http.Response res =
              await api.getAcknowledgedAlerts(page, paginationLimit);
          if (res.statusCode == 200) {
            /**
             * Acknowledge Alerts
             * Decode the response body and assign into Alert Details
             * Get the Alert List 
             * Set the totalAlert, in case needed when user wish to see the full list
             */
            AlertDetails alertDetails =
                AlertLogs.fromJson(jsonDecode(res.body)).data!;
            List<Alerts> alertList = alertDetails.alerts!;
            totalAlert = alertDetails.total!;
            fullAlertList.addAll(alertList);
            currentAlert = fullAlertList.length;
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
                debugPrint(
                    'Could not get the refresh token in the shared preferences..');
                debugPrint('Cannot refresh the id token');
              }
            }
          }
          return fullAlertList;
        }
      case 'All':
        {
          http.Response res = await api.getAllAlertLogs(page, paginationLimit);
          if (res.statusCode == 200) {
            /**
             * All Alerts
             * Decode the response body and assign into Alert Details
             * Get the Alert List 
             * Set the totalAlert, in case needed when user wish to see the full list
             */
            AlertDetails alertDetails =
                AlertLogs.fromJson(jsonDecode(res.body)).data!;
            List<Alerts> alertList = alertDetails.alerts!;
            totalAlert = alertDetails.total!;
            fullAlertList.addAll(alertList);
            currentAlert = fullAlertList.length;
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
                debugPrint(
                    'Could not get the refresh token in the shared preferences..');
                debugPrint('Cannot refresh the id token');
              }
            }
          }
          return fullAlertList;
        }
    }
    return null;
  }

  Future<String> putAcknowledgeAPI(String alertId) async {
    String message = 'Failed to acknowledge';
    http.Response res = await api.putAcknowledgeAlert(alertId);
    UniversalMessage universalMessage =
        UniversalMessage.fromJson(jsonDecode(res.body));
    if (res.statusCode == 200) {
      message = universalMessage.message!;
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
          debugPrint(
              'Could not get the refresh token in the shared preferences..');
          debugPrint('Cannot refresh the id token');
          // Should we direct the user to the login screen?
        }
      }
    }
    return message;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Alert Logs',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return showFilterChoice();
                },
              );
            },
            child: Container(
              width: 72,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(
                        Icons.filter_list_rounded,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  Positioned(
                    left: 20,
                    top: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.red,
                        borderRadius: BorderRadius.all(
                          Radius.elliptical(4, 3),
                        ),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        alertTypeInString,
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        controller: controller,
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          getUnackAlertsType(),
        ],
      ),
    );
  }

  // Widget
  // Refresh Alert List after refresh button been clicked
  Widget refreshAlertList() {
    page = 0;
    fullAlertList = [];
    return FutureBuilder(
      future: getDataFromAPI(alertTypeInString),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return alertList(snapshot.data);
        }
        return loadingCard();
      },
    );
  }
}
