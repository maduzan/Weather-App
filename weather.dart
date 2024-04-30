import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/weather.dart';
import 'package:weatherapp/weathers.dart';
import 'package:http/http.dart' as http;

class Weathers {
  static const baseUrl = 'https://api.openweathermap.org/data/2.5';
  final String apiKey;

  Weathers(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission PP = await Geolocator.checkPermission();
    if (PP == LocationPermission.denied) {
      PP = await Geolocator.requestPermission();
    }

    Position po = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemark =
        await placemarkFromCoordinates(po.latitude, po.longitude);

    String? city = placemark[0].locality;

    return city ?? "";
  }
}
