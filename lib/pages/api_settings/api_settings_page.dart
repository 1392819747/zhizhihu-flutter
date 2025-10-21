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
          Obx(() {
            final section = controller.selectedSection.value;
            late final VoidCallback onPressed;
            late final IconData icon;
            switch (section) {
              case 0:
                onPressed = () => controller.addOrEditEndpoint();
                icon = CupertinoIcons.add_circled;
                break;
              case 1:
                onPressed = () => controller.editPersona();
                icon = CupertinoIcons.person_crop_circle_badge_plus;
                break;
              default:
                onPressed = () => controller.addOrEditWorldInfo();
                icon = CupertinoIcons.doc_append;
            }
            return Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: SizedBox(
                width: 36.w,
                height: 36.w,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  minSize: 0,
                  onPressed: onPressed,
                  child: Icon(
                    icon,
                    color: const Color(0xFF007AFF),
                    size: 26,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
              child: Obx(
                () => CupertinoSlidingSegmentedControl<int>(
                  groupValue: controller.selectedSection.value,
                  children: const {
                    0: Text('接口'),
                    1: Text('个性'),
                    2: Text('世界信息'),
                  },
                  onValueChanged: (value) {
                    if (value != null) controller.switchSection(value);
                  },
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                switch (controller.selectedSection.value) {
                  case 0:
                    return _buildEndpointSection();
                  case 1:
                    return _buildPersonaSection();
                  default:
                    return _buildWorldInfoSection();
                }
              }),
            ),
          ],
        ),
      ),
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

  Widget _buildPersonaSection() {
    return Obx(() {
      final persona = _service.persona.value;
      final defaultCharacter = _service.selectedCharacter;

      if (persona == null) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(CupertinoIcons.person_crop_circle_badge_plus, size: 48, color: Color(0xFF8E8E93)),
                SizedBox(height: 16.h),
                Text(
                  '还没有配置用户个性',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8.h),
                Text(
                  '设置自己的语气、目标和写作风格，在对话中更像“你”。',
                  style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                CupertinoButton.filled(
                  onPressed: () => controller.editPersona(),
                  child: const Text('创建我的 Persona'),
                ),
              ],
            ),
          ),
        );
      }

      return ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18.r),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0F000000),
                  blurRadius: 18,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        color: const Color(0x2E34C759),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(CupertinoIcons.person, color: Color(0xFF34C759)),
                    ),
                    12.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            persona.displayName,
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                          ),
                          if (persona.style.isNotEmpty)
                            Text(
                              persona.style,
                              style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
                            ),
                        ],
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                  minSize: 0,
                      onPressed: () => controller.editPersona(),
                      child: const Icon(CupertinoIcons.pencil_ellipsis_rectangle, color: Color(0xFF007AFF)),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                if (persona.description.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Text(
                      persona.description,
                      style: TextStyle(fontSize: 14.sp, color: const Color(0xFF1C1C1E)),
                    ),
                  ),
                if (persona.goals.isNotEmpty)
                  _buildPersonaSectionRow(
                    icon: CupertinoIcons.scope,
                    label: '目标',
                    content: persona.goals,
                  ),
                if (persona.style.isNotEmpty)
                  _buildPersonaSectionRow(
                    icon: CupertinoIcons.waveform_path,
                    label: '写作/语气',
                    content: persona.style,
                  ),
              ],
            ),
          ),
          if (defaultCharacter != null) ...[
            SizedBox(height: 16.h),
            Text(
              '默认 AI 角色',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.grey.shade600),
            ),
            SizedBox(height: 8.h),
            _CharacterSummaryTile(character: defaultCharacter, onTap: () => controller.addOrEditCharacter(character: defaultCharacter)),
          ],
        ],
      );
    });
  }

  Widget _buildWorldInfoSection() {
    return Obx(() {
      final entries = _service.worldInfos;
      if (entries.isEmpty) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(CupertinoIcons.book, size: 48, color: Color(0xFF8E8E93)),
                SizedBox(height: 16.h),
                Text('世界信息为空', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                SizedBox(height: 8.h),
                Text(
                  '世界信息用于在对话中自动补充设定。添加关键词，当消息命中时插入设定片段。',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade600),
                ),
                SizedBox(height: 16.h),
                CupertinoButton.filled(
                  onPressed: () => controller.addOrEditWorldInfo(),
                  child: const Text('新增世界信息'),
                ),
              ],
            ),
          ),
        );
      }

      return ReorderableListView.builder(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 32.h),
        itemCount: entries.length,
        onReorder: (oldIndex, newIndex) => controller.service.reorderWorldInfos(oldIndex, newIndex),
        buildDefaultDragHandles: false,
        itemBuilder: (context, index) {
          final entry = entries[index];
          return ReorderableDelayedDragStartListener(
            key: ValueKey(entry.id),
            index: index,
            child: Container(
              margin: EdgeInsets.only(bottom: 12.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0F000000),
                    blurRadius: 16,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                title: Text(
                  entry.title,
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 6.h),
                    Wrap(
                      spacing: 6.w,
                      runSpacing: 6.h,
                      children: entry.keywords
                          .map((keyword) => Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE5E5EA),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Text(
                                  '#$keyword',
                                  style: TextStyle(fontSize: 11.sp, color: const Color(0xFF3C3C43)),
                                ),
                              ))
                          .toList(),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      entry.content,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13.sp, color: const Color(0xFF1C1C1E)),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '优先级：${entry.priority}',
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
                    ),
                  ],
                ),
                leading: Switch(
                  value: entry.enabled,
                  onChanged: (value) => controller.toggleWorldInfo(entry, value),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(CupertinoIcons.pencil, size: 20),
                      color: const Color(0xFF007AFF),
                      onPressed: () => controller.addOrEditWorldInfo(entry: entry),
                    ),
                    IconButton(
                      icon: const Icon(CupertinoIcons.trash, size: 20),
                      color: const Color(0xFFFF3B30),
                      onPressed: () => controller.removeWorldInfo(entry),
                    ),
                    const SizedBox(width: 8),
                    const Icon(CupertinoIcons.line_horizontal_3, color: Color(0xFF8E8E93)),
                  ],
                ),
              ),
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
              controller.editGenerationConfig(endpoint);
            },
            child: const Text('生成参数'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Get.back();
              controller.editEnabledFunctions(endpoint);
            },
            child: const Text('功能开关'),
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

  Widget _buildPersonaSectionRow({
    required IconData icon,
    required String label,
    required String content,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade500),
          8.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
                ),
                SizedBox(height: 4.h),
                Text(
                  content,
                  style: TextStyle(fontSize: 13.sp, color: const Color(0xFF1C1C1E)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}


Widget buildGenerationSummary(GenerationConfig config) {
  final items = <MapEntry<String, String>>[
    MapEntry('Temp', config.temperature.toStringAsFixed(2)),
    MapEntry('TopP', config.topP.toStringAsFixed(2)),
    MapEntry('TopK', config.topK.toString()),
    MapEntry('Max', config.maxTokens.toString()),
  ];
  return Wrap(
    spacing: 12.w,
    runSpacing: 8.h,
    children: [
      ...items.map(
        (item) => RichText(
          text: TextSpan(
            text: '${item.key} ',
            style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
            children: [
              TextSpan(
                text: item.value,
                style: TextStyle(fontSize: 13.sp, color: const Color(0xFF1C1C1E), fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
      RichText(
        text: TextSpan(
          text: '流式 ',
          style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
          children: [
            TextSpan(
              text: config.stream ? '开启' : '关闭',
              style: TextStyle(
                fontSize: 13.sp,
                color: config.stream ? const Color(0xFF34C759) : Colors.grey.shade500,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ],
  );
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
                if (endpoint.enabledFunctions.isNotEmpty)
                  ...endpoint.enabledFunctions
                      .map((item) => _buildTag(item.toUpperCase())),
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
            buildGenerationSummary(endpoint.generationConfig),
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

class _CharacterSummaryTile extends StatelessWidget {
  const _CharacterSummaryTile({
    required this.character,
    required this.onTap,
  });

  final AiCharacter character;
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
              color: Color(0x0F000000),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(14.w),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24.w,
              backgroundColor: character.avatarColor,
              child: Text(
                character.name.characters.first,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    character.persona.isEmpty ? '尚未设置角色设定' : character.persona,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            const Icon(CupertinoIcons.chevron_forward, color: Color(0xFF8E8E93)),
          ],
        ),
      ),
    );
  }
}
