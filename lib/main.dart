import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/instance/mqtt/mqttManager.dart';

import 'package:web_dashboard/notifier/notifierManager.dart';
import 'package:web_dashboard/screens/login/loginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await connectToAWS();
  runApp(
    // For the real-time data purpose
    // For Consumer / Notifier
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => UniversalNotifier())),
        ChangeNotifierProvider(create: ((context) => TextNotifier())),
        ChangeNotifierProvider(create: ((context) => TextNotifierCleaner())),
        ChangeNotifierProvider(create: ((context) => TextNotifierAlertLogs())),
      ],
      child: const MyApp(),
    ),
  );
}

connectToAWS() async {
  await mqttManager.initAwsInstance();
  await mqttManager.initIoTClient();
  await mqttManager.connectMqtt();
  debugPrint('Mqtt Manager is ready to go...');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KLIA',
      theme: ThemeData(
        primaryColor: Colors.blue[200],
      ),
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
