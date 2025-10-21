import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'search_page.dart';

class SearchLogic extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxList<SearchResult> searchResults = <SearchResult>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void performSearch(String query) {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    // 模拟搜索功能
    final mockResults = [
      SearchResult(
        name: 'AI助手',
        preview: '你好！我是你的AI助手，有什么可以帮助你的吗？',
        time: '2分钟前',
        avatarColor: const Color(0xFF5D6CF5),
        conversationId: 'ai_assistant',
      ),
      SearchResult(
        name: '工作群',
        preview: '今天的会议安排在下午3点，请大家准时参加',
        time: '1小时前',
        avatarColor: const Color(0xFF10B981),
        conversationId: 'work_group',
      ),
      SearchResult(
        name: '朋友',
        preview: '周末一起去看电影吧！',
        time: '昨天',
        avatarColor: const Color(0xFFF59E0B),
        conversationId: 'friend',
      ),
    ];

    // 过滤包含搜索关键词的结果
    searchResults.value = mockResults.where((result) {
      return result.name.toLowerCase().contains(query.toLowerCase()) ||
             result.preview.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  void openResult(SearchResult result) {
    // 这里可以导航到具体的聊天页面
    Get.snackbar(
      '搜索结果',
      '打开与 ${result.name} 的聊天',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
