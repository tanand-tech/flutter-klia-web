import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_dashboard/model/login/login.dart';
import 'package:http/http.dart' as http;
import 'package:web_dashboard/service/login-api.dart';
import 'package:web_dashboard/service/setting-api.dart';
import 'package:web_dashboard/util/util.dart';

// Initialize the SharedPreferences
final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
// Global class variable
final refreshTokenDueLongPeriod = RefreshTokenDueLongPeriod();

class RefreshTokenDueLongPeriod {
  // Reopen application without any log in method
  Future<Login?> refreshToken(String refreshToken) async {
    Map<String, String> refreshTokenMap = {
      "refreshToken": refreshToken,
    };
    http.Response res = await getRefresh(refreshTokenMap);
    if (res.statusCode == 200) {
      Login login = Login.fromJson(jsonDecode(res.body));
      return login;
    }
    if (res.statusCode == 404) {
      Login login = Login();
      login.status = 'Unsuccessful';
      login.message = 'Error perform network action';
      return login;
    }
    return null;
  }

  // Store all the token in Shared Preferences
  storeToken(Map<String, String> tokens) async {
    final SharedPreferences preferences = await prefs;
    for (var token in tokens.keys) {
      debugPrint("Set $token into shared preferences");
      if (token == 'hasRefresh') {
        preferences.setString(token, 'true');
      }
      preferences.setString(token, tokens[token]!);
    }
  }

  // Download Static Data From API
  downloadStaticDataAPI() async {
    final SharedPreferences preferences = await prefs;
    var res = await downloadStaticData();
    if (res.statusCode == 200) {
      // Put the static data into shared preferences
      preferences.setString('staticData', res.body);
      print('set Static Data');
    } else {
      // Null
      preferences.setString('staticData', '{}');
      print('Static Data is null right now');
    }
  }

  // Control Function for Force Refresh
  Future<Map<String, String>> forceRefresh(BuildContext context) async {
    final SharedPreferences preferences = await prefs;
    // Get refreshToken from Shared Preferences for refresh token purpose
    String refreshTokenPrefs = preferences.getString('refreshToken')!;
    Map<String, String> mapToken = {};
    Login? loginData = await refreshToken(refreshTokenPrefs);
    if (loginData!.message == 'Successful') {
      print('success?');
      // Assign all the token in the map
      mapToken['idToken'] = loginData.data!.tokens!.idToken!;
      mapToken['accessToken'] = loginData.data!.tokens!.accessToken!;
      mapToken['refreshToken'] = refreshTokenPrefs;
      mapToken['hasRefresh'] = 'true';
      await storeToken(mapToken);
      // Check static data in shared preferences
      if (!preferences.containsKey('staticData')) {
        print('DOWNLOADING STATIC DATA RIGHT NOW..');
        await downloadStaticDataAPI();
      }
      return mapToken;
    } else {
      print('not success?');
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(showSnackBar(loginData.message!));
      }
      return mapToken;
    }
  }
}
