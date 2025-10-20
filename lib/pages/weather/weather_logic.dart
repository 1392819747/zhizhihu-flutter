import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:openim_common/openim_common.dart';

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
      Logger.print('加载天气数据失败: $e', onlyConsole: true);
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
}
