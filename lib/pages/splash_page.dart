import 'dart:async';

import 'package:eden/pages/main_page.dart';
import 'package:flutter/material.dart';
// Import for the Timer

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Start a timer that will navigate to LoginPage after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: const Color.fromARGB(255, 224, 246, 225),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: Image.asset('assets/logo.png'),
            ),
            const Text(
              'Eden',
              style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 45, 88, 48)),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    ));
  }
}
