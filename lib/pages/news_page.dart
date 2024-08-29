import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.only(top: 20),
          child: const Text(
            "News",
            style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 45, 88, 48)),
          ),
        ),
      ),
      body: const Center(
          child: Column(
        children: [
          Text(
            'Welcome to the News Page',
            style: TextStyle(
              fontSize: 40,
              color: Color.fromARGB(255, 45, 88, 48),
            ),
          ),
          Text(
            '40',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: Color.fromARGB(255, 116, 180, 120),
            ),
          ),
        ],
      )),
    );
  }
}
