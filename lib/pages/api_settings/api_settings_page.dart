import 'package:characters/characters.dart';
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('API 设置'),
          bottom: const TabBar(
            tabs: [
              Tab(text: '接口配置'),
              Tab(text: 'AI 角色'),
            ],
          ),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'endpoint':
                    controller.addOrEditEndpoint();
                    break;
                  case 'character':
                    controller.addOrEditCharacter();
                    break;
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'endpoint', child: Text('新增接口')), 
                PopupMenuItem(value: 'character', child: Text('新增 AI 角色')),
              ],
            ),
          ],
        ),
        body: TabBarView(
          children: [
            _buildEndpointTab(),
            _buildCharacterTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildEndpointTab() {
    return Obx(() {
      final endpoints = _service.endpoints;
      if (endpoints.isEmpty) {
        return _buildEmptyHint(
          icon: Icons.cloud_outlined,
          title: '尚未配置接口',
          description: '点击右上角 “新增接口” 按钮即可添加 OpenAI/Gemini 兼容网关。',
        );
      }
      return ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemCount: endpoints.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final endpoint = endpoints[index];
          final isSelected = _service.selectedEndpointId.value == endpoint.id;
          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          endpoint.name,
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                        ),
                      ),
                      ChoiceChip(
                        label: const Text('当前使用'),
                        selected: isSelected,
                        onSelected: (_) => controller.setDefaultEndpoint(endpoint.id),
                      ),
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          switch (value) {
                            case 'edit':
                              controller.addOrEditEndpoint(endpoint: endpoint);
                              break;
                            case 'delete':
                              controller.removeEndpoint(endpoint);
                              break;
                          }
                        },
                        itemBuilder: (context) => const [
                          PopupMenuItem(value: 'edit', child: Text('编辑')),
                          PopupMenuItem(value: 'delete', child: Text('删除')),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Wrap(
                    spacing: 8.w,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _buildTag(endpoint.type == ApiProviderType.openai ? 'OpenAI 兼容' : 'Google Gemini'),
                      _buildTag(endpoint.model.isEmpty ? '未指定模型' : endpoint.model),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(endpoint.baseUrl, style: TextStyle(color: Colors.grey.shade600, fontSize: 12.sp)),
                  if (endpoint.notes.isNotEmpty) ...[
                    SizedBox(height: 8.h),
                    Text(endpoint.notes, style: TextStyle(color: Colors.grey.shade800, fontSize: 13.sp)),
                  ],
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildCharacterTab() {
    return Obx(() {
      final characters = _service.characters;
      if (characters.isEmpty) {
        return _buildEmptyHint(
          icon: Icons.chat_bubble_outline,
          title: '暂无 AI 角色',
          description: '从 SillyTavern 获取灵感，创建你的专属 AI 伙伴并绑定接口。',
        );
      }
      final endpoints = {for (final ep in _service.endpoints) ep.id: ep};
      return ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemCount: characters.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final character = characters[index];
          final endpoint = endpoints[character.endpointId];
          final isSelected = _service.selectedCharacterId.value == character.id;
          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: character.avatarColor,
                        child: Text(
                          character.name.characters.first,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(character.name,
                                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                            SizedBox(height: 4.h),
                            Text(
                              endpoint == null
                                  ? '未绑定接口'
                                  : '${endpoint.name} · ${endpoint.model.isEmpty ? endpoint.baseUrl : endpoint.model}',
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 12.sp),
                            ),
                          ],
                        ),
                      ),
                      ChoiceChip(
                        label: const Text('默认角色'),
                        selected: isSelected,
                        onSelected: (_) => controller.setDefaultCharacter(character.id),
                      ),
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          switch (value) {
                            case 'edit':
                              controller.addOrEditCharacter(character: character);
                              break;
                            case 'delete':
                              controller.removeCharacter(character);
                              break;
                          }
                        },
                        itemBuilder: (context) => const [
                          PopupMenuItem(value: 'edit', child: Text('编辑')),
                          PopupMenuItem(value: 'delete', child: Text('删除')),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    character.persona.isEmpty ? '尚未填写角色设定' : character.persona,
                    style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade800),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '问候语：${character.greeting}',
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
                  ),
                  if (character.sampleReplies.isNotEmpty) ...[
                    SizedBox(height: 8.h),
                    Text(
                      '示例回复：\n- ${character.sampleReplies.join('\n- ')}',
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildEmptyHint({required IconData icon, required String title, required String description}) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56.w, color: Colors.grey.shade400),
            SizedBox(height: 16.h),
            Text(title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 8.h),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade700),
      ),
    );
  }
}
