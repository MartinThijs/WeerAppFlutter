

import 'package:flutter/material.dart';
import 'package:firstly/models/weathermodel.dart';
import 'package:firstly/services/weather_service.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  // api key
  final _weatherService = WeatherService('0ee584ec0e046f742ed16decbdf318e1');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

  //errors
  catch (e) {
    print(e);
  }

  }
  // weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/zon.json'; // standaard naar zon

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'smoke':
      case 'haze':
      case 'dust':
        return 'assets/bewolkt.json';
      case 'fog':
      case 'mist':
        return 'assets/mist.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/zon,regen.json';
      case 'thunderstorm':
        return 'assets/onweer.json';
      case 'clear':
        return 'assets/zon.json';
      default:
        return 'assets/zon.json';
    }
  }

  // init state
  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        //city name
        Text(_weather?.cityName ?? "loading city.."),

        // animatie
        Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
      
        // temperatuur
        Text('${_weather?.temperature.round()}°C'),

         // weather condition
        Text(_weather?.mainCondition ?? "")
      ],
      ),
    ),
    );
  }
}