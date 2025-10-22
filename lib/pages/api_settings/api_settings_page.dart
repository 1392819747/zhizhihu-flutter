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
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            // 顶部拖拽条和标题
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              ),
              child: Column(
                children: [
                  Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E5EA),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFF34C759),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.settings,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          '管理所有配置',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF333333),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 28.w,
                          height: 28.w,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE5E5EA),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 16,
                            color: Color(0xFF666666),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // 配置列表
            Expanded(
              child: Obx(() {
                final endpoints = service.endpoints;
                if (endpoints.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80.w,
                          height: 80.w,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF5F5F5),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.api,
                            size: 40,
                            color: Color(0xFF999999),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          '暂无配置',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF666666),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          '点击下方按钮添加第一个配置',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xFF999999),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: endpoints.length,
                  itemBuilder: (context, index) {
                    final endpoint = endpoints[index];
                    final isSelected = service.selectedEndpointId.value == endpoint.id;
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: _buildConfigManagementCard(context, endpoint, isSelected),
                    );
                  },
                );
              }),
            ),
            // 底部添加按钮
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: const Color(0xFFE5E5EA),
                    width: 1,
                  ),
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  controller.addOrEditEndpoint();
                },
                child: Container(
                  width: double.infinity,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF34C759),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add,
                        size: 20,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '添加新配置',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfigManagementCard(BuildContext context, ApiEndpoint endpoint, bool isSelected) {
    final config = endpoint.generationConfig;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isSelected ? const Color(0xFF34C759) : const Color(0xFFE5E5EA),
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 顶部标题和状态
          Row(
            children: [
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  color: endpoint.type == ApiProviderType.openai 
                      ? const Color(0xFF34C759) 
                      : const Color(0xFF4285F4),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  endpoint.type == ApiProviderType.openai 
                      ? Icons.auto_awesome 
                      : Icons.cloud,
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
                    SizedBox(height: 4.h),
                    Text(
                      '${endpoint.type == ApiProviderType.openai ? 'OpenAI' : 'Google Gemini'} - ${endpoint.model.isEmpty ? '未指定模型' : endpoint.model}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF999999),
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF34C759),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    '当前使用',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          // 配置详情
          _buildConfigInfoRow('基础 URL', endpoint.baseUrl),
          SizedBox(height: 8.h),
          _buildConfigInfoRow('温度', config.temperature.toStringAsFixed(1)),
          SizedBox(height: 8.h),
          _buildConfigInfoRow('最大令牌', '${config.maxTokens}'),
          SizedBox(height: 8.h),
          _buildConfigInfoRow('流式输出', config.stream ? '开启' : '关闭'),
          if (endpoint.notes.isNotEmpty) ...[
            SizedBox(height: 8.h),
            _buildConfigInfoRow('备注', endpoint.notes),
          ],
          SizedBox(height: 16.h),
          // 操作按钮
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.addOrEditEndpoint(endpoint: endpoint),
                  child: Container(
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: const Color(0xFFE5E5EA),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '编辑',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFF333333),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: GestureDetector(
                  onTap: () => _showConfigActions(context, endpoint, isSelected),
                  child: Container(
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: const Color(0xFFE5E5EA),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '更多',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFF333333),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              if (!isSelected)
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.setDefaultEndpoint(endpoint.id);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 36.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF34C759),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: Text(
                          '设为当前',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConfigInfoRow(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 80.w,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xFF666666),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xFF333333),
            ),
          ),
        ),
      ],
    );
  }

  void _showConfigActions(BuildContext context, ApiEndpoint endpoint, bool isSelected) {
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
              child: Text(
                endpoint.name,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF333333),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            if (!isSelected)
              ListTile(
                leading: const Icon(Icons.check_circle, color: Color(0xFF34C759)),
                title: const Text('设为当前配置'),
                onTap: () {
                  Navigator.pop(context);
                  controller.setDefaultEndpoint(endpoint.id);
                },
              ),
            ListTile(
              leading: const Icon(Icons.edit, color: Color(0xFF007AFF)),
              title: const Text('编辑配置'),
              onTap: () {
                Navigator.pop(context);
                controller.addOrEditEndpoint(endpoint: endpoint);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tune, color: Color(0xFFFF9500)),
              title: const Text('生成参数'),
              onTap: () {
                Navigator.pop(context);
                controller.editGenerationConfig(endpoint);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Color(0xFF5856D6)),
              title: const Text('功能开关'),
              onTap: () {
                Navigator.pop(context);
                controller.editEnabledFunctions(endpoint);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Color(0xFFFF3B30)),
              title: const Text('删除配置'),
              onTap: () {
                Navigator.pop(context);
                controller.removeEndpoint(endpoint);
              },
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
