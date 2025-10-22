import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../data/models/api_provider.dart';
import '../../domain/entities/api_entities.dart';
import '../../services/api_settings_service.dart';

class ApiSettingsLogic extends GetxController {
  final ApiSettingsService service = Get.find<ApiSettingsService>();
  final selectedSection = 0.obs;

  void setDefaultEndpoint(String id) {
    service.setSelectedEndpoint(id);
  }

  void setDefaultCharacter(String id) {
    service.setSelectedCharacter(id);
  }

  Future<void> addOrEditEndpoint({ApiEndpoint? endpoint}) async {
    var providerType = endpoint?.type ?? ApiProviderType.openai;
    final nameCtrl = TextEditingController(text: endpoint?.name ?? '');
    final baseUrlCtrl = TextEditingController(
        text: endpoint?.baseUrl ?? providerType.defaultBaseUrl);
    final keyLabelCtrl = TextEditingController(
        text: endpoint?.keyLabel ?? 'API_KEY_${service.endpoints.length + 1}');
    final apiKeyCtrl = TextEditingController();
    final modelCtrl =
        TextEditingController(text: endpoint?.model ?? providerType.defaultModel);
    final notesCtrl = TextEditingController(text: endpoint?.notes ?? '');
    final isNew = endpoint == null;

    final confirmed = await Get.dialog<bool>(
      StatefulBuilder(
        builder: (context, setState) => Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            margin: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 顶部标题栏
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFF34C759),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.auto_awesome,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          endpoint == null ? '添加新配置' : '编辑配置',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF333333),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.back(result: false),
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
                ),
                // 表单内容
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildModernTextField(nameCtrl,
                            label: '配置名称', hint: '例如：公司专用 OpenAI 网关'),
                        SizedBox(height: 16.h),
                        _buildModernDropdown<ApiProviderType>(
                          value: providerType,
                          label: 'API 提供商',
                          items: ApiProviderType.values.map((type) => 
                            DropdownMenuItem(
                              value: type,
                              child: Text(type.displayName),
                            ),
                          ).toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              providerType = value;
                              if (baseUrlCtrl.text.trim().isEmpty || endpoint == null) {
                                baseUrlCtrl.text = providerType.defaultBaseUrl;
                                modelCtrl.text = providerType.defaultModel;
                              }
                            });
                          },
                        ),
                        SizedBox(height: 16.h),
                        _buildModernTextField(baseUrlCtrl, label: 'Base URL'),
                        SizedBox(height: 16.h),
                        _buildModernTextField(keyLabelCtrl,
                            label: '密钥标记', hint: '用于在列表中辨识此密钥'),
                        SizedBox(height: 16.h),
                        _buildModernTextField(
                          apiKeyCtrl,
                          label: 'API Key',
                          hint: endpoint == null ? '请输入您的 API Key' : '留空表示保持现有密钥',
                          obscure: true,
                        ),
                        SizedBox(height: 16.h),
                        _buildModernTextField(modelCtrl, label: '默认模型', hint: '例如：gpt-4o-mini'),
                        SizedBox(height: 16.h),
                        _buildModernTextField(notesCtrl,
                            label: '备注说明', maxLines: 3, hint: '用途说明、速率限制等'),
                      ],
                    ),
                  ),
                ),
                // 底部按钮
                Container(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Get.back(result: false),
                          child: Container(
                            height: 48.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Center(
                              child: Text(
                                '取消',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF666666),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Get.back(result: true),
                          child: Container(
                            height: 48.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFF34C759),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Center(
                              child: Text(
                                '保存',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    if (confirmed != true) return;

    if (nameCtrl.text.trim().isEmpty) {
      IMViews.showToast('名称不能为空');
      return;
    }
    if (keyLabelCtrl.text.trim().isEmpty) {
      IMViews.showToast('请填写密钥标记');
      return;
    }
    if (isNew && apiKeyCtrl.text.trim().isEmpty) {
      IMViews.showToast('新增接口需要填写 API Key');
      return;
    }

    final updated = (endpoint ??
            ApiEndpoint(
              id: service.generateEndpointId(),
              name: nameCtrl.text.trim(),
              type: providerType,
              baseUrl: baseUrlCtrl.text.trim(),
              keyLabel: keyLabelCtrl.text.trim(),
              model: modelCtrl.text.trim(),
              notes: notesCtrl.text.trim(),
            ))
        .copyWith(
      name: nameCtrl.text.trim(),
      baseUrl: baseUrlCtrl.text.trim(),
      model: modelCtrl.text.trim(),
      type: providerType,
      notes: notesCtrl.text.trim(),
      keyLabel: keyLabelCtrl.text.trim(),
    );

    await service.addOrUpdateEndpoint(
      updated,
      apiKey: apiKeyCtrl.text.trim().isEmpty ? null : apiKeyCtrl.text.trim(),
    );
    IMViews.showToast('保存成功');
  }

  Future<void> editGenerationConfig(ApiEndpoint endpoint) async {
    final config = endpoint.generationConfig;
    final tempCtrl = TextEditingController(text: config.temperature.toString());
    final topPCtrl = TextEditingController(text: config.topP.toString());
    final topKCtrl = TextEditingController(text: config.topK.toString());
    final maxTokensCtrl =
        TextEditingController(text: config.maxTokens.toString());
    final presenceCtrl =
        TextEditingController(text: config.presencePenalty.toString());
    final frequencyCtrl =
        TextEditingController(text: config.frequencyPenalty.toString());
    var stream = config.stream;

    final confirmed = await Get.dialog<bool>(
      StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text('生成参数 · ${endpoint.name}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(tempCtrl,
                    label: 'temperature', hint: '0.0 - 2.0'),
                const SizedBox(height: 12),
                _buildTextField(topPCtrl, label: 'top_p', hint: '通常 0.7 - 1.0'),
                const SizedBox(height: 12),
                _buildTextField(topKCtrl, label: 'top_k', hint: '采样词表大小'),
                const SizedBox(height: 12),
                _buildTextField(maxTokensCtrl,
                    label: 'max_tokens', hint: '单次输出长度'),
                const SizedBox(height: 12),
                _buildTextField(presenceCtrl, label: 'presence_penalty'),
                const SizedBox(height: 12),
                _buildTextField(frequencyCtrl, label: 'frequency_penalty'),
                const SizedBox(height: 12),
                SwitchListTile(
                  value: stream,
                  title: const Text('流式输出'),
                  onChanged: (value) => setState(() => stream = value),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Get.back(result: false),
                child: const Text('取消')),
            ElevatedButton(
                onPressed: () => Get.back(result: true),
                child: const Text('保存')),
          ],
        ),
      ),
    );

    if (confirmed != true) return;

    GenerationConfig parse() {
      double parseDouble(TextEditingController ctrl, double fallback) {
        final value = double.tryParse(ctrl.text.trim());
        return value ?? fallback;
      }

      int parseInt(TextEditingController ctrl, int fallback) {
        final value = int.tryParse(ctrl.text.trim());
        return value ?? fallback;
      }

      return GenerationConfig(
        temperature: parseDouble(tempCtrl, config.temperature),
        topP: parseDouble(topPCtrl, config.topP),
        topK: parseInt(topKCtrl, config.topK),
        maxTokens: parseInt(maxTokensCtrl, config.maxTokens),
        presencePenalty: parseDouble(presenceCtrl, config.presencePenalty),
        frequencyPenalty: parseDouble(frequencyCtrl, config.frequencyPenalty),
        stream: stream,
      );
    }

    await service.updateGenerationConfig(endpoint: endpoint, config: parse());
    IMViews.showToast('参数已更新');
  }

  Future<void> editEnabledFunctions(ApiEndpoint endpoint) async {
    final available = ['chat', 'vision', 'image', 'audio', 'tools'];
    final selected = endpoint.enabledFunctions.toSet();

    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: Text('功能开关 · ${endpoint.name}'),
        content: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: available
                .map(
                  (item) => CheckboxListTile(
                    value: selected.contains(item),
                    title: Text(item.toUpperCase()),
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          selected.add(item);
                        } else {
                          selected.remove(item);
                        }
                      });
                    },
                  ),
                )
                .toList(),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('取消')),
          ElevatedButton(
              onPressed: () => Get.back(result: true), child: const Text('保存')),
        ],
      ),
    );

    if (confirmed == true) {
      await service.setEnabledFunctions(
        endpoint: endpoint,
        functions: selected.toList(),
      );
      IMViews.showToast('功能已更新');
    }
  }

  Future<void> editPersona() async {
    final current = service.persona.value;
    final nameCtrl = TextEditingController(text: current?.displayName ?? '我');
    final descCtrl = TextEditingController(text: current?.description ?? '');
    final goalCtrl = TextEditingController(text: current?.goals ?? '');
    final styleCtrl = TextEditingController(text: current?.style ?? '');

    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('用户个性'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(nameCtrl, label: '称呼', hint: '在提示词里如何称呼自己'),
              const SizedBox(height: 12),
              _buildTextField(descCtrl, label: '自我描述', maxLines: 3),
              const SizedBox(height: 12),
              _buildTextField(goalCtrl, label: '目标/任务', maxLines: 3),
              const SizedBox(height: 12),
              _buildTextField(styleCtrl, label: '说话风格', maxLines: 2),
            ],
          ),
        ),
        actions: [
          if (current != null)
            TextButton(
              onPressed: () => Get.back(result: null),
              child: const Text('清除'),
            ),
          TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('取消')),
          ElevatedButton(
              onPressed: () => Get.back(result: true), child: const Text('保存')),
        ],
      ),
    );

    if (confirmed == true) {
      final persona = UserPersona(
        id: current?.id ?? service.generateCharacterId(),
        displayName: nameCtrl.text.trim().isEmpty ? '我' : nameCtrl.text.trim(),
        description: descCtrl.text.trim(),
        goals: goalCtrl.text.trim(),
        style: styleCtrl.text.trim(),
      );
      await service.setPersona(persona);
      IMViews.showToast('个性已更新');
    } else if (confirmed == null) {
      await service.setPersona(null);
      IMViews.showToast('已清除个人设定');
    }
  }

  Future<void> addOrEditWorldInfo({WorldInfoEntry? entry}) async {
    final titleCtrl = TextEditingController(text: entry?.title ?? '');
    final keywordsCtrl =
        TextEditingController(text: entry?.keywords.join(', ') ?? '');
    final contentCtrl = TextEditingController(text: entry?.content ?? '');
    final priorityCtrl =
        TextEditingController(text: entry?.priority.toString() ?? '0');
    var enabled = entry?.enabled ?? true;

    final confirmed = await Get.dialog<bool>(
      StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(entry == null ? '新增世界信息' : '编辑世界信息'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(titleCtrl, label: '标题'),
                const SizedBox(height: 12),
                _buildTextField(
                  keywordsCtrl,
                  label: '触发关键词',
                  hint: '使用逗号分隔',
                ),
                const SizedBox(height: 12),
                _buildTextField(contentCtrl, label: '内容', maxLines: 4),
                const SizedBox(height: 12),
                _buildTextField(priorityCtrl, label: '优先级', hint: '数字越高越先插入'),
                const SizedBox(height: 12),
                SwitchListTile(
                  value: enabled,
                  title: const Text('启用'),
                  onChanged: (value) => setState(() => enabled = value),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Get.back(result: false),
                child: const Text('取消')),
            ElevatedButton(
                onPressed: () => Get.back(result: true),
                child: const Text('保存')),
          ],
        ),
      ),
    );

    if (confirmed != true) return;

    final keywords = keywordsCtrl.text
        .split(RegExp(r'[，,]'))
        .map((e) => e.trim())
        .where((element) => element.isNotEmpty)
        .toList();

    final priority =
        int.tryParse(priorityCtrl.text.trim()) ?? (entry?.priority ?? 0);

    final updated = (entry ??
            WorldInfoEntry(
              id: service.generateEndpointId(),
              title: titleCtrl.text.trim(),
              content: contentCtrl.text.trim(),
              keywords: keywords,
              priority: priority,
              enabled: enabled,
            ))
        .copyWith(
      title: titleCtrl.text.trim(),
      content: contentCtrl.text.trim(),
      keywords: keywords,
      priority: priority,
      enabled: enabled,
    );

    await service.addOrUpdateWorldInfo(updated);
    IMViews.showToast('世界信息已保存');
  }

  Future<void> removeWorldInfo(WorldInfoEntry entry) async {
    final confirm = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('删除确认'),
        content: Text('确认删除 ${entry.title} 吗？'),
        actions: [
          TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('取消')),
          ElevatedButton(
              onPressed: () => Get.back(result: true), child: const Text('删除')),
        ],
      ),
    );
    if (confirm == true) {
      await service.deleteWorldInfo(entry.id);
      IMViews.showToast('已删除');
    }
  }

  void switchSection(int index) => selectedSection.value = index;

  Future<void> toggleWorldInfo(WorldInfoEntry entry, bool enabled) async {
    await service.addOrUpdateWorldInfo(entry.copyWith(enabled: enabled));
  }

  Future<void> handleSectionAction(int section) async {
    final context = Get.context;
    if (context == null) return;
    switch (section) {
      case 0:
        await addOrEditEndpoint();
        return;
      case 1:
        _showPersonaSheet(context);
        return;
      case 2:
        _showWorldInfoSheet(context);
        return;
    }
  }

  void _showPersonaSheet(BuildContext context) {
    final hasPersona = service.persona.value != null;
    final items = <TDActionSheetItem>[
      TDActionSheetItem(label: '编辑个性'),
      TDActionSheetItem(label: '导入角色卡'),
      if (hasPersona)
        TDActionSheetItem(
          label: '清除个性',
          textStyle: TextStyle(color: TDTheme.of(context).errorColor6),
        ),
    ];
    TDActionSheet.showListActionSheet(
      context,
      items: items,
      onSelected: (item, index) {
        switch (index) {
          case 0:
            editPersona();
            break;
          case 1:
            importCharacterCard();
            break;
          case 2:
            service.setPersona(null);
            IMViews.showToast('已清除个人设定');
            break;
        }
      },
    );
  }

  void _showWorldInfoSheet(BuildContext context) {
    TDActionSheet.showListActionSheet(
      context,
      items: [
        TDActionSheetItem(label: '新增世界信息'),
        TDActionSheetItem(label: '导入世界书'),
      ],
      onSelected: (item, index) {
        switch (index) {
          case 0:
            addOrEditWorldInfo();
            break;
          case 1:
            importWorldInfo();
            break;
        }
      },
    );
  }

  Future<void> importCharacterCard() async {
    if (service.endpoints.isEmpty) {
      IMViews.showToast('请先配置至少一个 API 接入');
      return;
    }
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: const ['json'],
      );
      if (result == null || result.files.isEmpty) return;

      final file = result.files.first;
      final content = file.bytes != null
          ? utf8.decode(file.bytes!)
          : await File(file.path!).readAsString();

      final decoded = jsonDecode(content);
      final cards = _extractCharacterCards(decoded);

      if (cards.isEmpty) {
        IMViews.showToast('未识别到有效的角色卡');
        return;
      }

      final endpointId = service.selectedEndpointId.value.isNotEmpty
          ? service.selectedEndpointId.value
          : service.endpoints.first.id;

      int imported = 0;
      for (final data in cards) {
        final character = _convertCharacterCard(data, endpointId);
        if (character != null) {
          await service.addOrUpdateCharacter(character);
          imported++;
        }
      }
      if (imported > 0) {
        IMViews.showToast('已导入 $imported 个角色');
      } else {
        IMViews.showToast('角色卡内容为空，未导入');
      }
    } catch (e) {
      IMViews.showToast('导入失败：$e');
    }
  }

  Future<void> importWorldInfo() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: const ['json'],
      );
      if (result == null || result.files.isEmpty) return;

      final file = result.files.first;
      final content = file.bytes != null
          ? utf8.decode(file.bytes!)
          : await File(file.path!).readAsString();

      final decoded = jsonDecode(content);
      final entries = _extractWorldInfoEntries(decoded);

      if (entries.isEmpty) {
        IMViews.showToast('未识别到世界书条目');
        return;
      }

      int imported = 0;
      for (final map in entries) {
        final entry = _convertWorldInfoEntry(map);
        if (entry != null) {
          await service.addOrUpdateWorldInfo(entry);
          imported++;
        }
      }
      if (imported > 0) {
        IMViews.showToast('已导入 $imported 条世界信息');
      } else {
        IMViews.showToast('世界书内容为空，未导入');
      }
    } catch (e) {
      IMViews.showToast('导入失败：$e');
    }
  }

  List<Map<String, dynamic>> _extractCharacterCards(dynamic decoded) {
    if (decoded is List) {
      return decoded
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    }
    if (decoded is Map<String, dynamic>) {
      if (decoded['spec'] == 'chara_card_v2' ||
          decoded['spec'] == 'chara_card_v1') {
        final data = decoded['data'];
        if (data is Map) return [Map<String, dynamic>.from(data)];
      }
      if (decoded['data'] is Map && decoded.containsKey('description')) {
        return [Map<String, dynamic>.from(decoded['data'] as Map)];
      }
      if (decoded['character_card'] is Map) {
        return [Map<String, dynamic>.from(decoded['character_card'] as Map)];
      }
      if (decoded['cards'] is List) {
        return (decoded['cards'] as List)
            .whereType<Map>()
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
      }
      return [decoded];
    }
    return const [];
  }

  AiCharacter? _convertCharacterCard(
      Map<String, dynamic> card, String endpointId) {
    String asText(dynamic value) =>
        value is String ? value.trim() : value?.toString().trim() ?? '';

    final name =
        asText(card['name']).isNotEmpty ? asText(card['name']) : '未命名角色';
    final greeting = [
      asText(card['first_mes']),
      asText(card['greeting']),
      asText(card['first_message']),
    ].firstWhere((element) => element.isNotEmpty, orElse: () => '你好，我是$name。');

    final personaSegments = <String>[
      asText(card['personality']),
      asText(card['description']),
      asText(card['scenario']),
      asText(card['creator_notes']),
      asText(card['system_prompt']),
      asText(card['post_history_instructions']),
    ].where((element) => element.isNotEmpty).toList();

    final persona = personaSegments.join('\n\n');

    final examples = <String>[];
    final rawExample = card['mes_example'] ?? card['example_dialogue'];
    if (rawExample is String && rawExample.trim().isNotEmpty) {
      examples.addAll(
        rawExample
            .split(RegExp(r'(?:(?:\r?\n){2,}|###)'))
            .map((e) => e.trim())
            .where((element) => element.isNotEmpty),
      );
    } else if (rawExample is List) {
      examples.addAll(
        rawExample.map((e) => asText(e)).where((element) => element.isNotEmpty),
      );
    }

    final id = service.generateCharacterId();
    final avatarColor = service.randomAvatarColorHex();

    return AiCharacter(
      id: id,
      name: name,
      persona: persona,
      greeting: greeting,
      endpointId: endpointId,
      avatarColorHex: avatarColor,
      sampleReplies: examples.isEmpty
          ? const [
              '这听起来很有意思，我们继续聊聊吧。',
              '让我整理一下思路，再为你提供建议。',
            ]
          : examples,
    );
  }

  List<Map<String, dynamic>> _extractWorldInfoEntries(dynamic decoded) {
    if (decoded is Map<String, dynamic>) {
      if (decoded['entries'] is List) {
        return (decoded['entries'] as List)
            .whereType<Map>()
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
      }
      if (decoded['lorebook'] is Map &&
          decoded['lorebook']['entries'] is List) {
        return (decoded['lorebook']['entries'] as List)
            .whereType<Map>()
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
      }
      if (decoded['book'] is Map && decoded['book']['entries'] is List) {
        return (decoded['book']['entries'] as List)
            .whereType<Map>()
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
      }
    } else if (decoded is List) {
      return decoded
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    }
    return const [];
  }

  WorldInfoEntry? _convertWorldInfoEntry(Map<String, dynamic> entry) {
    String asText(dynamic value) =>
        value is String ? value.trim() : value?.toString().trim() ?? '';

    final keywords = <String>{};
    void addKeywords(dynamic value) {
      if (value is String && value.trim().isNotEmpty) {
        keywords.addAll(value
            .split(RegExp(r'[，,\n]'))
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty));
      } else if (value is List) {
        keywords.addAll(value.map((e) => asText(e)).where((e) => e.isNotEmpty));
      }
    }

    addKeywords(entry['key']);
    addKeywords(entry['keys']);
    addKeywords(entry['keywords']);
    addKeywords(entry['secondary_keys']);

    final content = asText(entry['content']) +
        (asText(entry['commentary']).isNotEmpty
            ? '\n${asText(entry['commentary'])}'
            : '');

    if (content.trim().isEmpty) return null;

    final title = asText(entry['display_name']).isNotEmpty
        ? asText(entry['display_name'])
        : keywords.isNotEmpty
            ? keywords.first
            : '未命名条目';

    final priority = entry['priority'] is num
        ? (entry['priority'] as num).toInt()
        : entry['position'] is num
            ? (entry['position'] as num).toInt()
            : 0;

    final enabled = entry['enabled'] is bool
        ? entry['enabled'] as bool
        : entry['disabled'] is bool
            ? !(entry['disabled'] as bool)
            : true;

    return WorldInfoEntry(
      id: service.generateEndpointId(),
      title: title,
      content: content,
      keywords: keywords.isEmpty ? const [] : keywords.toList(),
      priority: priority,
      enabled: enabled,
    );
  }

  Future<void> removeEndpoint(ApiEndpoint endpoint) async {
    final confirm = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('删除确认'),
        content: Text('确认删除 ${endpoint.name} 吗？\n关联的角色将解除绑定。'),
        actions: [
          TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('取消')),
          ElevatedButton(
              onPressed: () => Get.back(result: true), child: const Text('删除')),
        ],
      ),
    );
    if (confirm == true) {
      await service.deleteEndpoint(endpoint.id);
      IMViews.showToast('已删除');
    }
  }

  Future<void> addOrEditCharacter({AiCharacter? character}) async {
    if (service.endpoints.isEmpty) {
      IMViews.showToast('请先创建 API 接入');
      return;
    }
    final nameCtrl = TextEditingController(text: character?.name ?? '');
    final personaCtrl = TextEditingController(text: character?.persona ?? '');
    final greetingCtrl =
        TextEditingController(text: character?.greeting ?? '你好，很高兴再次与您相遇。');
    final repliesCtrl = TextEditingController(
        text: character?.sampleReplies.join('\n') ??
            '这听起来很棒，我们可以深入聊聊。\n让我来总结一下目前的要点。');
    var endpointId = character?.endpointId.isNotEmpty == true
        ? character!.endpointId
        : service.selectedEndpoint?.id ?? service.endpoints.first.id;
    String colorHex =
        character?.avatarColorHex ?? service.randomAvatarColorHex();

    final confirmed = await Get.dialog<bool>(
      StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(character == null ? '新增 AI 角色' : '编辑 AI 角色'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(nameCtrl, label: '名称', hint: '例如：阿狸导师'),
                const SizedBox(height: 12),
                _buildDropdown<String>(
                  value: endpointId,
                  items: service.endpoints
                      .map((e) =>
                          DropdownMenuItem(value: e.id, child: Text(e.name)))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => endpointId = value);
                    }
                  },
                ),
                const SizedBox(height: 12),
                _buildTextField(personaCtrl,
                    label: '角色设定', maxLines: 3, hint: '性格、说话风格、背景故事等'),
                const SizedBox(height: 12),
                _buildTextField(greetingCtrl, label: '见面问候语', maxLines: 2),
                const SizedBox(height: 12),
                _buildTextField(repliesCtrl,
                    label: '示例回复', maxLines: 4, hint: '每行一个示例，用于离线对话预览'),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text('头像颜色'),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => setState(() {
                        colorHex = service.randomAvatarColorHex();
                      }),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Color(
                              int.parse(colorHex.substring(1), radix: 16) +
                                  0xFF000000),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text('👉 点击随机'),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Get.back(result: false),
                child: const Text('取消')),
            ElevatedButton(
                onPressed: () => Get.back(result: true),
                child: const Text('保存')),
          ],
        ),
      ),
    );

    if (confirmed != true) return;

    if (nameCtrl.text.trim().isEmpty) {
      IMViews.showToast('名称不能为空');
      return;
    }

    final sampleReplies = repliesCtrl.text
        .split('\n')
        .map((e) => e.trim())
        .where((element) => element.isNotEmpty)
        .toList();

    final updated = (character ??
            AiCharacter(
              id: service.generateCharacterId(),
              name: nameCtrl.text.trim(),
              persona: personaCtrl.text.trim(),
              greeting: greetingCtrl.text.trim(),
              endpointId: endpointId,
              avatarColorHex: colorHex,
              sampleReplies: sampleReplies,
            ))
        .copyWith(
      name: nameCtrl.text.trim(),
      persona: personaCtrl.text.trim(),
      greeting: greetingCtrl.text.trim(),
      endpointId: endpointId,
      avatarColorHex: colorHex,
      sampleReplies: sampleReplies,
    );

    await service.addOrUpdateCharacter(updated);
    IMViews.showToast('保存成功');
  }

  Future<void> removeCharacter(AiCharacter character) async {
    final confirm = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('删除确认'),
        content: Text('确认删除 ${character.name} 吗？'),
        actions: [
          TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('取消')),
          ElevatedButton(
              onPressed: () => Get.back(result: true), child: const Text('删除')),
        ],
      ),
    );
    if (confirm == true) {
      await service.deleteCharacter(character.id);
      IMViews.showToast('已删除');
    }
  }

  Future<void> updateStreamSetting(ApiEndpoint endpoint, bool stream) async {
    final updatedConfig = endpoint.generationConfig.copyWith(stream: stream);
    await service.updateGenerationConfig(endpoint: endpoint, config: updatedConfig);
    IMViews.showToast('流式输出设置已更新');
  }

  Widget _buildModernTextField(TextEditingController controller,
      {required String label,
      String? hint,
      bool obscure = false,
      int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF333333),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: const Color(0xFFE5E5EA),
              width: 1,
            ),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            obscureText: obscure,
            style: TextStyle(
              fontSize: 16.sp,
              color: const Color(0xFF333333),
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xFF999999),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModernDropdown<T>({
    required T value,
    required String label,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF333333),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: const Color(0xFFE5E5EA),
              width: 1,
            ),
          ),
          child: DropdownButtonFormField<T>(
            value: value,
            items: items,
            onChanged: onChanged,
            style: TextStyle(
              fontSize: 16.sp,
              color: const Color(0xFF333333),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
            ),
            dropdownColor: Colors.white,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFF666666),
            ),
          ),
        ),
      ],
    );
  }

  DropdownButtonFormField<T> _buildDropdown<T>({
    required T value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      decoration: const InputDecoration(border: OutlineInputBorder()),
    );
  }

  TextField _buildTextField(TextEditingController controller,
      {required String label,
      String? hint,
      bool obscure = false,
      int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
    );
  }

  String _defaultBaseUrl(ApiProviderType? type) {
    switch (type) {
      case ApiProviderType.gemini:
        return 'https://generativelanguage.googleapis.com/v1beta';
      case ApiProviderType.openai:
      default:
        return 'https://api.openai.com/v1';
    }
  }
}
