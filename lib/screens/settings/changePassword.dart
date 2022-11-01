import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_dashboard/instance/forceRefresh/refreshTokenDueLongPeriod.dart';
import 'package:web_dashboard/model/universalMessage.dart';
import 'package:web_dashboard/service/login-api.dart';

final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

int counterRunRefresh = 0;

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();

  final _oldPasswordTextController = TextEditingController(text: "");
  final _newPasswordTextController = TextEditingController(text: "");
  final _repeatNewPasswordTextController = TextEditingController(text: "");

  late final SharedPreferences preferences;

  @override
  void initState() {
    initSharedPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Change Password',
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
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Current Password",
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
                    return "Please enter the current password";
                  }
                  return null;
                },
                onChanged: (value) {
                  value = _oldPasswordTextController.text;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
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
                  if (checkNewNOldPassword(_oldPasswordTextController.text,
                      _newPasswordTextController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cannot use the same password.'),
                      ),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
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
                    return "Please enter again the new password";
                  }
                  return null;
                },
                onChanged: (value) {
                  value = _repeatNewPasswordTextController.text;
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                const snackBarSamePassword = SnackBar(
                  content: Text('Cannot use the same password.'),
                );
                const snackBarPasswordNotMatch = SnackBar(
                  content: Text('New password is not matched.'),
                );
                const snackBarPasswordChanged = SnackBar(
                  content: Text('Password successfully changed.'),
                );
                bool successChangedPassword = false;
                if (_formKey.currentState != null) {
                  if (_formKey.currentState!.validate()) {
                    String accessToken = preferences.getString('accessToken')!;

                    if (checkNewNOldPassword(_oldPasswordTextController.text,
                        _newPasswordTextController.text)) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(snackBarSamePassword);
                    }
                    if (checkNewNRepeatNewPassword(
                            _newPasswordTextController.text,
                            _repeatNewPasswordTextController.text) ==
                        false) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(snackBarPasswordNotMatch);
                    }
                    changePasswordAPI(
                            accessToken,
                            _newPasswordTextController.text,
                            _oldPasswordTextController.text)
                        .then((value) {
                      if (value == 'Successful') {
                        successChangedPassword = true;
                        if (successChangedPassword == true) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBarPasswordChanged);
                        }
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(showSnackBar(value));
                      }
                      return successChangedPassword;
                    });
                  }
                }
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

  SnackBar showSnackBar(String content) {
    return SnackBar(content: Text(content));
  }

// Function
  bool checkNewNOldPassword(String oldPassword, String newPassword) {
    if (oldPassword.compareTo(newPassword) == 0) {
      return true;
    }
    return false;
  }

  bool checkNewNRepeatNewPassword(
      String newPassword, String repeatNewPassword) {
    if (newPassword.compareTo(repeatNewPassword) == 0) {
      return true;
    }
    return false;
  }

  initSharedPreferences() async {
    preferences = await prefs;
  }

  // API
  Future<String> changePasswordAPI(
      String accessToken, String newPassword, String oldPassword) async {
    // String failToCallAPI = 'Unsuccessful';
    Map<String, String> changePasswordBody = {
      "accessToken": accessToken,
      "newPassword": newPassword,
      "oldPassword": oldPassword
    };
    var res = await changePassword(changePasswordBody);
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
    return 'nulkl';
  }
}

// class RequestChangePasswordMessage {
//   int? timestamp;
//   String? status;
//   String? error;
//   String? message;
//   String? path;

//   RequestChangePasswordMessage(
//       {this.timestamp, this.status, this.error, this.message, this.path});

//   RequestChangePasswordMessage.fromJson(Map<String, dynamic> json) {
//     timestamp = json['timestamp'];
//     status = json['status'];
//     error = json['error'];
//     message = json['message'];
//     path = json['path'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['timestamp'] = timestamp;
//     data['status'] = status;
//     data['error'] = error;
//     data['message'] = message;
//     data['path'] = path;
//     return data;
//   }
// }
