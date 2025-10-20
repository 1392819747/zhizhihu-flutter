import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

class WeatherService {
  static const String _apiKey = '245e051433151c3d8afe086e433f2d1f';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  
  final Dio _dio = Dio();

  // 获取当前位置
  Future<Position?> getCurrentPosition() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return null;
      }

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      print('获取位置失败: $e');
      return null;
    }
  }

  // 根据坐标获取天气
  Future<WeatherData?> getWeatherByLocation(double lat, double lon) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/weather',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': _apiKey,
          'units': 'metric',
          'lang': 'zh_cn',
        },
      );

      if (response.statusCode == 200) {
        final weather = WeatherData.fromJson(response.data);
        final resolvedCityName = await _fetchCityName(lat, lon);
        if (resolvedCityName != null && resolvedCityName.isNotEmpty) {
          return weather.withCityName(resolvedCityName);
        }
        return weather;
      }
    } catch (e) {
      print('获取天气数据失败: $e');
    }
    return null;
  }

  // 根据城市名获取天气
  Future<WeatherData?> getWeatherByCity(String cityName) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/weather',
        queryParameters: {
          'q': cityName,
          'appid': _apiKey,
          'units': 'metric',
          'lang': 'zh_cn',
        },
      );

      if (response.statusCode == 200) {
        return WeatherData.fromJson(response.data);
      }
    } catch (e) {
      print('获取天气数据失败: $e');
    }
    return null;
  }

  // 获取当前位置天气
  Future<WeatherData?> getCurrentWeather() async {
    final position = await getCurrentPosition();
    if (position != null) {
      return await getWeatherByLocation(position.latitude, position.longitude);
    }
    return null;
  }

  Future<String?> _fetchCityName(double lat, double lon) async {
    try {
      final response = await _dio.get(
        'https://api.openweathermap.org/geo/1.0/reverse',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': _apiKey,
          'limit': 1,
        },
      );

      if (response.statusCode == 200 && response.data is List) {
        final List<dynamic> payload = response.data as List<dynamic>;
        if (payload.isEmpty) {
          return null;
        }
        final locationInfo = payload.first;
        if (locationInfo is! Map<String, dynamic>) {
          return null;
        }
        final localNames = locationInfo['local_names'] as Map<String, dynamic>?;
        return (localNames != null && localNames['zh'] is String && (localNames['zh'] as String).isNotEmpty)
            ? localNames['zh'] as String
            : locationInfo['name'] as String?;
      }
    } catch (e) {
      print('解析城市名称失败: $e');
    }
    return null;
  }
}

class WeatherData {
  final String cityName;
  final double temperature;
  final String description;
  final String icon;
  final double humidity;
  final double windSpeed;
  final int pressure;
  final double feelsLike;
  final double minTemp;
  final double maxTemp;
  final int sunrise;
  final int sunset;

  WeatherData({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.feelsLike,
    required this.minTemp,
    required this.maxTemp,
    required this.sunrise,
    required this.sunset,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      cityName: json['name'] ?? '未知城市',
      temperature: (json['main']['temp'] ?? 0).toDouble(),
      description: json['weather'][0]['description'] ?? '未知',
      icon: json['weather'][0]['icon'] ?? '01d',
      humidity: (json['main']['humidity'] ?? 0).toDouble(),
      windSpeed: (json['wind']['speed'] ?? 0).toDouble(),
      pressure: json['main']['pressure'] ?? 0,
      feelsLike: (json['main']['feels_like'] ?? 0).toDouble(),
      minTemp: (json['main']['temp_min'] ?? 0).toDouble(),
      maxTemp: (json['main']['temp_max'] ?? 0).toDouble(),
      sunrise: json['sys']['sunrise'] ?? 0,
      sunset: json['sys']['sunset'] ?? 0,
    );
  }

  String get iconUrl => 'https://openweathermap.org/img/wn/$icon@2x.png';
  
  String get temperatureText => '${temperature.round()}°';

  String get minMaxTemp => '高${maxTemp.round()}° 低${minTemp.round()}°';

  WeatherData withCityName(String newCityName) {
    return WeatherData(
      cityName: newCityName,
      temperature: temperature,
      description: description,
      icon: icon,
      humidity: humidity,
      windSpeed: windSpeed,
      pressure: pressure,
      feelsLike: feelsLike,
      minTemp: minTemp,
      maxTemp: maxTemp,
      sunrise: sunrise,
      sunset: sunset,
    );
  }
}
