// import 'dart:async';

// import 'package:flutter/material.dart';

// class SplashScreen extends StatefulWidget {
//   static const String id = "splash-screen";
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     Timer(
//       const Duration(seconds: 3),
//       () {
//         Navigator.pushReplacementNamed(context);
//       },
//     );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SizedBox(
//           height: 200,
//           width: 200,
//           child: Image.asset('assets/images/logo.jpg'),
//         ),
//       ),
//     );
//   }
// }
