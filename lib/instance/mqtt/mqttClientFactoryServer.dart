import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

// MqttClient makeClient(String url, String clientId) {
//   var client = MqttServerClient(url, clientId);
//   client.useWebSocket = true;
//   return client;
// }

MqttClient makeClient(String signedUrl, String identityId, int port) {
  MqttServerClient clientInit = MqttServerClient.withPort(
      signedUrl, identityId, port,
      maxConnectionAttempts: 2);

  clientInit.logging(on: true);
  clientInit.useWebSocket = true;
  clientInit.setProtocolV311();
  clientInit.disconnectOnNoResponsePeriod = 90;
  clientInit.keepAlivePeriod = 30;
  clientInit.autoReconnect = true;
  // clientInit.connectTimeoutPeriod = 90;

  final MqttConnectMessage connMess =
      MqttConnectMessage().withClientIdentifier(identityId);

  clientInit.connectionMessage = connMess;
  return clientInit;
}
