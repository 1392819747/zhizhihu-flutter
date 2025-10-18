import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:openim_common/openim_common.dart';

import '../../weather_models/models.dart';
import '../../weather_service/dart_service.dart';
import 'weather_logic.dart';

class WeatherPage extends StatelessWidget {
  final logic = Get.find<WeatherLogic>();

  WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        if (logic.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }

        if (logic.weatherData.value == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_off,
                  size: 80.w,
                  color: Colors.white54,
                ),
                20.verticalSpace,
                Text(
                  '无法获取天气数据',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 18.sp,
                  ),
                ),
                20.verticalSpace,
                ElevatedButton(
                  onPressed: () => logic.loadWeatherData(),
                  child: const Text('重试'),
                ),
              ],
            ),
          );
        }

        return _buildWeatherContent();
      }),
    );
  }

  Widget _buildWeatherContent() {
    final weather = logic.weatherData.value!;
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            _getWeatherColor(weather.weather[0].main),
            _getWeatherColor(weather.weather[0].main).withOpacity(0.8),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // 顶部导航栏
            _buildTopBar(),
            
            // 主要内容
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 主要天气信息
                    _buildMainWeatherInfo(weather),
                    
                    40.verticalSpace,
                    
                    // 详细信息卡片
                    _buildDetailCards(weather),
                    
                    40.verticalSpace,
                    
                    // 未来几天预报
                    _buildForecastSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20.w,
              ),
            ),
          ),
          20.horizontalSpace,
          Text(
            '天气',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => logic.loadWeatherData(),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                Icons.refresh,
                color: Colors.white,
                size: 20.w,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainWeatherInfo(WeatherResponse weather) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          // 城市名称
          Text(
            weather.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 32.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
          
          20.verticalSpace,
          
          // 温度
          Text(
            '${weather.main.temp.round()}°',
            style: TextStyle(
              color: Colors.white,
              fontSize: 120.sp,
              fontWeight: FontWeight.w100,
            ),
          ),
          
          10.verticalSpace,
          
          // 天气描述
          Text(
            weather.weather[0].description.capitalize(),
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          
          20.verticalSpace,
          
          // 体感温度
          Text(
            '体感温度 ${weather.main.feelsLike.round()}°',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCards(WeatherResponse weather) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          // 第一行卡片
          Row(
            children: [
              Expanded(
                child: _buildDetailCard(
                  '湿度',
                  '${weather.main.humidity}%',
                  Icons.water_drop,
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: _buildDetailCard(
                  '风速',
                  '${weather.wind.speed.toStringAsFixed(1)} m/s',
                  Icons.air,
                ),
              ),
            ],
          ),
          
          10.verticalSpace,
          
          // 第二行卡片
          Row(
            children: [
              Expanded(
                child: _buildDetailCard(
                  '气压',
                  '${weather.main.pressure} hPa',
                  Icons.compress,
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: _buildDetailCard(
                  '能见度',
                  '${weather.visibility / 1000} km',
                  Icons.visibility,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white.withOpacity(0.8),
            size: 24.w,
          ),
          8.verticalSpace,
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          4.verticalSpace,
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForecastSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '未来几天',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          20.verticalSpace,
          // 这里可以添加未来几天的预报
          Text(
            '预报功能开发中...',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }

  Color _getWeatherColor(String weatherCondition) {
    switch (weatherCondition.toLowerCase()) {
      case 'clear':
        return const Color(0xFF87CEEB); // 天蓝色
      case 'clouds':
        return const Color(0xFF708090); // 石板灰
      case 'rain':
        return const Color(0xFF4682B4); // 钢蓝色
      case 'snow':
        return const Color(0xFFE6E6FA); // 薰衣草色
      case 'thunderstorm':
        return const Color(0xFF2F4F4F); // 深石板灰
      case 'drizzle':
        return const Color(0xFF6495ED); // 矢车菊蓝
      case 'mist':
      case 'fog':
        return const Color(0xFFD3D3D3); // 浅灰色
      default:
        return const Color(0xFF87CEEB); // 默认天蓝色
    }
  }
}
