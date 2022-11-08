import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:web_dashboard/screens/login/loginScreen.dart';

import 'notifier/notifierManager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    // For the real-time data purpose
    // For Consumer / Notifier
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => UniversalNotifier())),
      ],
      child: const MyApp(),
    ),
  );
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
        fontFamily: 'Roboto',
      ),
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => const LoginScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
