import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';

import '../../services/api_settings_service.dart';

class ApiSettingsLogic extends GetxController {
  final ApiSettingsService service = Get.find<ApiSettingsService>();

  void setDefaultEndpoint(String id) {
    service.setSelectedEndpoint(id);
  }

  void setDefaultCharacter(String id) {
    service.setSelectedCharacter(id);
  }

  Future<void> addOrEditEndpoint({ApiEndpoint? endpoint}) async {
    final nameCtrl = TextEditingController(text: endpoint?.name ?? '');
    final baseUrlCtrl = TextEditingController(text: endpoint?.baseUrl ?? _defaultBaseUrl(endpoint?.type));
    final apiKeyCtrl = TextEditingController(text: endpoint?.apiKey ?? '');
    final modelCtrl = TextEditingController(text: endpoint?.model ?? 'gpt-4o-mini');
    final notesCtrl = TextEditingController(text: endpoint?.notes ?? '');
    var providerType = endpoint?.type ?? ApiProviderType.openai;

    final confirmed = await Get.dialog<bool>(
      StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(endpoint == null ? '新增 API 接入' : '编辑 API 接入'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(nameCtrl, label: '名称', hint: '例如：公司专用 OpenAI 网关'),
                const SizedBox(height: 12),
                _buildDropdown<ApiProviderType>(
                  value: providerType,
                  items: const [
                    DropdownMenuItem(value: ApiProviderType.openai, child: Text('OpenAI 兼容接口')),
                    DropdownMenuItem(value: ApiProviderType.gemini, child: Text('Google Gemini')),
                  ],
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      providerType = value;
                      if (baseUrlCtrl.text.trim().isEmpty || endpoint == null) {
                        baseUrlCtrl.text = _defaultBaseUrl(providerType);
                      }
                    });
                  },
                ),
                const SizedBox(height: 12),
                _buildTextField(baseUrlCtrl, label: 'Base URL'),
                const SizedBox(height: 12),
                _buildTextField(apiKeyCtrl, label: 'API Key', obscure: true),
                const SizedBox(height: 12),
                _buildTextField(modelCtrl, label: '默认模型/Version'),
                const SizedBox(height: 12),
                _buildTextField(notesCtrl, label: '备注', maxLines: 3, hint: '用途说明、速率限制等'),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Get.back(result: false), child: const Text('取消')),
            ElevatedButton(onPressed: () => Get.back(result: true), child: const Text('保存')),
          ],
        ),
      ),
    );

    if (confirmed != true) return;

    if (nameCtrl.text.trim().isEmpty || apiKeyCtrl.text.trim().isEmpty) {
      IMViews.showToast('名称与 API Key 不能为空');
      return;
    }

    final updated = (endpoint ?? ApiEndpoint(
          id: service.generateEndpointId(),
          name: nameCtrl.text.trim(),
          type: providerType,
          baseUrl: baseUrlCtrl.text.trim(),
          apiKey: apiKeyCtrl.text.trim(),
          model: modelCtrl.text.trim(),
          notes: notesCtrl.text.trim(),
        ))
        .copyWith(
      name: nameCtrl.text.trim(),
      baseUrl: baseUrlCtrl.text.trim(),
      apiKey: apiKeyCtrl.text.trim(),
      model: modelCtrl.text.trim(),
      type: providerType,
      notes: notesCtrl.text.trim(),
    );

    await service.addOrUpdateEndpoint(updated);
    IMViews.showToast('保存成功');
  }

  Future<void> removeEndpoint(ApiEndpoint endpoint) async {
    final confirm = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('删除确认'),
        content: Text('确认删除 ${endpoint.name} 吗？\n关联的角色将解除绑定。'),
        actions: [
          TextButton(onPressed: () => Get.back(result: false), child: const Text('取消')),
          ElevatedButton(onPressed: () => Get.back(result: true), child: const Text('删除')),
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
    final greetingCtrl = TextEditingController(text: character?.greeting ?? '你好，很高兴再次与您相遇。');
    final repliesCtrl = TextEditingController(
        text: character?.sampleReplies.join('\n') ?? '这听起来很棒，我们可以深入聊聊。\n让我来总结一下目前的要点。');
    var endpointId = character?.endpointId.isNotEmpty == true
        ? character!.endpointId
        : service.selectedEndpoint?.id ?? service.endpoints.first.id;
    String colorHex = character?.avatarColorHex ?? service.randomAvatarColorHex();

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
                      .map((e) => DropdownMenuItem(value: e.id, child: Text(e.name)))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => endpointId = value);
                    }
                  },
                ),
                const SizedBox(height: 12),
                _buildTextField(personaCtrl, label: '角色设定', maxLines: 3, hint: '性格、说话风格、背景故事等'),
                const SizedBox(height: 12),
                _buildTextField(greetingCtrl, label: '见面问候语', maxLines: 2),
                const SizedBox(height: 12),
                _buildTextField(repliesCtrl,
                    label: '示例回复',
                    maxLines: 4,
                    hint: '每行一个示例，用于离线对话预览'),
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
                          color: Color(int.parse(colorHex.substring(1), radix: 16) + 0xFF000000),
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
            TextButton(onPressed: () => Get.back(result: false), child: const Text('取消')),
            ElevatedButton(onPressed: () => Get.back(result: true), child: const Text('保存')),
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

    final updated = (character ?? AiCharacter(
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
          TextButton(onPressed: () => Get.back(result: false), child: const Text('取消')),
          ElevatedButton(onPressed: () => Get.back(result: true), child: const Text('删除')),
        ],
      ),
    );
    if (confirm == true) {
      await service.deleteCharacter(character.id);
      IMViews.showToast('已删除');
    }
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
      {required String label, String? hint, bool obscure = false, int maxLines = 1}) {
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
