import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../services/api_settings_service.dart';
import 'api_settings_logic.dart';

class ApiSettingsPage extends GetView<ApiSettingsLogic> {
  const ApiSettingsPage({super.key});

  ApiSettingsService get _service => controller.service;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFFF2F2F7),
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'API 设置',
          style: TextStyle(color: Color(0xFF1C1C1E)),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: SizedBox(
              width: 36.w,
              height: 36.w,
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => controller.addOrEditEndpoint(),
                child: const Icon(
                  CupertinoIcons.add_circled,
                  color: Color(0xFF007AFF),
                  size: 28,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(child: _buildEndpointSection()),
    );
  }

  Widget _buildEndpointSection() {
    return Obx(() {
      final endpoints = _service.endpoints;
      if (endpoints.isEmpty) {
        return _buildEmptyHint();
      }
      return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        itemCount: endpoints.length,
        itemBuilder: (context, index) {
          final endpoint = endpoints[index];
          final isSelected = _service.selectedEndpointId.value == endpoint.id;
          return Padding(
            padding: EdgeInsets.only(bottom: index == endpoints.length - 1 ? 0 : 12.h),
            child: _EndpointCard(
              endpoint: endpoint,
              isSelected: isSelected,
              onTap: () => _showEndpointActions(endpoint, isSelected),
            ),
          );
        },
      );
    });
  }

  void _showEndpointActions(ApiEndpoint endpoint, bool isSelected) {
    final theme = CupertinoTheme.of(Get.context!);
    showCupertinoModalPopup(
      context: Get.context!,
      builder: (_) => CupertinoActionSheet(
        title: Text(endpoint.name, style: theme.textTheme.textStyle),
        message: Text(endpoint.baseUrl, style: theme.textTheme.textStyle.copyWith(fontSize: 13)),
        actions: [
          if (!isSelected)
            CupertinoActionSheetAction(
              onPressed: () {
                Get.back();
                controller.setDefaultEndpoint(endpoint.id);
              },
              child: const Text('设为当前接口'),
            ),
          CupertinoActionSheetAction(
            onPressed: () {
              Get.back();
              controller.addOrEditEndpoint(endpoint: endpoint);
            },
            child: const Text('编辑'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Get.back();
              controller.removeEndpoint(endpoint);
            },
            child: const Text('删除'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Get.back(),
          child: const Text('取消'),
        ),
      ),
    );
  }

  Widget _buildEmptyHint() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(CupertinoIcons.cloud, size: 56.w, color: Colors.grey.shade400),
            SizedBox(height: 16.h),
            Text('尚未配置接口', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 8.h),
            Text(
              '点击右上角 “+” 即可添加 OpenAI / Gemini 网关，接入自建代理或官方服务。',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}

class _EndpointCard extends StatelessWidget {
  const _EndpointCard({
    required this.endpoint,
    required this.isSelected,
    required this.onTap,
  });

  final ApiEndpoint endpoint;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    endpoint.name,
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1C1C1E),
                    ),
                  ),
                ),
                if (isSelected)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0x1F34C759),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.check_mark_circled_solid, size: 16, color: Color(0xFF34C759)),
                        4.horizontalSpace,
                        Text(
                          '当前使用',
                          style: TextStyle(fontSize: 12.sp, color: const Color(0xFF34C759)),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                _buildTag(endpoint.type == ApiProviderType.openai ? 'OpenAI 兼容' : 'Google Gemini'),
                _buildTag(endpoint.model.isEmpty ? '未指定模型' : endpoint.model),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              endpoint.baseUrl,
              style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade600),
            ),
            if (endpoint.notes.isNotEmpty) ...[
              SizedBox(height: 8.h),
              Text(
                endpoint.notes,
                style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade700),
              ),
            ],
            SizedBox(height: 12.h),
            Container(
              height: 1,
              color: Colors.grey.shade200,
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFootnote('轻点查看操作', CupertinoIcons.hand_point_right),
                Icon(CupertinoIcons.chevron_down, size: 18.w, color: Colors.grey.shade500),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E5EA),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 11.sp, color: const Color(0xFF3C3C43)),
      ),
    );
  }

  Widget _buildFootnote(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade500),
        6.horizontalSpace,
        Text(
          text,
          style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade500),
        ),
      ],
    );
  }
}
