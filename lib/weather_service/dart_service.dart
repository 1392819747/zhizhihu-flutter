import 'dart:convert';

import '../models/models.dart';
import 'package:http/http.dart' as http;

class DataService {
  Future<WeatherResponse> getWeather(long, lat) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?&lon=$long&lat=$lat&appid=245e051433151c3d8afe086e433f2d1f&units=metric&lang=zh_cn'));
    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }
}
