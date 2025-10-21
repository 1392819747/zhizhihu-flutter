import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'search_logic.dart';

class SearchPage extends GetView<SearchLogic> {
  const SearchPage({super.key});

  static const _gradientColors = [
    Color(0xFF5D6CF5),
    Color(0xFF2646F7),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      _buildSearchBar(),
                      Expanded(
                        child: _buildSearchResults(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _gradientColors,
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Search',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1,
                  ),
                ),
                Text(
                  '搜索聊天记录',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
        child: TextField(
          controller: controller.searchController,
          decoration: InputDecoration(
            hintText: '搜索聊天记录...',
            hintStyle: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 16.sp,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: const Color(0xFF9CA3AF),
              size: 20.w,
            ),
            suffixIcon: Obx(() {
              if (controller.searchController.text.isNotEmpty) {
                return IconButton(
                  onPressed: () {
                    controller.searchController.clear();
                    controller.searchResults.clear();
                  },
                  icon: Icon(
                    Icons.clear,
                    color: const Color(0xFF9CA3AF),
                    size: 20.w,
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          ),
          onChanged: (value) {
            controller.performSearch(value);
          },
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return Obx(() {
      if (controller.searchController.text.isEmpty) {
        return _buildEmptyState();
      }
      
      if (controller.searchResults.isEmpty) {
        return _buildNoResults();
      }

      return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: controller.searchResults.length,
        separatorBuilder: (_, __) => SizedBox(height: 8.h),
        itemBuilder: (context, index) {
          final result = controller.searchResults[index];
          return _SearchResultCard(
            result: result,
            onTap: () => controller.openResult(result),
          );
        },
      );
    });
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F7FA),
              borderRadius: BorderRadius.circular(60.r),
            ),
            child: Icon(
              Icons.search,
              size: 60.w,
              color: const Color(0xFF9CA3AF),
            ),
          ),
          24.verticalSpace,
          Text(
            '搜索聊天记录',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF374151),
            ),
          ),
          8.verticalSpace,
          Text(
            '在上方搜索框中输入关键词\n查找你的聊天记录',
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF6B7280),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F7FA),
              borderRadius: BorderRadius.circular(60.r),
            ),
            child: Icon(
              Icons.search_off,
              size: 60.w,
              color: const Color(0xFF9CA3AF),
            ),
          ),
          24.verticalSpace,
          Text(
            '没有找到相关结果',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF374151),
            ),
          ),
          8.verticalSpace,
          Text(
            '尝试使用其他关键词搜索',
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF6B7280),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _SearchResultCard extends StatelessWidget {
  const _SearchResultCard({required this.result, required this.onTap});

  final SearchResult result;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    result.avatarColor,
                    result.avatarColor.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Center(
                child: Text(
                  result.name.characters.first,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            16.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF111827),
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    result.preview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF6B7280),
                      height: 1.4,
                    ),
                  ),
                  8.verticalSpace,
                  Text(
                    result.time,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.w,
              color: const Color(0xFF9CA3AF),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchResult {
  final String name;
  final String preview;
  final String time;
  final Color avatarColor;
  final String conversationId;

  SearchResult({
    required this.name,
    required this.preview,
    required this.time,
    required this.avatarColor,
    required this.conversationId,
  });
}
