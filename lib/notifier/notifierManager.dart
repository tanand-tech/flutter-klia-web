import 'package:flutter/cupertino.dart';
import 'package:web_dashboard/model/staticData/download%20copy.dart';
import 'package:web_dashboard/sharedPreference/sharedPreferences.dart';

class UniversalNotifier extends ChangeNotifier {
  String siteIdFromStaticData = '';

  get getSiteIdStaticData => siteIdFromStaticData;

  void getPayload() async {
    String temp = '';
    Download2 result = (await sharedPreference.getDataFromSharedPreferences())!;
    debugPrint('got the data, updating the things');
    if (result.siteId == 'klia-1') {
      temp = result.siteId!;
      siteIdFromStaticData = temp;
      notifyListeners();
    }
  }
}
