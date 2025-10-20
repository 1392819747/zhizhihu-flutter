import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';

import '../../routes/app_navigator.dart';
import '../conversation/conversation_logic.dart';
import '../../weather_models/models.dart';
import '../../weather_service/dart_service.dart';
import '../../services/weather_service.dart';
import 'package:geolocator/geolocator.dart';

class AppItem {
  final String name;
  final IconData? icon;
  final String? iconPath;
  final Color color;
  final VoidCallback? onTap;

  AppItem({
    required this.name,
    this.icon,
    this.iconPath,
    required this.color,
    this.onTap,
  }) : assert(icon != null || iconPath != null, 'Either icon or iconPath must be provided');
}

class DesktopLogic extends GetxController {
  // 夜间模式状态
  final isDarkMode = false.obs;
  
  // PageView控制器
  late PageController pageController;
  
  // 天气数据
  final weatherData = Rxn<WeatherData>();
  final isLoadingWeather = false.obs;
  final WeatherService _weatherService = WeatherService();
  
  // App位置管理：使用Map来存储每个位置的App，null表示空位
  final Map<int, AppItem?> appPositions = {};
  
  final List<AppItem> appList = [
    AppItem(
      name: '社区',
      iconPath: 'packages/openim_common/assets/images/wechat_icon.png',
      color: const Color(0xFF007AFF), // iOS Messages Blue
    ),
    AppItem(
      name: '通讯录',
      iconPath: 'packages/openim_common/assets/images/phone_icon.png',
      color: const Color(0xFF34C759), // iOS Contacts Green
    ),
    AppItem(
      name: '发现',
      iconPath: 'packages/openim_common/assets/images/browser_icon.png',
      color: const Color(0xFFFF9500), // iOS Safari Orange
    ),
    AppItem(
      name: '我的',
      iconPath: 'packages/openim_common/assets/images/mail_icon.png',
      color: const Color(0xFF5856D6), // iOS Settings Purple
    ),
    AppItem(
      name: '设置',
      iconPath: 'packages/openim_common/assets/images/settings_icon.png',
      color: const Color(0xFF8E8E93), // iOS Settings Gray
    ),
    AppItem(
      name: '相册',
      iconPath: 'packages/openim_common/assets/images/photos_icon.png',
      color: const Color(0xFFFF3B30), // iOS Photos Red
    ),
    AppItem(
      name: '相机',
      iconPath: 'packages/openim_common/assets/images/camera_icon.png',
      color: const Color(0xFF32D74B), // iOS Camera Green
    ),
    AppItem(
      name: '音乐',
      iconPath: 'packages/openim_common/assets/images/music_icon.png',
      color: const Color(0xFFFF2D92), // iOS Music Pink
    ),
    AppItem(
      name: '视频',
      iconPath: 'packages/openim_common/assets/images/video_icon.png',
      color: const Color(0xFF007AFF), // iOS Camera Blue
    ),
    AppItem(
      name: '文件',
      iconPath: 'packages/openim_common/assets/images/files_icon.png',
      color: const Color(0xFFFF9500), // iOS Files Orange
    ),
    AppItem(
      name: '日历',
      iconPath: 'packages/openim_common/assets/images/calendar_icon.png',
      color: const Color(0xFF5856D6), // iOS Calendar Purple
    ),
    AppItem(
      name: '备忘录',
      iconPath: 'packages/openim_common/assets/images/notes_icon.png',
      color: const Color(0xFFFFCC00), // iOS Notes Yellow
    ),
    AppItem(
      name: '天气',
      icon: Icons.wb_sunny,
      color: const Color(0xFFFF9500), // iOS Weather Orange
    ),
  ];

  final List<AppItem> dockApps = [
    AppItem(
      name: '社区',
      iconPath: 'packages/openim_common/assets/images/wechat_icon.png',
      color: const Color(0xFF007AFF), // iOS Messages Blue
    ),
    AppItem(
      name: '通讯录',
      iconPath: 'packages/openim_common/assets/images/phone_icon.png',
      color: const Color(0xFF34C759), // iOS Contacts Green
    ),
    AppItem(
      name: '发现',
      iconPath: 'packages/openim_common/assets/images/browser_icon.png',
      color: const Color(0xFFFF9500), // iOS Safari Orange
    ),
    AppItem(
      name: '我的',
      iconPath: 'packages/openim_common/assets/images/mail_icon.png',
      color: const Color(0xFF5856D6), // iOS Settings Purple
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    _initializeAppPositions();
    _loadWeatherData();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  // 初始化App位置
  void _initializeAppPositions() {
    appPositions.clear();
    for (int i = 0; i < appList.length; i++) {
      appPositions[i] = appList[i];
    }
  }

  void onAppTap(AppItem app) async {
    switch (app.name) {
      case '社区':
        // 进入聊天应用，先获取会话数据
        final conversations = await ConversationLogic.getConversationFirstPage();
        AppNavigator.startMain(conversations: conversations);
        break;
      case '天气':
        // 打开天气应用
        AppNavigator.startWeather();
        break;
      default:
        // 其他应用暂时显示提示
        IMViews.showToast('${app.name}功能开发中');
        break;
    }
  }

  // 获取总页数
  int getPageCount() {
    // 确保至少有1页
    final totalApps = appList.length;
    return (totalApps / 12).ceil().clamp(1, 10); // 每页12个App (4x3)，最多10页
  }

  // 获取指定页面的App列表
  List<AppItem?> getAppsForPage(int pageIndex) {
    final List<AppItem?> pageApps = [];
    final startIndex = pageIndex * 12;
    final endIndex = startIndex + 12;
    
    for (int i = startIndex; i < endIndex; i++) {
      pageApps.add(appPositions[i]);
    }
    
    return pageApps;
  }

  // 移动App到指定位置
  void moveAppToPosition(AppItem app, int targetPageIndex, int targetIndex) {
    print('移动App: ${app.name} 到页面: $targetPageIndex, 位置: $targetIndex');
    
    // 找到当前App的位置
    int? currentIndex;
    for (var entry in appPositions.entries) {
      if (entry.value == app) {
        currentIndex = entry.key;
        break;
      }
    }
    
    if (currentIndex == null) {
      print('未找到App: ${app.name}');
      return;
    }

    // 计算目标位置
    final targetGlobalIndex = targetPageIndex * 12 + targetIndex;
    print('当前位置: $currentIndex, 目标位置: $targetGlobalIndex');
    
    // 如果目标位置有App，先保存它
    AppItem? targetApp = appPositions[targetGlobalIndex];
    
    // 移除原位置的App
    appPositions[currentIndex] = null;
    
    // 如果目标位置有App，交换位置
    if (targetApp != null) {
      appPositions[targetGlobalIndex] = app;
      appPositions[currentIndex] = targetApp;
      print('交换位置: ${app.name} <-> ${targetApp.name}');
    } else {
      // 目标位置为空，直接放置
      appPositions[targetGlobalIndex] = app;
      print('移动到空位: $targetGlobalIndex');
    }
    
    // 刷新UI
    update();
    print('App位置更新完成');
  }

  // 切换夜间模式
  void toggleDarkMode() {
    isDarkMode.value = !isDarkMode.value;
  }

  // 获取当前主题颜色
  Color getBackgroundColor() {
    return isDarkMode.value ? const Color(0xFF1C1C1E) : Colors.transparent;
  }

  // 获取文本颜色
  Color getTextColor() {
    return isDarkMode.value ? Colors.white : Colors.white;
  }

  // 获取小组件背景颜色
  Color getWidgetBackgroundColor() {
    return isDarkMode.value 
        ? Colors.white.withOpacity(0.1) 
        : Colors.white.withOpacity(0.2);
  }

  // 获取边框颜色
  Color getBorderColor() {
    return isDarkMode.value 
        ? Colors.white.withOpacity(0.2) 
        : Colors.white.withOpacity(0.3);
  }

  // 天气小组件点击事件
  void onWeatherWidgetTap() {
    AppNavigator.startWeather();
  }

  // 加载天气数据
  Future<void> _loadWeatherData() async {
    try {
      isLoadingWeather.value = true;
      
      // 尝试获取当前位置
      final position = await _weatherService.getCurrentPosition();
      WeatherData? weather;
      
      if (position != null) {
        // 使用当前位置获取天气
        weather = await _weatherService.getWeatherByLocation(
          position.latitude, 
          position.longitude
        );
      }
      
      // 如果获取当前位置失败，使用默认位置（上海）
      if (weather == null) {
        weather = await _weatherService.getWeatherByLocation(31.2304, 121.4737);
      }
      
      weatherData.value = weather;
    } catch (e) {
      print('加载天气数据失败: $e');
    } finally {
      isLoadingWeather.value = false;
    }
  }

  // 获取当前城市名称
  String getCurrentCityName() {
    if (weatherData.value != null) {
      return weatherData.value!.cityName;
    }
    return '上海';
  }

  // 获取当前温度
  String getCurrentTemperature() {
    if (weatherData.value != null) {
      return weatherData.value!.temperatureText;
    }
    return '27°';
  }

  // 获取当前天气描述
  String getCurrentWeatherDescription() {
    if (weatherData.value != null) {
      return weatherData.value!.description;
    }
    return '多云';
  }

  // 获取最高温度
  String getHighTemperature() {
    if (weatherData.value != null) {
      return '${weatherData.value!.maxTemp.round()}°';
    }
    return '34°';
  }

  // 获取最低温度
  String getLowTemperature() {
    if (weatherData.value != null) {
      return '${weatherData.value!.minTemp.round()}°';
    }
    return '24°';
  }

  // 获取体感温度
  String getFeelsLikeTemperature() {
    if (weatherData.value != null) {
      return '${weatherData.value!.feelsLike.round()}';
    }
    return '29';
  }

  // 获取天气图标路径
  String getWeatherIconPath() {
    if (weatherData.value != null) {
      return 'weather_assets/icons/${weatherData.value!.icon}.png';
    }
    return 'weather_assets/icons/02d.png';
  }

  // 获取天气渐变背景颜色
  List<Color> getWeatherGradientColors() {
    if (isDarkMode.value) {
      return [
        const Color(0xFF2C3E50),
        const Color(0xFF34495E),
      ];
    } else {
      // 根据天气状况返回不同的渐变颜色
      if (weatherData.value != null) {
        final weatherIcon = weatherData.value!.icon;
        if (weatherIcon.contains('01')) {
          // 晴天
          return [const Color(0xFFFFD700), const Color(0xFFFFA500)];
        } else if (weatherIcon.contains('02') || weatherIcon.contains('03') || weatherIcon.contains('04')) {
          // 多云
          return [const Color(0xFF74B9FF), const Color(0xFF0984E3)];
        } else if (weatherIcon.contains('09') || weatherIcon.contains('10')) {
          // 雨天
          return [const Color(0xFF6C7CE7), const Color(0xFF4C63D2)];
        } else if (weatherIcon.contains('11')) {
          // 雷雨
          return [const Color(0xFF2D3436), const Color(0xFF636E72)];
        } else if (weatherIcon.contains('13')) {
          // 雪天
          return [const Color(0xFFDDD6FE), const Color(0xFFC4B5FD)];
        } else {
          // 默认
          return [const Color(0xFF74B9FF), const Color(0xFF0984E3)];
        }
      }
      return [const Color(0xFF74B9FF), const Color(0xFF0984E3)];
    }
  }
}
