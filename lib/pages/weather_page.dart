import 'dart:developer' as devtools;

import 'package:eden/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../models/weather.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  bool _isLoading = true;
  //api key
  final _weatherService =
      WeatherService(apiKey: '265c2a36f734470116261049008b60bf');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    setState(() {
      _isLoading = true; // Start loading
    });

    String cityName = await _weatherService.getCurrentCity();
    devtools.log(cityName);

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {
      devtools.log(e.toString());
      _isLoading = false;
    }
  }

  // weather animation
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunderstorm.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/cloudy.json';
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              child: Image.asset('assets/logo.png'),
            ),
            const Text(
              "Eden Weather",
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 45, 88, 48)),
            )
          ],
        ),
      )),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Loading indicator
          : _weather != null
              ? Center(
                  child: Center(
                  child: Column(
                    children: [
                      const Spacer(),
                      Text(
                        _weather?.cityName ?? 'Welcome to the Weather Page',
                        style: const TextStyle(
                            fontSize: 24,
                            color: Color.fromARGB(255, 45, 88, 48)),
                      ),
                      Lottie.asset(
                          getWeatherAnimation(_weather?.mainCondition)),
                      Text(
                        '${_weather?.mainCondition}',
                        style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 122, 152, 124)),
                      ),
                      Text(
                        '${_weather?.temperature.round().toString()} °C',
                        style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 122, 152, 124)),
                      ),
                      const Spacer(),
                    ],
                  ),
                ))
              : const Center(
                  child: Text(
                      'Failed to load weather data')), // Error or empty state
    );
  }
}
