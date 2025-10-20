import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:openim_common/openim_common.dart';

import 'weather_visuals.dart';

class WeatherService {
  WeatherService({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;
  final _QWeatherJwtProvider _jwtProvider = _QWeatherJwtProvider();

  String get _weatherBaseUrl => Config.qWeatherBaseUrl;
  static const _geoBaseUrl = 'https://geoapi.qweather.com/v2';

  /// 获取当前位置
  Future<Position?> getCurrentPosition() async {
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
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      Logger.print('获取位置失败: $e', onlyConsole: true);
      return null;
    }
  }

  /// 根据坐标获取天气
  Future<WeatherData?> getWeatherByLocation(double lat, double lon) async {
    final locationParam = '${_formatDouble(lon)},${_formatDouble(lat)}';
    final nowPayload = await _fetchWeatherNow(locationParam);
    if (nowPayload == null) return null;

    final dailyPayload = await _fetchWeatherDaily(locationParam);
    final cityName = await _lookupCityName(location: locationParam);

    return WeatherData.fromHeWeather(
      nowPayload: nowPayload,
      dailyPayload: dailyPayload,
      cityName: cityName,
    );
  }

  /// 根据城市名获取天气
  Future<WeatherData?> getWeatherByCity(String cityName) async {
    final location = await _lookupCity(locationName: cityName);
    if (location == null) {
      Logger.print('未能找到城市: $cityName', onlyConsole: true);
      return null;
    }
    final locationId = location['id'] as String?;
    if (locationId == null || locationId.isEmpty) {
      Logger.print('城市缺少位置 ID: $cityName', onlyConsole: true);
      return null;
    }

    final nowPayload = await _fetchWeatherNow(locationId);
    if (nowPayload == null) return null;
    final dailyPayload = await _fetchWeatherDaily(locationId);
    final resolvedName = location['name'] as String? ?? cityName;

    return WeatherData.fromHeWeather(
      nowPayload: nowPayload,
      dailyPayload: dailyPayload,
      cityName: resolvedName,
    );
  }

  /// 获取当前位置天气
  Future<WeatherData?> getCurrentWeather() async {
    final position = await getCurrentPosition();
    if (position == null) return null;
    return getWeatherByLocation(position.latitude, position.longitude);
  }

  Future<Map<String, dynamic>?> _fetchWeatherNow(String location) async {
    return _authenticatedGet(
      '$_weatherBaseUrl/weather/now',
      {
        'location': location,
      },
    );
  }

  Future<Map<String, dynamic>?> _fetchWeatherDaily(String location) async {
    return _authenticatedGet(
      '$_weatherBaseUrl/weather/3d',
      {
        'location': location,
      },
    );
  }

  Future<String?> _lookupCityName({required String location}) async {
    final payload = await _lookupCity(locationParam: location);
    if (payload == null) return null;
    final name = payload['name'] as String?;
    final adm2 = payload['adm2'] as String?;
    if (name == null || name.isEmpty) return null;
    if (adm2 != null && adm2.isNotEmpty && adm2 != name) {
      return '$adm2·$name';
    }
    return name;
  }

  Future<Map<String, dynamic>?> _lookupCity({
    String? locationParam,
    String? locationName,
  }) async {
    final params = <String, dynamic>{
      if (locationParam != null) 'location': locationParam,
      if (locationName != null) 'location': locationName,
    };
    if (params.isEmpty) return null;

    final response = await _authenticatedGet(
      '$_geoBaseUrl/city/lookup',
      params,
    );
    if (response == null) return null;

    final locations = response['location'];
    if (locations is List && locations.isNotEmpty) {
      final first = locations.first;
      if (first is Map<String, dynamic>) {
        return first;
      }
    }
    return null;
  }

  Future<Map<String, dynamic>?> _authenticatedGet(
    String url,
    Map<String, dynamic> params,
  ) async {
    final creds = Config.qWeatherCredentials;
    if (creds == null) {
      Logger.print('未配置和风天气凭据，无法获取天气数据', onlyConsole: true);
      return null;
    }
    final token = await _jwtProvider.obtainToken();
    if (token == null) {
      Logger.print('生成和风天气 JWT Token 失败', onlyConsole: true);
      return null;
    }
    try {
      final response = await _dio.get(
        url,
        queryParameters: params,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Accept-Encoding': 'gzip',
          },
        ),
      );
      if (response.statusCode != 200 ||
          response.data is! Map<String, dynamic>) {
        Logger.print('请求天气接口失败: HTTP ${response.statusCode}',
            onlyConsole: true);
        return null;
      }
      final payload =
          Map<String, dynamic>.from(response.data as Map<String, dynamic>);
      final code = payload['code']?.toString();
      if (code != '200') {
        Logger.print('和风天气返回错误代码: $code', onlyConsole: true);
        return null;
      }
      return payload;
    } catch (e) {
      Logger.print('请求和风天气接口异常: $e', onlyConsole: true);
      return null;
    }
  }

  String _formatDouble(double value) =>
      value.toStringAsFixed(min(value.abs() >= 1 ? 4 : 6, 6));
}

class _QWeatherJwtProvider {
  final Ed25519 _algorithm = Ed25519();
  SimpleKeyPair? _keyPair;
  String? _cachedToken;
  int? _cachedExp;

  Future<String?> obtainToken() async {
    final creds = Config.qWeatherCredentials;
    if (creds == null) {
      Logger.print('未配置和风天气凭据', onlyConsole: true);
      return null;
    }

    final nowSeconds = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
    if (_cachedToken != null &&
        _cachedExp != null &&
        nowSeconds < (_cachedExp! - 30)) {
      return _cachedToken;
    }

    final iat = nowSeconds - 30;
    final exp = iat + 900;

    final header = jsonEncode({
      'alg': 'EdDSA',
      'kid': creds.credentialId,
    });
    final payload = jsonEncode({
      'sub': creds.projectId,
      'iat': iat,
      'exp': exp,
    });

    final headerEncoded = _base64UrlEncode(utf8.encode(header));
    final payloadEncoded = _base64UrlEncode(utf8.encode(payload));
    final signingInput = '$headerEncoded.$payloadEncoded';

    final keyPair = await _ensureKeyPair(creds.privateKeySeed);
    if (keyPair == null) {
      Logger.print('初始化和风天气签名密钥失败', onlyConsole: true);
      return null;
    }

    final signature = await _algorithm.sign(
      utf8.encode(signingInput),
      keyPair: keyPair,
    );
    final signatureEncoded = _base64UrlEncode(signature.bytes);

    final token = '$signingInput.$signatureEncoded';
    _cachedToken = token;
    _cachedExp = exp;
    return token;
  }

  Future<SimpleKeyPair?> _ensureKeyPair(Uint8List seed) async {
    if (_keyPair != null) return _keyPair;
    try {
      _keyPair = await _algorithm.newKeyPairFromSeed(seed);
      return _keyPair;
    } catch (e) {
      Logger.print('生成 Ed25519 密钥失败: $e', onlyConsole: true);
      return null;
    }
  }

  String _base64UrlEncode(List<int> bytes) =>
      base64Url.encode(bytes).replaceAll('=', '');
}

class WeatherData {
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

  factory WeatherData.fromHeWeather({
    required Map<String, dynamic> nowPayload,
    Map<String, dynamic>? dailyPayload,
    String? cityName,
  }) {
    final now =
        nowPayload['now'] as Map<String, dynamic>? ?? const <String, dynamic>{};
    final dailyList = dailyPayload?['daily'] as List<dynamic>?;
    final Map<String, dynamic>? daily = dailyList != null &&
            dailyList.isNotEmpty &&
            dailyList.first is Map<String, dynamic>
        ? Map<String, dynamic>.from(dailyList.first as Map<String, dynamic>)
        : null;

    final temperature = _parseDouble(now['temp']);
    final feelsLike = _parseDouble(now['feelsLike']);
    final humidity = _parseDouble(now['humidity']);
    final windSpeed = _parseDouble(now['windSpeed']);
    final pressure = _parseInt(now['pressure']);
    final description = (now['text'] ?? '未知').toString();
    final icon = (now['icon'] ?? '100').toString();

    final minTemp =
        daily != null ? _parseDouble(daily['tempMin']) : temperature;
    final maxTemp =
        daily != null ? _parseDouble(daily['tempMax']) : temperature;

    final fxDate = daily?['fxDate']?.toString();
    final sunriseStr = daily?['sunrise']?.toString();
    final sunsetStr = daily?['sunset']?.toString();

    final sunrise = _parseTimeToEpoch(fxDate, sunriseStr);
    final sunset = _parseTimeToEpoch(fxDate, sunsetStr);

    return WeatherData(
      cityName: cityName ?? '未知城市',
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

  String get iconUrl => 'https://icons.qweather.com/assets/icons/$icon.svg';

  String get temperatureText => '${temperature.round()}°';

  String get iconAsset => WeatherVisuals.iconAsset(icon);

  String get backgroundAsset => WeatherVisuals.backgroundAsset(icon);

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

  static double _parseDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }
    if (value is String) {
      return double.tryParse(value) ?? 0;
    }
    return 0;
  }

  static int _parseInt(dynamic value) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    if (value is String) {
      return int.tryParse(value) ?? double.tryParse(value)?.round() ?? 0;
    }
    return 0;
  }

  static int _parseTimeToEpoch(String? date, String? time) {
    if (date == null || date.isEmpty || time == null || time.isEmpty) {
      return 0;
    }
    var normalized = time;
    if (!normalized.contains(':') && normalized.length >= 3) {
      final hours = normalized.substring(0, 2);
      final minutes = normalized.substring(2, min(normalized.length, 4));
      normalized = '$hours:$minutes';
    }
    if (normalized.length == 4) {
      normalized = '${normalized.substring(0, 2)}:${normalized.substring(2)}';
    }
    if (normalized.length == 5) {
      normalized = '$normalized:00';
    }
    if (normalized.length == 2) {
      normalized = '$normalized:00:00';
    }
    try {
      final dateTime = DateTime.parse('${date}T$normalized');
      return dateTime.millisecondsSinceEpoch ~/ 1000;
    } catch (_) {
      try {
        final dateTime = DateTime.parse('${date}T$normalized+08:00');
        return dateTime.millisecondsSinceEpoch ~/ 1000;
      } catch (_) {
        return 0;
      }
    }
  }
}
