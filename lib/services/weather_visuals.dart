import 'package:flutter/material.dart';

/// 统一处理天气图标、背景等资源映射，保证异常返回也能找到本地素材。
class WeatherVisuals {
  WeatherVisuals._();

  static const _defaultCode = '02d';
  static const _availableCodes = <String>{
    '01d',
    '01n',
    '02d',
    '02n',
    '03d',
    '03n',
    '04d',
    '04n',
    '09d',
    '09n',
    '10d',
    '10n',
    '11d',
    '11n',
    '13d',
    '13n',
    '50d',
    '50n',
  };
  static const Map<String, String> _heWeatherToOpenWeather = {
    '100': '01d',
    '150': '01n',
    '101': '02d',
    '151': '02n',
    '102': '02d',
    '152': '02n',
    '103': '02d',
    '153': '02n',
    '104': '04d',
    '154': '04n',
    '300': '09d',
    '301': '09d',
    '302': '11d',
    '303': '11d',
    '304': '11d',
    '305': '09d',
    '306': '09d',
    '307': '10d',
    '308': '10d',
    '309': '09d',
    '310': '10d',
    '311': '10d',
    '312': '10d',
    '313': '10d',
    '314': '09d',
    '315': '09d',
    '316': '10d',
    '317': '10d',
    '318': '09d',
    '350': '09n',
    '351': '09n',
    '399': '09d',
    '400': '13d',
    '401': '13d',
    '402': '13d',
    '403': '13d',
    '404': '13d',
    '405': '13d',
    '406': '13d',
    '407': '13d',
    '408': '13d',
    '409': '13d',
    '410': '13d',
    '499': '13d',
    '500': '50d',
    '501': '50d',
    '502': '50d',
    '503': '50d',
    '504': '50d',
    '507': '50d',
    '508': '50d',
    '509': '50d',
    '510': '50d',
    '511': '50d',
    '512': '50d',
    '513': '50d',
    '514': '50d',
    '515': '50d',
  };

  static const Map<String, String> _wmoToOpenWeather = {
    '113': '01d', // Clear/sunny
    '116': '02d', // Partly cloudy
    '119': '03d', // Cloudy
    '122': '04d', // Overcast
    '143': '50d', // Mist
    '176': '09d', // Patchy rain possible
    '179': '13d', // Patchy snow possible
    '182': '13d',
    '185': '09d',
    '200': '11d', // Thundery outbreaks possible
    '227': '13d',
    '230': '13d',
    '248': '50d',
    '260': '50d',
    '263': '09d',
    '266': '09d',
    '281': '09d',
    '284': '09d',
    '293': '09d',
    '296': '09d',
    '299': '10d',
    '302': '10d',
    '305': '10d',
    '308': '10d',
    '311': '09d',
    '314': '09d',
    '317': '13d',
    '320': '13d',
    '323': '13d',
    '326': '13d',
    '329': '13d',
    '332': '13d',
    '335': '13d',
    '338': '13d',
    '350': '50d',
    '353': '09d',
    '356': '10d',
    '359': '10d',
    '362': '09d',
    '365': '09d',
    '368': '13d',
    '371': '13d',
    '374': '13d',
    '377': '13d',
    '386': '11d',
    '389': '11d',
    '392': '11d',
    '395': '13d',
  };

  static String normalize(String? rawCode) {
    if (rawCode == null) {
      return _defaultCode;
    }
    var code = rawCode.trim().toLowerCase();
    if (code.isEmpty) {
      return _defaultCode;
    }
    final mappedFromWmo = _wmoToOpenWeather[code];
    if (mappedFromWmo != null) {
      return mappedFromWmo;
    }
    final mappedFromHeWeather = _heWeatherToOpenWeather[code];
    if (mappedFromHeWeather != null) {
      return mappedFromHeWeather;
    }
    if (_availableCodes.contains(code)) {
      return code;
    }
    if (code.length > 3) {
      code = code.substring(0, 3);
      if (_availableCodes.contains(code)) {
        return code;
      }
    }
    final heCandidate = _heWeatherFallback(code);
    if (heCandidate != null) {
      return heCandidate;
    }
    if (code.endsWith('n')) {
      final dayCode = '${code.substring(0, code.length - 1)}d';
      if (_availableCodes.contains(dayCode)) {
        return dayCode;
      }
    }
    return _defaultCode;
  }

  static String iconAsset(String? code) =>
      'weather_assets/icons/${normalize(code)}.png';

  static String backgroundAsset(String? code) =>
      'weather_assets/images/${normalize(code)}.jpeg';

  static List<Color> gradient(String? code, {required bool isDarkMode}) {
    if (isDarkMode) {
      return const [Color(0xFF2C3E50), Color(0xFF34495E)];
    }
    final normalized = normalize(code);
    if (normalized.startsWith('01')) {
      return const [Color(0xFFFFD700), Color(0xFFFFA500)];
    }
    if (normalized.startsWith('02') ||
        normalized.startsWith('03') ||
        normalized.startsWith('04')) {
      return const [Color(0xFF74B9FF), Color(0xFF0984E3)];
    }
    if (normalized.startsWith('09') || normalized.startsWith('10')) {
      return const [Color(0xFF6C7CE7), Color(0xFF4C63D2)];
    }
    if (normalized.startsWith('11')) {
      return const [Color(0xFF2D3436), Color(0xFF636E72)];
    }
    if (normalized.startsWith('13')) {
      return const [Color(0xFFDDD6FE), Color(0xFFC4B5FD)];
    }
    return const [Color(0xFF74B9FF), Color(0xFF0984E3)];
  }

  static String? _heWeatherFallback(String code) {
    final numeric = int.tryParse(code);
    if (numeric == null) {
      return null;
    }
    final isNight = (numeric % 100) >= 50 && numeric < 900;
    final suffix = isNight ? 'n' : 'd';
    if (numeric >= 100 && numeric < 105) {
      return suffix == 'n' ? '01n' : '01d';
    }
    if (numeric >= 105 && numeric < 200) {
      return suffix == 'n' ? '02n' : '02d';
    }
    if (numeric >= 200 && numeric < 300) {
      return suffix == 'n' ? '11n' : '11d';
    }
    if (numeric >= 300 && numeric < 400) {
      return suffix == 'n' ? '09n' : '09d';
    }
    if (numeric >= 400 && numeric < 500) {
      return suffix == 'n' ? '13n' : '13d';
    }
    if (numeric >= 500 && numeric < 600) {
      return suffix == 'n' ? '50n' : '50d';
    }
    if (numeric >= 600 && numeric < 700) {
      return suffix == 'n' ? '50n' : '50d';
    }
    if (numeric >= 700 && numeric < 800) {
      return suffix == 'n' ? '50n' : '50d';
    }
    return null;
  }
}
