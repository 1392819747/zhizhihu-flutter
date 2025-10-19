import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

import '../../weather_models/models.dart';
import '../../weather_service/dart_service.dart';
import '../../services/weather_service.dart';

class WeatherLogic extends GetxController {
  final isLoading = false.obs;
  final weatherData = Rxn<WeatherData>();
  final currentLocation = Rxn<Position>();
  
  final WeatherService _weatherService = WeatherService();

  @override
  void onInit() {
    super.onInit();
    loadWeatherData();
  }

  Future<void> loadWeatherData() async {
    try {
      isLoading.value = true;
      
      // 获取当前位置
      final position = await _weatherService.getCurrentPosition();
      WeatherData? weather;
      
      if (position != null) {
        currentLocation.value = position;
        
        // 获取天气数据
        weather = await _weatherService.getWeatherByLocation(
          position.latitude,
          position.longitude,
        );
      }
      
      // 如果获取当前位置失败，使用默认位置（上海）
      if (weather == null) {
        weather = await _weatherService.getWeatherByLocation(31.2304, 121.4737);
      }
      
      weatherData.value = weather;
    } catch (e) {
      print('加载天气数据失败: $e');
      // 显示错误提示
      Get.snackbar(
        '错误',
        '无法加载天气数据，请检查网络连接',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }


  String getWeatherIcon(String weatherCondition) {
    switch (weatherCondition.toLowerCase()) {
      case 'clear':
        return '01d';
      case 'clouds':
        return '02d';
      case 'rain':
        return '10d';
      case 'snow':
        return '13d';
      case 'thunderstorm':
        return '11d';
      case 'drizzle':
        return '09d';
      case 'mist':
      case 'fog':
        return '50d';
      default:
        return '01d';
    }
  }

  String getWeatherDescription(String weatherCondition) {
    switch (weatherCondition.toLowerCase()) {
      case 'clear':
        return '晴朗';
      case 'clouds':
        return '多云';
      case 'rain':
        return '下雨';
      case 'snow':
        return '下雪';
      case 'thunderstorm':
        return '雷暴';
      case 'drizzle':
        return '毛毛雨';
      case 'mist':
      case 'fog':
        return '雾';
      default:
        return '未知';
    }
  }
}
