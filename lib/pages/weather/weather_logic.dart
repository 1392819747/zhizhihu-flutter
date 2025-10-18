import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

import '../../weather_models/models.dart';
import '../../weather_service/dart_service.dart';

class WeatherLogic extends GetxController {
  final isLoading = false.obs;
  final weatherData = Rxn<WeatherResponse>();
  final currentLocation = Rxn<Position>();
  
  final DataService _dataService = DataService();

  @override
  void onInit() {
    super.onInit();
    loadWeatherData();
  }

  Future<void> loadWeatherData() async {
    try {
      isLoading.value = true;
      
      // 获取当前位置
      final position = await _getCurrentPosition();
      if (position != null) {
        currentLocation.value = position;
        
        // 获取天气数据
        final weather = await _dataService.getWeather(
          position.longitude,
          position.latitude,
        );
        
        weatherData.value = weather;
      } else {
        // 如果无法获取位置，使用默认位置（上海）
        final weather = await _dataService.getWeather(121.4737, 31.2304);
        weatherData.value = weather;
      }
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

  Future<Position?> _getCurrentPosition() async {
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
