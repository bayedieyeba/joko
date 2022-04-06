// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, deprecated_member_use

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:joko/screens/Home-page.dart';
import 'package:joko/screens/camera-screen.dart';
import 'package:joko/screens/login-screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "OpenSans",
          primaryColor: Color.fromARGB(255, 7, 94, 21),
          accentColor: Color(0xFF128C7E)),
      home: LoginScreen(),
    );
  }
}
