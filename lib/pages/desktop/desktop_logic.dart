import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';

import '../../routes/app_navigator.dart';

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
  final List<AppItem> appList = [
    AppItem(
      name: '社区',
      icon: Icons.chat_bubble_outline,
      color: const Color(0xFF007AFF),
    ),
    AppItem(
      name: '通讯录',
      icon: Icons.contacts_outlined,
      color: const Color(0xFF34C759),
    ),
    AppItem(
      name: '发现',
      icon: Icons.explore_outlined,
      color: const Color(0xFFFF9500),
    ),
    AppItem(
      name: '我的',
      icon: Icons.person_outline,
      color: const Color(0xFF5856D6),
    ),
    AppItem(
      name: '设置',
      icon: Icons.settings_outlined,
      color: const Color(0xFF8E8E93),
    ),
    AppItem(
      name: '相册',
      icon: Icons.photo_library_outlined,
      color: const Color(0xFFFF3B30),
    ),
    AppItem(
      name: '相机',
      icon: Icons.camera_alt_outlined,
      color: const Color(0xFF32D74B),
    ),
    AppItem(
      name: '音乐',
      icon: Icons.music_note_outlined,
      color: const Color(0xFFFF2D92),
    ),
    AppItem(
      name: '视频',
      icon: Icons.videocam_outlined,
      color: const Color(0xFF007AFF),
    ),
    AppItem(
      name: '文件',
      icon: Icons.folder_outlined,
      color: const Color(0xFFFF9500),
    ),
    AppItem(
      name: '日历',
      icon: Icons.calendar_today_outlined,
      color: const Color(0xFF5856D6),
    ),
    AppItem(
      name: '备忘录',
      icon: Icons.note_outlined,
      color: const Color(0xFFFFCC00),
    ),
  ];

  final List<AppItem> dockApps = [
    AppItem(
      name: '社区',
      icon: Icons.chat_bubble_outline,
      color: const Color(0xFF007AFF),
    ),
    AppItem(
      name: '通讯录',
      icon: Icons.contacts_outlined,
      color: const Color(0xFF34C759),
    ),
    AppItem(
      name: '发现',
      icon: Icons.explore_outlined,
      color: const Color(0xFFFF9500),
    ),
    AppItem(
      name: '我的',
      icon: Icons.person_outline,
      color: const Color(0xFF5856D6),
    ),
  ];

  void onAppTap(AppItem app) {
    switch (app.name) {
      case '社区':
        // 进入聊天应用
        AppNavigator.startMain();
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
}
