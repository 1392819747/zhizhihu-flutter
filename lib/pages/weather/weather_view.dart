import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'weather_logic.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<WeatherLogic>();
    
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: Obx(() {
        if (logic.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }
        
        if (logic.weatherData.value == null) {
          return const Center(
            child: Text(
              '无法加载天气数据',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          );
        }
        
        final weather = logic.weatherData.value!;
        final fallbackIconCode = weather.icon.contains('n') ? '02n' : '02d';
        
        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'weather_assets/images/${weather.icon}.jpeg',
                package: 'openim_common',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Image.asset(
                    'weather_assets/images/$fallbackIconCode.jpeg',
                    package: 'openim_common',
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
            Positioned.fill(
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      elevation: 0,
                      surfaceTintColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      pinned: true,
                      automaticallyImplyLeading: false,
                      expandedHeight: 300.h,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background: SafeArea(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 48.h),
                                child: Image.asset(
                                  'weather_assets/icons/${weather.icon}.png',
                                  package: 'openim_common',
                                  fit: BoxFit.none,
                                  width: 120.w,
                                  height: 120.w,
                                  errorBuilder: (_, __, ___) {
                                    return Image.asset(
                                      'weather_assets/icons/$fallbackIconCode.png',
                                      package: 'openim_common',
                                      fit: BoxFit.none,
                                      width: 120.w,
                                      height: 120.w,
                                    );
                                  },
                                ),
                              ),
                              Text(
                                weather.cityName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.sp,
                                ),
                              ),
                              Text(
                                '${weather.temperature.round()}° | ${weather.description}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '体感温度 ${weather.feelsLike.round()}°',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                    ),
                  ),
                  child: Column(
                    children: [
                      // 天气详情卡片
                      Container(
                        margin: EdgeInsets.all(20.w),
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildWeatherDetail(
                                  '湿度',
                                  '${weather.humidity.round()}%',
                                  Icons.water_drop,
                                ),
                                _buildWeatherDetail(
                                  '风速',
                                  '${weather.windSpeed.toStringAsFixed(1)} km/h',
                                  Icons.air,
                                ),
                                _buildWeatherDetail(
                                  '气压',
                                  '${weather.pressure} hPa',
                                  Icons.compress,
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildWeatherDetail(
                                  '最高温度',
                                  '${weather.maxTemp.round()}°',
                                  Icons.arrow_upward,
                                ),
                                _buildWeatherDetail(
                                  '最低温度',
                                  '${weather.minTemp.round()}°',
                                  Icons.arrow_downward,
                                ),
                                _buildWeatherDetail(
                                  '日出',
                                  _formatTime(weather.sunrise),
                                  Icons.wb_sunny,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // 日落时间
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.wb_twilight,
                              color: Colors.white.withOpacity(0.8),
                              size: 24.w,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              '日落时间 ${_formatTime(weather.sunset)}',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
  
  Widget _buildWeatherDetail(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white.withOpacity(0.8),
          size: 24.w,
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
  
  String _formatTime(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('HH:mm').format(dateTime);
  }
}
