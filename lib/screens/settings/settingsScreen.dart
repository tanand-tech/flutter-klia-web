import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_dashboard/screens/settings/changePassword.dart';
import 'package:web_dashboard/screens/login/loginScreen.dart';

// Initialized Shared Preferences
final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            /**
             * Change Password Button
             */
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChangePassword(),
                  ),
                );
              },
              child: Card(
                elevation: 6,
                shadowColor: Colors.grey[400],
                child: const ListTile(
                  title: Text("Change Password"),
                  leading: FaIcon(
                    FontAwesomeIcons.solidUser,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            /**
             * About Button
             */
            GestureDetector(
              onTap: () {
                showAbout();
              },
              child: Card(
                elevation: 6,
                shadowColor: Colors.grey[400],
                child: const ListTile(
                  title: Text("About"),
                  leading: Icon(
                    Icons.error,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            /**
             * Logout Button
             */
            GestureDetector(
              onTap: () {
                /**
                 * Remove the token stored
                 * Prompt the user back to the LoginScreen()
                 */
                removeRefreshToken();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: Card(
                elevation: 6,
                shadowColor: Colors.grey[400],
                child: const ListTile(
                  title: Text("Logout"),
                  leading: Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget
  // Display About Alert Dialog
  showAbout() {
    /**
     * Set up the buttons for search box
     * Ok Button
     */
    Widget cancelButton = TextButton(
      child: const Text("Ok"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    /**
     * Set up the AlertDialog
     */
    AlertDialog alert = AlertDialog(
      title: const Text('About KLIA'),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Version name: 1.0.13'),
                SizedBox(
                  height: 1.0,
                ),
                Text('Version code: 10013'),
              ],
            ),
          );
        },
      ),
      actions: [
        cancelButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // Functions
  removeRefreshToken() async {
    /**
     * Romove all the token store in shared preferences
     */
    final SharedPreferences preferences = await prefs;
    preferences.remove('refreshToken');
    preferences.remove('accessToken');
    preferences.remove('idToken');
    preferences.remove('staticData');
  }
}
