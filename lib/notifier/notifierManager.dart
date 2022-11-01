import 'package:flutter/cupertino.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:web_dashboard/instance/mqtt/mqttManager.dart';
import 'package:web_dashboard/model/staticData/download%20copy.dart';
import 'package:web_dashboard/sharedPreference/sharedPreferences.dart';

class UniversalNotifier extends ChangeNotifier {
  String siteIdFromStaticData = '';

  get getSiteIdStaticData => siteIdFromStaticData;

  void getPayload() async {
    String temp = '';
    Download2 result = (await sharedPreference.getDataFromSharedPreferences())!;
    if (result.siteId == 'klia-1') {
      temp = result.siteId!;
      siteIdFromStaticData = temp;
      notifyListeners();
    }
  }
}

class TextNotifier extends ChangeNotifier {
  String statusPayload =
      'Nothing here for the status..'; // should put the data from API
  String mtbPayload =
      'Nothing here for the mtb..'; // should put the data from API
  String cpPayload =
      'Nothing here for the cp..'; // should put the data from API
  String satPayload =
      'Nothing here for the sat..'; // should put the data from API
  String mtbAllPayload =
      'Nothing here for the mtbAll..'; // should put the data from API
  String topicName = '';

  int counter = 1;

  get getMTBAllPayload => mtbAllPayload;

  get getStatusPayload => statusPayload;
  get getMTBPayload => mtbPayload;
  get getCPPayload => cpPayload;
  get getSATPayload => satPayload;

  void getPayload() {
    String pt = '';

    // debugPrint incoming messages from another client on this topic
    clientNew.updates!.listen(
      (List<MqttReceivedMessage<MqttMessage>> c) {
        MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
        topicName = c[0].topic;
        pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        switch (topicName) {
          case 'klia-1/status/count/rooms':
            {
              statusPayload = pt;
              debugPrint(
                  'Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
              debugPrint('');
              counter++;
              notifyListeners();
              break;
            }
          case 'klia-1/klia-1-mtb/status/count/rooms':
            {
              mtbPayload = pt;
              debugPrint(
                  'Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
              debugPrint('');
              counter++;
              notifyListeners();
              break;
            }
          case 'klia-1/klia-1-cp/status/count/rooms':
            {
              cpPayload = pt;
              debugPrint(
                  'Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
              debugPrint('');
              counter++;
              notifyListeners();
              break;
            }
          case 'klia-1/klia-1-sat/status/count/rooms':
            {
              satPayload = pt;
              debugPrint(
                  'Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
              debugPrint('');
              counter++;
              notifyListeners();
              break;
            }
        }
      },
    );
  }
}

class TextNotifierCleaner extends ChangeNotifier {
  String overallPayload =
      'Nothing here for the overall..'; // should put the data from API
  String contractorPayload =
      'Nothing here for the contractor..'; // should put the data from API
  String topicName = '';

  int counter = 1;

  get getOverallPayload => overallPayload;
  get getContractorPayload => contractorPayload;

  void getPayload() {
    String pt = '';

    // debugPrint incoming messages from another client on this topic
    clientNew.updates!.listen(
      (List<MqttReceivedMessage<MqttMessage>> c) {
        MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
        topicName = c[0].topic;
        pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        switch (topicName) {
          case 'klia-1/status/count':
            {
              overallPayload = pt;
              debugPrint(
                  'Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
              debugPrint('');
              counter++;
              notifyListeners();
              break;
            }
          case 'klia-1/status/count/contractors':
            {
              contractorPayload = pt;
              debugPrint(
                  'Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
              debugPrint('');
              counter++;
              notifyListeners();
              break;
            }
        }
      },
    );
  }
}

class TextNotifierAlertLogs extends ChangeNotifier {
  String payload =
      'Nothing here for the alerts..'; // should put the data from API
  String totalAlert = '';
  String topicName = '';
  bool newMessage = false;

  int counter = 1;

  get getALPayload => payload;
  get getNewMessage => newMessage;

  void getPayload() {
    String pt = '';

    // debugPrint incoming messages from another client on this topic
    clientNew.updates!.listen(
      (List<MqttReceivedMessage<MqttMessage>> c) {
        MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
        topicName = c[0].topic;
        pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        switch (topicName) {
          case 'klia-1/alerts/count':
            {
              payload = pt;
              debugPrint(
                  'Change alerts:: topic is <${c[0].topic}>, payload is <-- $pt -->');
              debugPrint('');
              counter++;
              newMessage = true;
              notifyListeners();
              break;
            }
        }
      },
    );
  }
}
