import 'package:flutter/material.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Padding(
        padding: EdgeInsets.only(top: 20),
        child: Text(
          "Weather",
          style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 45, 88, 48)),
        ),
      )),
      body: const Center(
        child: Text('Welcome to the Weather Page'),
      ),
    );
  }
}
