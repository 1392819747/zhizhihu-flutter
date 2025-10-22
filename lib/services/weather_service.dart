import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:openim_common/openim_common.dart';

import 'weather_visuals.dart';

class WeatherService {
  WeatherService({Dio? dio})
      : _dio = dio ?? Dio(BaseOptions(connectTimeout: const Duration(seconds: 10), receiveTimeout: const Duration(seconds: 10)));

  final Dio _dio;

  /// 获取天气数据：首选精确经纬度，失败则回退到 IP 定位
  Future<WeatherData?> getWeather() async {
    Map<String, dynamic>? json;
    final position = await _tryGetPrecisePosition();
    if (position != null) {
      json = await _fetchWeatherByCoordinate(position.latitude, position.longitude);
    }
    json ??= await _fetchWeatherByIp();
    if (json == null) {
      Logger.print('未能获取天气数据', onlyConsole: true);
      return null;
    }
    try {
      return WeatherData.fromWttr(json);
    } catch (e) {
      Logger.print('解析 wttr.in 数据失败: $e', onlyConsole: true);
      return null;
    }
  }

  Future<Position?> _tryGetPrecisePosition() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return null;
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return null;
      }
      if (permission == LocationPermission.deniedForever) return null;
      return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
    } catch (e) {
      Logger.print('请求地理位置失败: $e', onlyConsole: true);
      return null;
    }
  }

  Future<Map<String, dynamic>?> _fetchWeatherByCoordinate(double lat, double lon) async {
    final url = '${Config.weatherBaseUrl}/${lat.toStringAsFixed(4)},${lon.toStringAsFixed(4)}';
    return _getJson(url);
  }

  Future<Map<String, dynamic>?> _fetchWeatherByIp() async {
    final url = '${Config.weatherBaseUrl}/';
    return _getJson(url);
  }

  Future<Map<String, dynamic>?> _getJson(String url) async {
    try {
      final response = await _dio.get('$url', queryParameters: {
        'format': 'j1',
        'lang': 'zh',
      });
      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return Map<String, dynamic>.from(response.data as Map);
      }
      Logger.print('wttr.in 返回异常状态: ${response.statusCode}', onlyConsole: true);
    } catch (e) {
      Logger.print('请求 wttr.in 失败: $e', onlyConsole: true);
    }
    return null;
  }
}

class WeatherData {
  WeatherData({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.iconCode,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.feelsLike,
    required this.minTemp,
    required this.maxTemp,
    required this.sunrise,
    required this.sunset,
  });

  final String cityName;
  final double temperature;
  final String description;
  final String iconCode;
  final double humidity;
  final double windSpeed;
  final double pressure;
  final double feelsLike;
  final double minTemp;
  final double maxTemp;
  final int sunrise;
  final int sunset;

  factory WeatherData.fromWttr(Map<String, dynamic> data) {
    final nearestArea = (data['nearest_area'] as List?)?.first;
    final current = (data['current_condition'] as List?)?.first;
    final weather = (data['weather'] as List?)?.first;

    if (nearestArea == null || current == null) {
      throw const FormatException('wttr.in 数据缺失');
    }

    final areaName = (nearestArea['areaName'] as List?)?.first?['value']?.toString();
    final region = (nearestArea['region'] as List?)?.first?['value']?.toString();
    final city = areaName ?? region ?? '未知地区';

    final description = (current['lang_zh'] as List?)?.first?['value']?.toString() ??
        (current['weatherDesc'] as List?)?.first?['value']?.toString() ??
        '未知天气';

    final maxTemp = double.tryParse((weather?['maxtempC'] ?? '').toString()) ?? double.tryParse((weather?['maxtempF'] ?? '').toString()) ?? 0;
    final minTemp = double.tryParse((weather?['mintempC'] ?? '').toString()) ?? double.tryParse((weather?['mintempF'] ?? '').toString()) ?? 0;
    final astronomy = (weather?['astronomy'] as List?)?.first;
    final date = (weather?['date'] ?? '').toString();
    final sunrise = _parseSunTime(date, astronomy?['sunrise']?.toString());
    final sunset = _parseSunTime(date, astronomy?['sunset']?.toString());

    return WeatherData(
      cityName: city,
      temperature: double.tryParse((current['temp_C'] ?? '').toString()) ??
          double.tryParse((current['temp_F'] ?? '').toString()) ??
          double.tryParse((current['FeelsLikeC'] ?? '').toString()) ??
          0,
      description: description,
      iconCode: (current['weatherCode'] ?? '').toString(),
      humidity: double.tryParse((current['humidity'] ?? '').toString()) ?? 0,
      windSpeed: double.tryParse((current['windspeedKmph'] ?? '').toString()) ??
          double.tryParse((current['windspeedMiles'] ?? '').toString()) ??
          0,
      pressure: double.tryParse((current['pressure'] ?? '').toString()) ?? 0,
      feelsLike: double.tryParse((current['FeelsLikeC'] ?? '').toString()) ?? 0,
      minTemp: minTemp,
      maxTemp: maxTemp,
      sunrise: sunrise,
      sunset: sunset,
    );
  }

  String get iconAsset => WeatherVisuals.iconAsset(iconCode);
  String get backgroundAsset => WeatherVisuals.backgroundAsset(iconCode);
  String get temperatureText => '${temperature.round()}°';
  String get minMaxTemp => '高${maxTemp.round()}° 低${minTemp.round()}°';

  static int _parseSunTime(String? date, String? time) {
    if (date == null || date.isEmpty || time == null || time.isEmpty) {
      return 0;
    }

    DateTime? baseDate;
    try {
      baseDate = DateTime.tryParse(date);
    } catch (_) {
      baseDate = null;
    }
    baseDate ??= DateTime.now();

    final match = RegExp(r'^(\d{1,2}):(\d{2})(?:\s*([aApP][mM]))?$').firstMatch(time.trim());
    if (match == null) {
      return 0;
    }

    var hour = int.tryParse(match.group(1) ?? '');
    final minute = int.tryParse(match.group(2) ?? '');
    if (hour == null || minute == null) {
      return 0;
    }

    final meridian = match.group(3)?.toLowerCase();
    if (meridian != null) {
      if (meridian == 'pm' && hour < 12) {
        hour += 12;
      } else if (meridian == 'am' && hour == 12) {
        hour = 0;
      }
    }

    final safeHour = hour.clamp(0, 23);
    final safeMinute = minute.clamp(0, 59);

    final dateTime = DateTime(
      baseDate.year,
      baseDate.month,
      baseDate.day,
      safeHour.toInt(),
      safeMinute.toInt(),
    );
    return dateTime.millisecondsSinceEpoch ~/ 1000;
  }
}
