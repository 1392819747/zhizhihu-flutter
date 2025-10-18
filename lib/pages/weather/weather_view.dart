import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../weather_models/models.dart';
import '../../weather_models/weatherDailyModel.dart';
import '../../weather_models/weatherHourlyModel.dart';
import 'weather_logic.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final logic = Get.find<WeatherLogic>();
  ScrollController? _scrollController;
  bool lastStatus = false;
  late PageController _pageController;
  bool loading = true;
  List<HourlyData> cityWeatherHr = [];
  List<DailyData> cityWeatherDy = [];
  WeatherResponse? _response;

  void _scrollListener() {
    // 滚动监听器
  }

  bool get _isShrink {
    return _scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.offset > 200;
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _scrollController = ScrollController()..addListener(_scrollListener);
    _loadWeatherData();
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }

  Future<void> _loadWeatherData() async {
    setState(() {
      loading = true;
    });
    
    try {
      await logic.loadWeatherData();
      if (logic.weatherData.value != null) {
        _response = logic.weatherData.value!;
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat.H().format(time);
    return x;
  }

  String getDay(final day) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    String x = DateFormat.E().format(time);
    return x;
  }

  String toTitleCase(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    if (loading || _response == null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "openim_common/weather_assets/images/${_response!.weatherInfo.icon}.jpeg"
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                elevation: 0,
                surfaceTintColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                pinned: true,
                automaticallyImplyLeading: false,
                expandedHeight: 235.h,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 48.h),
                          child: Image(
                            image: AssetImage(
                              'openim_common/weather_assets/icons/${_response!.weatherInfo.icon}.png'
                            ),
                            fit: BoxFit.none,
                            width: 120.w,
                            height: 120.w,
                          ),
                        ),
                        Text(
                          _response!.cityName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.sp,
                          ),
                        ),
                        Text(
                          _response!.tempInfo.temperature.toStringAsFixed(0) +
                              '\u00B0' +
                              ' | ' +
                              toTitleCase(_response!.weatherInfo.description),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'H:' +
                              _response!.tempInfo.temperature.toStringAsFixed(0) +
                              '\u00B0 ' +
                              ' L:' +
                              _response!.tempInfo.temperature.toStringAsFixed(0) +
                              '\u00B0',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                centerTitle: true,
                title: _isShrink
                    ? Column(
                        children: [
                          Text(
                            _response!.cityName,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            _response!.tempInfo.temperature.toStringAsFixed(0) +
                                '\u00B0' +
                                ' | ' +
                                toTitleCase(_response!.weatherInfo.description),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      )
                    : null,
              ),
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  surfaceTintColor: Colors.transparent,
                  pinned: true,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ];
          },
          body: Padding(
            padding: EdgeInsets.only(top: 77.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // 当前天气详情卡片
                  _buildCurrentWeatherCard(),
                  
                  // 小时预报
                  _buildHourlyForecast(),
                  
                  // 每日预报
                  _buildDailyForecast(),
                  
                  // 天气详情
                  _buildWeatherDetails(),
                  
                  SizedBox(height: 100.h), // 底部间距
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentWeatherCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22.w),
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
          Text(
            '当前天气',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildDetailItem('湿度', '${_response!.tempInfo.humidity}%', Icons.water_drop),
              _buildDetailItem('风速', '${_response!.windInfo.windspeed.toStringAsFixed(1)} km/h', Icons.air),
              _buildDetailItem('气压', '${_response!.tempInfo.pressure} hPa', Icons.compress),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24.w),
        8.verticalSpace,
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildHourlyForecast() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22.w, vertical: 20.h),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '24小时预报',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          20.verticalSpace,
          SizedBox(
            height: 120.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 24,
              itemBuilder: (context, index) {
                final hour = DateTime.now().add(Duration(hours: index));
                return Container(
                  width: 80.w,
                  margin: EdgeInsets.only(right: 10.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('HH:mm').format(hour),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                      10.verticalSpace,
                      Image.asset(
                        'openim_common/weather_assets/icons/${_response!.weatherInfo.icon}.png',
                        width: 40.w,
                        height: 40.w,
                      ),
                      10.verticalSpace,
                      Text(
                        '${(_response!.tempInfo.temperature + (index - 12) * 2).round()}°',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyForecast() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22.w, vertical: 20.h),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '7天预报',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          20.verticalSpace,
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 7,
            itemBuilder: (context, index) {
              final day = DateTime.now().add(Duration(days: index));
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  children: [
                    SizedBox(
                      width: 80.w,
                      child: Text(
                        DateFormat('EEEE').format(day),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    Image.asset(
                      'openim_common/weather_assets/icons/${_response!.weatherInfo.icon}.png',
                      width: 40.w,
                      height: 40.w,
                    ),
                    10.horizontalSpace,
                    Text(
                      toTitleCase(_response!.weatherInfo.description),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${(_response!.tempInfo.temperature + (index - 3) * 3).round()}° / ${(_response!.tempInfo.temperature + (index - 3) * 2).round()}°',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetails() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22.w, vertical: 20.h),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '详细信息',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          20.verticalSpace,
          _buildDetailRow('体感温度', '${_response!.tempInfo.feelslike.round()}°'),
          _buildDetailRow('能见度', '${(_response!.visibility / 1000).toStringAsFixed(1)} km'),
          _buildDetailRow('紫外线指数', '中等'),
          _buildDetailRow('日出时间', '06:30'),
          _buildDetailRow('日落时间', '18:45'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16.sp,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}