import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_dashboard/instance/forceRefresh/refreshTokenDueLongPeriod.dart';
import 'package:web_dashboard/model/universalMessage.dart';
import 'package:web_dashboard/screens/login/verficationCode.dart';
import 'package:web_dashboard/service/login-api.dart';
import 'package:web_dashboard/util/util.dart';

final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

int counterRunRefresh = 0;

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final _emailTextController = TextEditingController(text: "");

  late final SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Password Reset',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: const Text(
                'Enter your email to receive your password reset verification code.'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                contentPadding: EdgeInsets.zero,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: (Colors.blueAccent[200])!,
                  ),
                ),
                focusColor: Colors.blueAccent,
              ),
              controller: _emailTextController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your email";
                } else {
                  if (!isEmailValid(value)) {
                    return "Please enter a valid email";
                  }
                }
                return null;
              },
              onChanged: (value) {
                value = _emailTextController.text;
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await requestPasswordResetAPI(_emailTextController.text)
                  .then((value) {
                if (value == 'Successful') {
                  ScaffoldMessenger.of(context).showSnackBar(showSnackBar(
                      'The verification code has been sent to the entire email'));
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(showSnackBar(value));
                }
                return true;
              });
            },
            child: const Text(
              'Submit',
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: RichText(
                text: TextSpan(
                  text: 'I have password reset verfication code',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VerificationCode(),
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // API
  Future<String> requestPasswordResetAPI(String email) async {
    Map body = {};
    var res = await requestPasswordReset(email, body);

    if (res.statusCode == 200 || res.statusCode == 400) {
      UniversalMessage messagesAPI =
          UniversalMessage.fromJson(jsonDecode(res.body));
      debugPrint("The response body will be :: ${messagesAPI.message!}");
      return messagesAPI.message!;
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
          print('hasToken in sharedPreferences should be true...');
          String hasRefreshSP = preferences.getString('hasRefresh')!;
          print('hasToken in sharedPreferences :: $hasRefreshSP');
          if (hasRefreshSP == 'true') {
            preferences.setString('hasRefresh', 'false');
            setState(() {
              counterRunRefresh = 0;
            });
          }
        } else {
          print('There is no hasRefresh key in the map');
        }
      }
      return 'Null';
    }
    return 'null';
  }
}
