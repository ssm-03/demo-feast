import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mini/home.dart';
import 'package:mini/home2.dart';
import 'package:mini/login.dart'; // Assuming LoginPage is in login.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Splash Screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 6),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(), // Assuming LoginPage is defined and implemented
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png', // Replace with the path to your logo image
              width: 200,
              height: 200,
            ),
            SizedBox(height: 15),
            Text(
              'Food Efficiency And Support for Targeted communities',
              style: TextStyle(
                color: Colors.red,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
