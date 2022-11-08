import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_dashboard/instance/forceRefresh/refreshTokenDueLongPeriod.dart';
import 'package:web_dashboard/model/universalMessage.dart';
import 'package:web_dashboard/service/login-api.dart';
import 'package:web_dashboard/util/util.dart';

final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

int counterRunRefresh = 0;

class VerificationCode extends StatefulWidget {
  const VerificationCode({super.key});

  @override
  State<VerificationCode> createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  final _formKey = GlobalKey<FormState>();

  final _oldPasswordTextController = TextEditingController(text: "");
  final _newPasswordTextController = TextEditingController(text: "");
  final _repeatNewPasswordTextController = TextEditingController(text: "");

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
          'Verification Code',
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
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
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
                controller: _oldPasswordTextController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email address";
                  }
                  return null;
                },
                onChanged: (value) {
                  value = _oldPasswordTextController.text;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "New Password",
                  contentPadding: EdgeInsets.zero,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: (Colors.blueAccent[200])!,
                    ),
                  ),
                  focusColor: Colors.blueAccent,
                ),
                controller: _newPasswordTextController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a new password";
                  }
                  return null;
                },
                onChanged: (value) {
                  value = _newPasswordTextController.text;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Verification Code",
                  contentPadding: EdgeInsets.zero,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: (Colors.blueAccent[200])!,
                    ),
                  ),
                  focusColor: Colors.blueAccent,
                ),
                controller: _repeatNewPasswordTextController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a valid code";
                  }
                  return null;
                },
                onChanged: (value) {
                  value = _repeatNewPasswordTextController.text;
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await getResetPasswordAPI().then((value) {
                  if (value == 'Successful') {
                    ScaffoldMessenger.of(context).showSnackBar(
                        showSnackBar('New password has been set.'));
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(showSnackBar(value));
                  }
                  return true;
                });
              },
              child: const Text(
                'Save',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // API
  Future<String> getResetPasswordAPI() async {
    Map body = {};
    var res = await changePassword(body);

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
      return 'null';
    }
    return 'null';
  }
}
