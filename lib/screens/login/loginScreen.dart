import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:web_dashboard/homeScreen.dart';
import 'package:web_dashboard/instance/forceRefresh/refreshTokenDueLongPeriod.dart';
import 'package:web_dashboard/model/login/login.dart';
import 'package:web_dashboard/model/universalMessage.dart';
import 'package:web_dashboard/notifier/notifierManager.dart';
import 'package:web_dashboard/service/login-api.dart';
import 'package:web_dashboard/util/util.dart';

// Initialize the SharedPreferences
final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

// Avoid user clicked too much
// API been call and call
int counterClicked = 1;

// Login state
bool login = false;

class LoginScreen extends StatefulWidget {
  static const String id = "login-screen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Form Widget key
  final _formKey = GlobalKey<FormState>();

  // Set default key
  // Should remove before deploy / build
  final _emailTextController =
      TextEditingController(text: "user@tanand.com.my");
  final _passwordTextController = TextEditingController(text: "User@1234");

  @override
  void initState() {
    counterClicked = 1;
    debugPrint("Checking refresh token from preferences...");
    prefs.then((value) {
      if (value.containsKey('refreshToken')) {
        // Not First Time Log In
        debugPrint('Not first time logging in...');
        secondTimeLoginOnwards();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // klia logo & utw logo
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Image.asset('assets/images/klia-logo.png'),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Image.asset('assets/images/utw-logo.png'),
                    ),
                  ],
                ),
              ],
            ),
            // Email Address Input Field
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  labelText: "Email Address",
                  contentPadding: EdgeInsets.zero,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  focusColor: Theme.of(context).primaryColor,
                ),
                controller: _emailTextController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  }
                  return null;
                },
                onChanged: (value) {
                  value = _emailTextController.text;
                },
              ),
            ),
            // Password Input Field
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password_rounded),
                  labelText: "Password",
                  contentPadding: EdgeInsets.zero,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  focusColor: Theme.of(context).primaryColor,
                ),
                controller: _passwordTextController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your password";
                  }
                  return null;
                },
                onChanged: (value) {
                  value = _passwordTextController.text;
                },
              ),
            ),
            // Login button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 60),
              child: MaterialButton(
                onPressed: () async {
                  if (_formKey.currentState != null) {
                    if (_formKey.currentState!.validate() &&
                        counterClicked == 1) {
                      // To avoid calling to much of log in API
                      counterClicked++;
                      ScaffoldMessenger.of(context)
                          .showSnackBar(showSnackBar('Logging in...'));
                      if (context.mounted) {
                        await firstTimeLogin(context);
                      }
                    }
                  }
                },
                color: Colors.blue,
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Log In",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // API Functions
  // Get the data body for login function
  Future getToken(String email, String password) async {
    Map<String, String> user = {
      "email": email,
      "newPassword": password,
      "password": password
    };
    http.Response res = await getLogin(user);
    UniversalMessage loginMessage =
        UniversalMessage.fromJson(jsonDecode(res.body));
    if (loginMessage.message == 'Successful') {
      // If the message returned is Successful
      // Decode the response body as Login object
      Login login = Login.fromJson(jsonDecode(res.body));
      return login;
    } else {
      // Return the error message
      // Show the error message on the snackBar
      return loginMessage;
    }
  }

  firstTimeLogin(BuildContext context) async {
    final SharedPreferences preferences = await prefs;
    getToken(_emailTextController.text, _passwordTextController.text).then(
      (value) async {
        // If 'Successful', Login Object will be returned
        if (value.message! == 'Successful') {
          // Map all the token for storing in shared preferences purpose
          Map<String, String> mapToken = {};
          mapToken['idToken'] = value!.data!.tokens!.idToken!;
          mapToken['accessToken'] = value.data!.tokens!.accessToken!;
          mapToken['refreshToken'] = value.data!.tokens!.refreshToken!;
          await refreshTokenDueLongPeriod.storeToken(mapToken);
          debugPrint('DOWNLOADING STATIC DATA RIGHT NOW..');
          await refreshTokenDueLongPeriod.downloadStaticDataAPI();
          // Check static data in shared preferences
          if (preferences.containsKey('staticData') && context.mounted) {
            setState(() {
              login = true;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const HomeScreen();
                  },
                ),
              );
            });
          } else {
            // Download static data from API
            debugPrint('DOWNLOADING STATIC DATA RIGHT NOW..');
            await refreshTokenDueLongPeriod.downloadStaticDataAPI();
          }
        } else {
          counterClicked = 1;
          // Show error message on snack bar
          ScaffoldMessenger.of(context)
              .showSnackBar(showSnackBar(value.message!));
        }
      },
    );
  }

  secondTimeLoginOnwards() async {
    ScaffoldMessenger.of(context).showSnackBar(showSnackBar('Logging in...'));
    final SharedPreferences preferences = await prefs;
    if (context.mounted) {
      await refreshTokenDueLongPeriod.forceRefresh(context);
    }
    // Check static data in shared preferences
    if (preferences.containsKey('staticData') && context.mounted) {
      setState(() {
        login = true;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const HomeScreen();
            },
          ),
        );
      });
    } else {
      // Download static data from API
      debugPrint('DOWNLOADING STATIC DATA RIGHT NOW..');
      await refreshTokenDueLongPeriod.downloadStaticDataAPI();
    }
  }
}
