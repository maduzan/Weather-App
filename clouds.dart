import 'dart:math';
import 'package:flutter/material.dart';
import 'package:weatherapp/weather.dart';
import 'package:weatherapp/weathers.dart';

class Clouds extends StatefulWidget {
  const Clouds({Key? key}) : super(key: key);

  @override
  State<Clouds> createState() => _CloudsState();
}

class _CloudsState extends State<Clouds> {
  late Weathers _weathers;
  Weather? _weather;
  String? _error;

  @override
  void initState() {
    super.initState();
    _weathers = Weathers(
        'e8abcf652100a7ba98d10f4c3bbe3b1a'); // Replace 'YOUR_API_KEY' with your actual API key
    _fetchWeather();
  }

  _fetchWeather() async {
    try {
      String cityName = await _weathers.getCurrentCity();
      final weather = await _weathers.getWeather(cityName);

      setState(() {
        _weather = weather;
        _error = null;
      });
    } catch (e) {
      setState(() {
        _error = 'Error fetching weather: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.add_home_rounded),
        ),
      ),
      body: Center(
        child: _weather != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_weather!.cityName),
                  SizedBox(height: 8),
                  Text('${_weather!.temperature?.round()}°C'),
                ],
              )
            : _error != null
                ? Text(_error!)
                : CircularProgressIndicator(),
      ),
    );
  }
}
