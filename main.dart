import 'package:flutter/material.dart';
import 'package:weatherapp/weather.dart';
import 'package:weatherapp/weathers.dart';
import 'clouds.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Clouds(),
    );
  }
}
