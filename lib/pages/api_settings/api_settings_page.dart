import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:openim_common/openim_common.dart';

import '../../data/models/api_provider.dart';
import '../../domain/entities/api_entities.dart';
import '../../services/api_settings_service.dart';
import 'api_settings_logic.dart';

class ApiSettingsPage extends StatefulWidget {
  const ApiSettingsPage({super.key});

  @override
  State<ApiSettingsPage> createState() => _ApiSettingsPageState();
}

class _ApiSettingsPageState extends State<ApiSettingsPage> {
  late final ApiSettingsLogic controller;
  late final ApiSettingsService service;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ApiSettingsLogic>();
    service = controller.service;
  }

  @override
  Widget build(BuildContext context) {
    final theme = TDTheme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // 浅灰色背景
      body: SafeArea(
        child: Column(
          children: [
            // 顶部导航栏
            _buildAppBar(context, theme),
            // 主要内容区域
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 选择API配置区域
                    _buildConfigSelector(context, theme),
                    SizedBox(height: 24.h),
                    // 当前配置详情区域
                    _buildConfigDetails(context, theme),
                    SizedBox(height: 24.h),
                    // 操作按钮区域
                    _buildActionButtons(context, theme),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, TDThemeData theme) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 32.w,
              height: 32.w,
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 16,
                color: Color(0xFF333333),
              ),
            ),
          ),
          Expanded(
            child: Text(
              'AI服务配置',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF333333),
              ),
            ),
          ),
          SizedBox(width: 32.w), // 占位，保持标题居中
        ],
      ),
    );
  }

  Widget _buildConfigSelector(BuildContext context, TDThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '选择API配置',
          style: TextStyle(
            fontSize: 14.sp,
            color: const Color(0xFF666666),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12.h),
        Obx(() {
          final selectedEndpoint = service.selectedEndpoint;
          return GestureDetector(
            onTap: () => _showConfigPicker(context),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: const Color(0xFFE5E5EA),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  // 左侧图标和文字
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 24.w,
                          height: 24.w,
                          decoration: const BoxDecoration(
                            color: Color(0xFF34C759),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.auto_awesome,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedEndpoint?.name ?? '默认 OpenAI配置',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF333333),
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                selectedEndpoint != null
                                    ? '${selectedEndpoint.type == ApiProviderType.openai ? 'OpenAI' : 'Google Gemini'} - ${selectedEndpoint.model}'
                                    : 'OpenAI - gpt-3.5-turbo',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: const Color(0xFF999999),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 右侧选中状态和箭头
                  Row(
                    children: [
                      Container(
                        width: 20.w,
                        height: 20.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFF34C759),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: Color(0xFF999999),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildConfigDetails(BuildContext context, TDThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '当前配置详情',
          style: TextStyle(
            fontSize: 14.sp,
            color: const Color(0xFF666666),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12.h),
        Obx(() {
          final selectedEndpoint = service.selectedEndpoint;
          if (selectedEndpoint == null) {
            return _buildEmptyConfigCard(context);
          }
          return _buildConfigCard(context, selectedEndpoint);
        }),
      ],
    );
  }

  Widget _buildEmptyConfigCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFE5E5EA),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 24.w,
                height: 24.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF34C759),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  size: 14,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '默认 OpenAI配置',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF333333),
                      ),
                    ),
                    Text(
                      'OpenAI',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF999999),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 20.w,
                height: 20.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF34C759),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 12,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildConfigDetailRow('模型', 'gpt-3.5-turbo'),
          SizedBox(height: 12.h),
          _buildConfigDetailRow('温度', '0.7'),
          SizedBox(height: 12.h),
          _buildConfigDetailRow('基础 URL', 'https://api.openai.com/v1'),
          SizedBox(height: 12.h),
          _buildConfigDetailRow('多条发送开关', '', isSwitch: true, onSwitchChanged: (value) {
            // 默认配置的开关切换逻辑
          }),
        ],
      ),
    );
  }

  Widget _buildConfigCard(BuildContext context, ApiEndpoint endpoint) {
    final config = endpoint.generationConfig;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFE5E5EA),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 24.w,
                height: 24.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF34C759),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  size: 14,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      endpoint.name,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF333333),
                      ),
                    ),
                    Text(
                      endpoint.type == ApiProviderType.openai ? 'OpenAI' : 'Google Gemini',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF999999),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 20.w,
                height: 20.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF34C759),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 12,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildConfigDetailRow('模型', endpoint.model.isEmpty ? '未指定' : endpoint.model),
          SizedBox(height: 12.h),
          _buildConfigDetailRow('温度', config.temperature.toStringAsFixed(1)),
          SizedBox(height: 12.h),
          _buildConfigDetailRow('基础 URL', endpoint.baseUrl),
          SizedBox(height: 12.h),
          _buildConfigDetailRow('多条发送开关', '', isSwitch: true, switchValue: config.stream, onSwitchChanged: (value) {
            controller.updateStreamSetting(endpoint, value);
          }),
        ],
      ),
    );
  }

  Widget _buildConfigDetailRow(String label, String value, {bool isSwitch = false, bool? switchValue, ValueChanged<bool>? onSwitchChanged}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: const Color(0xFF666666),
          ),
        ),
        if (isSwitch)
          Switch(
            value: switchValue ?? false,
            onChanged: onSwitchChanged ?? (value) {
              // 默认开关切换逻辑
            },
            activeColor: const Color(0xFF34C759),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          )
        else
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF333333),
            ),
          ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, TDThemeData theme) {
    return Column(
      children: [
        // 添加新配置按钮
        GestureDetector(
          onTap: () => controller.addOrEditEndpoint(),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Text(
              '添加新配置',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xFF007AFF),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        // 管理所有配置按钮
        GestureDetector(
          onTap: () => _showAllConfigs(context),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: const Color(0xFFE5E5EA),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '管理所有配置',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xFF333333),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Color(0xFF999999),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showConfigPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: const Color(0xFFE5E5EA),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Text(
                    '选择配置',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF333333),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: service.endpoints.length,
                itemBuilder: (context, index) {
                  final endpoint = service.endpoints[index];
                  final isSelected = service.selectedEndpointId.value == endpoint.id;
                  return ListTile(
                    leading: Container(
                      width: 24.w,
                      height: 24.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF34C759),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      endpoint.name,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF333333),
                      ),
                    ),
                    subtitle: Text(
                      '${endpoint.type == ApiProviderType.openai ? 'OpenAI' : 'Google Gemini'} - ${endpoint.model}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF999999),
                      ),
                    ),
                    trailing: isSelected
                        ? Container(
                            width: 20.w,
                            height: 20.w,
                            decoration: const BoxDecoration(
                              color: Color(0xFF34C759),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 12,
                              color: Colors.white,
                            ),
                          )
                        : null,
                    onTap: () {
                      controller.setDefaultEndpoint(endpoint.id);
                      Navigator.pop(context);
                    },
                  );
                },
              );
            }),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  void _showAllConfigs(BuildContext context) {
    // 这里可以导航到完整的管理页面，或者显示一个更详细的管理界面
    // 暂时显示一个提示，后续可以实现完整的管理页面
    IMViews.showToast('管理功能开发中...');
  }
}
