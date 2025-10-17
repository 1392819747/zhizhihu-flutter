import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';

import '../../routes/app_navigator.dart';
import '../conversation/conversation_logic.dart';

class AppItem {
  final String name;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  AppItem({
    required this.name,
    required this.icon,
    required this.color,
    this.onTap,
  });
}

class DesktopLogic extends GetxController {
  // 夜间模式状态
  final isDarkMode = false.obs;
  final List<AppItem> appList = [
    AppItem(
      name: '社区',
      icon: Icons.chat_bubble_outline,
      color: const Color(0xFF007AFF), // iOS Messages Blue
    ),
    AppItem(
      name: '通讯录',
      icon: Icons.contacts_outlined,
      color: const Color(0xFF34C759), // iOS Contacts Green
    ),
    AppItem(
      name: '发现',
      icon: Icons.explore_outlined,
      color: const Color(0xFFFF9500), // iOS Safari Orange
    ),
    AppItem(
      name: '我的',
      icon: Icons.person_outline,
      color: const Color(0xFF5856D6), // iOS Settings Purple
    ),
    AppItem(
      name: '设置',
      icon: Icons.settings_outlined,
      color: const Color(0xFF8E8E93), // iOS Settings Gray
    ),
    AppItem(
      name: '相册',
      icon: Icons.photo_library_outlined,
      color: const Color(0xFFFF3B30), // iOS Photos Red
    ),
    AppItem(
      name: '相机',
      icon: Icons.camera_alt_outlined,
      color: const Color(0xFF32D74B), // iOS Camera Green
    ),
    AppItem(
      name: '音乐',
      icon: Icons.music_note_outlined,
      color: const Color(0xFFFF2D92), // iOS Music Pink
    ),
    AppItem(
      name: '视频',
      icon: Icons.videocam_outlined,
      color: const Color(0xFF007AFF), // iOS Camera Blue
    ),
    AppItem(
      name: '文件',
      icon: Icons.folder_outlined,
      color: const Color(0xFFFF9500), // iOS Files Orange
    ),
    AppItem(
      name: '日历',
      icon: Icons.calendar_today_outlined,
      color: const Color(0xFF5856D6), // iOS Calendar Purple
    ),
    AppItem(
      name: '备忘录',
      icon: Icons.note_outlined,
      color: const Color(0xFFFFCC00), // iOS Notes Yellow
    ),
  ];

  final List<AppItem> dockApps = [
    AppItem(
      name: '社区',
      icon: Icons.chat_bubble_outline,
      color: const Color(0xFF007AFF), // iOS Messages Blue
    ),
    AppItem(
      name: '通讯录',
      icon: Icons.contacts_outlined,
      color: const Color(0xFF34C759), // iOS Contacts Green
    ),
    AppItem(
      name: '发现',
      icon: Icons.explore_outlined,
      color: const Color(0xFFFF9500), // iOS Safari Orange
    ),
    AppItem(
      name: '我的',
      icon: Icons.person_outline,
      color: const Color(0xFF5856D6), // iOS Settings Purple
    ),
  ];

  void onAppTap(AppItem app) async {
    switch (app.name) {
      case '社区':
        // 进入聊天应用，先获取会话数据
        final conversations = await ConversationLogic.getConversationFirstPage();
        AppNavigator.startMain(conversations: conversations);
        break;
      case '通讯录':
        // 进入通讯录
        AppNavigator.startMain(initialIndex: 1);
        break;
      case '发现':
        // 进入发现页面
        AppNavigator.startMain(initialIndex: 2);
        break;
      case '我的':
        // 进入我的页面
        AppNavigator.startMain(initialIndex: 3);
        break;
      default:
        // 其他应用暂时显示提示
        IMViews.showToast('${app.name}功能开发中');
        break;
    }
  }

  // 获取总页数
  int getPageCount() {
    return (appList.length / 12).ceil(); // 每页12个App (4x3)
  }

  // 获取指定页面的App列表
  List<AppItem> getAppsForPage(int pageIndex) {
    final startIndex = pageIndex * 12;
    final endIndex = (startIndex + 12).clamp(0, appList.length);
    return appList.sublist(startIndex, endIndex);
  }

  // 移动App到指定位置
  void moveAppToPosition(AppItem app, int targetPageIndex, int targetIndex) {
    // 找到当前App的位置
    final currentIndex = appList.indexOf(app);
    if (currentIndex == -1) return;

    // 计算目标位置
    final targetGlobalIndex = targetPageIndex * 12 + targetIndex;
    
    // 如果目标位置超出范围，则添加到末尾
    if (targetGlobalIndex >= appList.length) {
      appList.removeAt(currentIndex);
      appList.add(app);
    } else {
      // 移除原位置的App
      appList.removeAt(currentIndex);
      // 插入到新位置
      appList.insert(targetGlobalIndex, app);
    }
    
    // 刷新UI
    update();
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
}
