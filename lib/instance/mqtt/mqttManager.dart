import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
// import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:sigv4/sigv4.dart';
import 'package:web_dashboard/config.dart' as config;
import 'package:web_dashboard/instance/mqtt/mqttClientFactory.dart';

//-----------------------------------------------------------------------------------

const region = config.region;
// Add to config
const baseUrl = 'a29sgzuhsqfywu-ats.iot.$region.amazonaws.com';
const scheme = 'wss://';
const urlPath = '/mqtt';
const port = 443;
// Add to config
const iotApiUrl = 'https://iot.$region.amazonaws.com/target-policies';
const policyName = config.policyName;

final userPool = CognitoUserPool(
  config.userPoolId,
  config.clientId,
);

final cognitoUser = CognitoUser('user@tanand.com.my', userPool);
final authDetails = AuthenticationDetails(
  username: 'user@tanand.com.my',
  password: 'User@1234',
);

String identityId = '';
String signedUrl = '';

final mqttManager = MqttManager();
late final MqttClient clientNew;

var pongCount = 0; // Pong counter

class MqttManager {
  Future<int> initAwsInstance() async {
    print('Initiating Aws Instance');
    final session = await cognitoUser.authenticateUser(authDetails);

    // Connect to Cognito to get the credentials
    // 'package:amazon_cognito_identity_dart_2/cognito.dart';
    final credentials = CognitoCredentials(config.identityPoolId, userPool);
    await credentials.getAwsCredentials(session?.getIdToken().getJwtToken());

    // Check credentials purpose
    // debugPrint(credentials.accessKeyId);
    // debugPrint(credentials.secretAccessKey);
    // debugPrint(credentials.sessionToken);
    // debugPrint(credentials.userIdentityId);

    String accessKey = credentials.accessKeyId as String;
    String secretKey = credentials.secretAccessKey as String;
    String sessionToken = credentials.sessionToken as String;
    identityId = credentials.userIdentityId as String;

    // String accessKey = 'ASIAQ5P2JEEJHDYGVZF3';
    // String secretKey = '88odTXDXnwB9/GvQgJMf1BZ84GDtvR4JM4zq3ppE';
    // String sessionToken =
    //     'IQoJb3JpZ2luX2VjECkaDmFwLXNvdXRoZWFzdC0xIkgwRgIhAJHrXhK2yqJSLrN34AtBAEEZAOiSGb+POxuMEgXDeSGPAiEAgO4Go6n3rtgtax0Uyl7CdM6SKwYvJTOULgTHOi21M3Uq4gQIIhACGgwwNjMzMzg3ODI5OTQiDLSP5TkDWo8DxJmdFyq/BOvle0N1DXRHn14e+tiLTiEFxzbI7sx0prdeqopLPhfOgcP0YfAK9zv7htdyVT8viPonJBBeueuK1gv2PYAubxomdTEIbCHcWt+I8eAoB5VF+WWlgMjaRci9upVyThoBgLSxoX6Jk5fnJdoXc6F3TELLEzdd5Ie7ZaOXIk4bBDG+IR7IO6Elqv+Xe7+pwCYf0888IbzkWesyMV3X0vClGaXotjUCAfLH2c1vCLO5Qw/WBhcQhZkbw6uqknQjQnH8YxRmoGYa74+9G0DTUrzNQ10mpQ9Ii4mtluLuZ8C7z/EyVqH0s0q6JiykFt24hadtZDmBYt6A6H14bEKv0eObOmr6DXdkAubmBSpbR42I8IIgsaZ6b2eWUqnUE4UyTQ2aZmsh1Pl3Ifhy9iv3IYMby4SlZGPNtT0a2suH2VKa1UDcFavtg6ChtdcC/aq5GSduES4zAAnor12Btv+YaHHNKz/EEuFzgnzyXwBvzvqculoWfHOvqS/OGSSP4clt0e9MVkN/+16xNicrd+TMWRAF5JfInTD8lbIunwmcaCrmHADXLKrGodHW/NUDqgVCise6sA/J2xgQtQKwTdq6Ueg6Hf/4BoK/rti3NSm3wgW2Gh34N9w+Zy5XhROJnSTRJErLBtz1hAMg50rTwtYojC1tY5puJfx/3ofw0NJ4GRXZdyZ2P0TKbnhejm3l4woztOG38GmLpq0thMbUFTzM4PURPtuuzo8nlpFNRsJspSPDu1KbZyKB/1fAAYbWPRNvJuG4MMG3oZsGOoQCYRJCw/2E/ZDTwv/IsTGdrgNLxZ9v2uDlEH/clmWS5Ro+a003za1fd3lM9SqTZLgozIZAxDvIhJmhBAqIoaNDwy5H1A4uy/Sh31i1m5wrxCIK0nqNLV5r94naDu6rG4hUy8Rl43RXmjrZOPCfEsZhuLXLAcARzI3imjCg7gA1J87q2LEzm5PTEpLv1e0zPw2Vq9bQVcc0rN42NH9Tdc6/bFKVyujDNfiT/fevd/PKXwhpPRqSXDPweCKY/bk+wpOwyQn8gh/VOPBao/VpD/cO9uU8P5IkrczIho3drbVEMVyLv0l+SKui31pLUmM/SG2o3Bg72R6kt10aTepwvT9XUcjIgnM=';
    // identityId = 'ap-southeast-1:e64c4a02-991c-4ef4-9780-2b46e6d97e83';

    if (!await attachPolicy(
        accessKey: accessKey,
        secretKey: secretKey,
        sessionToken: sessionToken,
        identityId: identityId,
        iotApiUrl: iotApiUrl,
        region: region,
        policyName: policyName)) {
      debugPrint('MQTT client setup error - attachPolicy failed');
      exit(-1);
    }

    signedUrl = getWebSocketURL(
        accessKey: accessKey,
        secretKey: secretKey,
        sessionToken: sessionToken,
        region: region,
        scheme: scheme,
        endpoint: baseUrl,
        urlPath: urlPath);

    debugPrint(signedUrl);

    return 0;
  }

  initIoTClient() {
    clientNew = makeClient(signedUrl, identityId, port);
  }

  // Future<MqttBrowserClient> initIoTClient() async {
  //   print('Initiating IoT Client');
  //   // Start connect to MQTT
  //   MqttBrowserClient clientInit = MqttBrowserClient.withPort(
  //       signedUrl, identityId, port,
  //       maxConnectionAttempts: 2);

  //   clientInit.logging(on: false);
  //   clientInit.setProtocolV311();
  //   clientInit.disconnectOnNoResponsePeriod = 90;
  //   clientInit.keepAlivePeriod = 30;
  //   clientInit.autoReconnect = true;
  //   // client.resubscribeOnAutoReconnect = false;
  //   // clientInit.onAutoReconnect = onAutoReconnect;
  //   // clientInit.onAutoReconnected = onAutoReconnected;
  //   // clientInit.onConnected = onConnected;
  //   // client.onSubscribed = onSubscribed;

  //   final MqttConnectMessage connMess =
  //       MqttConnectMessage().withClientIdentifier(identityId);

  //   clientInit.connectionMessage = connMess;
  //   client = clientInit;

  //   return clientInit;

  //   // debugPrint('Sleeping....');
  //   // await MqttUtilities.asyncSleep(10);
  // }

  Future<Object> connectMqtt() async {
    print('Connecting to Mqtt');
    // Connect the client
    try {
      debugPrint('MQTT client connecting to AWS IoT using cognito....');
      await clientNew.connect();
    } on Exception catch (e) {
      debugPrint('MQTT client exception - $e');
      clientNew.disconnect();
      exit(-1);
    }

    // Check connection status
    if (clientNew.connectionStatus!.state == MqttConnectionState.connected) {
      debugPrint('MQTT client connected to AWS IoT');
      return clientNew;
    }

    return 'MQTT client is not connected...';
  }

  subscribeTopic(String topicToSubscribe) async {
    print('Subscribing $topicToSubscribe');

    if (clientNew.connectionStatus!.state == MqttConnectionState.connected) {
      // Publish to a topic of your choice
      String topic = topicToSubscribe;
      // final builder = MqttClientPayloadBuilder();
      // builder.addString('Hello World');
      // // Important: AWS IoT Core can only handle QOS of 0 or 1. QOS 2 (exactlyOnce) will fail!
      // client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);

      // Subscribe to the same topic
      clientNew.subscribe(topic, MqttQos.atLeastOnce);
      debugPrint('Subscribed to $topicToSubscribe');
      // // debugPrint incoming messages from another client on this topic
      // client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      //   recMess = c[0].payload as MqttPublishMessage;
      //   final pt =
      //       MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      //   payload = pt;
      //   debugPrint(
      //       'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      //   debugPrint('');
      // });
      return 'Subscribed to $topicToSubscribe';
    } else {
      debugPrint(
          'ERROR MQTT client connection failed - disconnecting, state is ${clientNew.connectionStatus!.state}');
      clientNew.disconnect();
      return 'Disconnected';
    }
  }

  disconnectMqtt() {
    debugPrint('Disconnecting');
    clientNew.disconnect();
  }

  unsubscribeTopic(String topicName) {
    debugPrint('Unsubcribing $topicName');
    clientNew.unsubscribe(topicName);
  }
}

String getWebSocketURL(
    {required String accessKey,
    required String secretKey,
    required String sessionToken,
    required String region,
    required String scheme,
    required String endpoint,
    required String urlPath}) {
  const serviceName = 'iotdevicegateway';
  const awsS4Request = 'aws4_request';
  const aws4HmacSha256 = 'AWS4-HMAC-SHA256';
  var now = Sigv4.generateDatetime();

  var creds = [
    accessKey,
    now.substring(0, 8),
    region,
    serviceName,
    awsS4Request,
  ];

  var queryParams = {
    'X-Amz-Algorithm': aws4HmacSha256,
    'X-Amz-Credential': creds.join('/'),
    'X-Amz-Date': now,
    'X-Amz-SignedHeaders': 'host',
  };

  var canonicalQueryString = Sigv4.buildCanonicalQueryString(queryParams);

  var request = Sigv4.buildCanonicalRequest(
    'GET',
    urlPath,
    queryParams,
    {'host': endpoint},
    '',
  );

  var hashedCanonicalRequest = Sigv4.hashPayload(request);
  var stringToSign = Sigv4.buildStringToSign(
    now,
    Sigv4.buildCredentialScope(now, region, serviceName),
    hashedCanonicalRequest,
  );

  var signingKey = Sigv4.calculateSigningKey(
    secretKey,
    now,
    region,
    serviceName,
  );

  var signature = Sigv4.calculateSignature(signingKey, stringToSign);

  var finalParams =
      '$canonicalQueryString&X-Amz-Signature=$signature&X-Amz-Security-Token=${Uri.encodeComponent(sessionToken)}';

  return '$scheme$endpoint$urlPath?$finalParams';
}

Future<bool> attachPolicy(
    {required String accessKey,
    required String secretKey,
    required String sessionToken,
    required String identityId,
    required String iotApiUrl,
    required String region,
    required String policyName}) async {
  final sigv4Client = Sigv4Client(
      keyId: accessKey,
      accessKey: secretKey,
      sessionToken: sessionToken,
      region: region,
      serviceName: 'execute-api');

  final body = json.encode({'target': identityId});

  final request =
      sigv4Client.request('$iotApiUrl/$policyName', method: 'PUT', body: body);

  var result = await put(request.url, headers: request.headers, body: body);

  if (result.statusCode != 200) {
    debugPrint('Error attaching IoT Policy ${result.body}');
  }

  return result.statusCode == 200;
}

/// The subscribed callback
void onSubscribed(String topic) {
  print('EXAMPLE::Subscription confirmed for topic $topic');
}

/// The pre auto re connect callback
void onAutoReconnect() {
  print(
      'EXAMPLE::onAutoReconnect client callback - Client auto reconnection sequence will start');
}

/// The post auto re connect callback
void onAutoReconnected() {
  print(
      'EXAMPLE::onAutoReconnected client callback - Client auto reconnection sequence has completed');
}

/// The successful connect callback
void onConnected() {
  print(
      'EXAMPLE::OnConnected client callback - Client connection was successful');
}
