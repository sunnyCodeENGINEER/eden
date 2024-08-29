import 'package:flutter/material.dart';

import 'news_page.dart';
import 'shop_page.dart';
import 'weather_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    ShopPage(),
    ShopPage(), // Second shop page
    NewsPage(),
    WeatherPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 0 ? Icons.camera : Icons.camera_outlined,
              size: _currentIndex == 0 ? 40 : 24,
              color: const Color.fromARGB(255, 45, 88, 48),
            ),
            label: 'Shop 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 1 ? Icons.store : Icons.store_outlined,
              size: _currentIndex == 1 ? 40 : 24,
              color: const Color.fromARGB(255, 45, 88, 48),
            ),
            label: 'Shop 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 2 ? Icons.article : Icons.article_outlined,
              size: _currentIndex == 2 ? 40 : 24,
              color: const Color.fromARGB(255, 45, 88, 48),
            ),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 3 ? Icons.cloud : Icons.cloud_queue_outlined,
              size: _currentIndex == 3 ? 40 : 24,
              color: const Color.fromARGB(255, 45, 88, 48),
            ),
            label: 'Weather',
          ),
        ],
      ),
    );
  }
}
