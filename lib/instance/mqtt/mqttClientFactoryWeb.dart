import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';

// MqttClient makeClient(String url, String clientId) =>
//     MqttBrowserClient(url, clientId);

MqttClient makeClient(String signedUrl, String identityId, int port) {
  MqttBrowserClient clientInit = MqttBrowserClient.withPort(
      signedUrl, identityId, port,
      maxConnectionAttempts: 2);

  clientInit.logging(on: true);
  // clientInit.setProtocolV311();
  clientInit.disconnectOnNoResponsePeriod = 90;
  clientInit.keepAlivePeriod = 30;
  clientInit.autoReconnect = true;
  clientInit.resubscribeOnAutoReconnect = true;
  // clientInit.connectTimeoutPeriod = 90;

  final MqttConnectMessage connMess =
      MqttConnectMessage().withClientIdentifier(identityId);

  clientInit.connectionMessage = connMess;
  return clientInit;
}
