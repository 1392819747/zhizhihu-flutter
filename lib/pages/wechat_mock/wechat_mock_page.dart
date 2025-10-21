import 'package:characters/characters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/api_entities.dart';
import '../../domain/entities/chat_entities.dart' as chat;
import '../../routes/app_navigator.dart';
import 'wechat_chat_page.dart';
import 'wechat_mock_logic.dart';

class WeChatMockPage extends GetView<WeChatMockLogic> {
  const WeChatMockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (controller.currentTab.value) {
          case 0:
            return _ConversationTab(controller: controller);
          case 1:
            return _ContactsTab(controller: controller);
          case 2:
            return _DiscoverTab(controller: controller);
          case 3:
          default:
            return _ProfileTab(controller: controller);
        }
      }),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentTab.value,
          onTap: controller.switchTab,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF07C160),
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline), label: '会话'),
            BottomNavigationBarItem(
                icon: Icon(Icons.contacts_outlined), label: '通讯录'),
            BottomNavigationBarItem(
                icon: Icon(Icons.explore_outlined), label: '发现'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: '我'),
          ],
        ),
      ),
    );
  }
}

class _ConversationTab extends StatelessWidget {
  const _ConversationTab({required this.controller});

  final WeChatMockLogic controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final items = controller.conversations;
      if (items.isEmpty) {
        return _EmptyPlaceholder(
          icon: Icons.chat_bubble_outline,
          title: '还没有会话',
          message: '前往通讯录添加一个角色，或在 API 设置中新建角色卡。',
          actionLabel: '去通讯录',
          onAction: () => controller.switchTab(1),
        );
      }
      return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemBuilder: (context, index) {
          final tile = items[index];
          final character = tile.character;
          return ListTile(
            leading: _AvatarBadge(
              name: character?.name ?? tile.summary.title,
              color: character?.avatarColor ?? const Color(0xFF07C160),
            ),
            title: Text(
              character?.name ?? tile.summary.title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            subtitle: Text(
              tile.summary.lastMessage.isEmpty
                  ? '暂无消息'
                  : tile.summary.lastMessage,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _formatTime(tile.summary.lastTime),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                if (tile.summary.unreadCount > 0)
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${tile.summary.unreadCount}',
                      style: const TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
              ],
            ),
            onTap: () async {
              final character = tile.character;
              AiCharacter resolvedCharacter;
              if (character != null) {
                resolvedCharacter = character;
              } else {
                final contact = controller.contacts
                    .firstWhereOrNull((c) => c.id == tile.summary.contactId);
                if (contact == null) {
                  Get.snackbar('提示', '未找到对应角色，请在通讯录中重新绑定。');
                  return;
                }
                resolvedCharacter = contact;
              }
              await Get.to(() => WeChatChatPage(
                  conversation: tile.summary, character: resolvedCharacter));
            },
            onLongPress: () => _showConversationActions(context, tile),
          );
        },
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemCount: items.length,
      );
    });
  }

  void _showConversationActions(BuildContext context, ConversationTile tile) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(tile.summary.isPinned
                  ? Icons.vertical_align_bottom
                  : Icons.push_pin),
              title: Text(tile.summary.isPinned ? '取消置顶' : '置顶会话'),
              onTap: () {
                Get.back();
                controller.toggleConversationPin(
                    tile.summary.id, !tile.summary.isPinned);
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.delete_outline, color: Colors.redAccent),
              title: const Text('删除'),
              onTap: () async {
                Get.back();
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('删除会话'),
                    content: const Text('删除后聊天记录将无法恢复，确定要删除该会话吗？'),
                    actions: [
                      TextButton(
                          onPressed: () => Get.back(result: false),
                          child: const Text('取消')),
                      ElevatedButton(
                          onPressed: () => Get.back(result: true),
                          child: const Text('删除')),
                    ],
                  ),
                );
                if (confirm == true) {
                  await controller.deleteConversation(tile.summary.id);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactsTab extends StatelessWidget {
  const _ContactsTab({required this.controller});

  final WeChatMockLogic controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final contacts = controller.contacts;
      if (contacts.isEmpty) {
        return _EmptyPlaceholder(
          icon: Icons.person_add_alt,
          title: '暂无角色',
          message: '在 API 设置中创建角色卡，或导入 TavernCard。',
          actionLabel: '打开 API 设置',
          onAction: AppNavigator.startApiSettings,
        );
      }
      return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemBuilder: (context, index) {
          final character = contacts[index];
          return ListTile(
            leading: _AvatarBadge(
                name: character.name, color: character.avatarColor),
            title: Text(character.name,
                style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(
              character.persona.isEmpty ? '未设置人设' : character.persona,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => _showCharacterActions(context, character),
            ),
            onTap: () async {
              final tile = await controller.ensureConversation(character);
              await Get.to(() => WeChatChatPage(
                  conversation: tile.summary, character: character));
            },
          );
        },
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemCount: contacts.length,
      );
    });
  }

  void _showCharacterActions(BuildContext context, AiCharacter character) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.chat_bubble_outline),
              title: const Text('发起聊天'),
              onTap: () async {
                Get.back();
                final tile = await controller.ensureConversation(character);
                await Get.to(() => WeChatChatPage(
                    conversation: tile.summary, character: character));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('管理角色'),
              onTap: () {
                Get.back();
                AppNavigator.startApiSettings();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DiscoverTab extends StatelessWidget {
  const _DiscoverTab({required this.controller});

  final WeChatMockLogic controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('朋友圈'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => _showPublishDialog(context),
          ),
        ],
      ),
      body: Obx(() {
        final items = controller.moments;
        if (items.isEmpty) {
          return _EmptyPlaceholder(
            icon: Icons.photo_library_outlined,
            title: '朋友圈空空如也',
            message: '记录一些想法或分享精选对话。',
            actionLabel: '发表动态',
            onAction: () => _showPublishDialog(context),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final tile = items[index];
            final author = tile.author;
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _AvatarBadge(
                          name: author?.name ?? '我',
                          color: author?.avatarColor ?? const Color(0xFF5D6CF5),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(author?.name ?? '我',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                            Text(_formatTime(tile.entry.createdAt),
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                        const Spacer(),
                        PopupMenuButton<String>(
                          onSelected: (value) async {
                            if (value == 'delete') {
                              await controller.deleteMoment(tile.entry.id);
                            }
                          },
                          itemBuilder: (_) => const [
                            PopupMenuItem(value: 'delete', child: Text('删除')),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(tile.entry.content,
                        style: const TextStyle(fontSize: 15, height: 1.4)),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showPublishDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showPublishDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('发布动态'),
        content: TextField(
          controller: controller,
          maxLines: 5,
          decoration: const InputDecoration(hintText: '记录此刻的想法...'),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('取消')),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.trim().isEmpty) return;
              await this.controller.createMoment(controller.text.trim());
              Get.back();
            },
            child: const Text('发布'),
          ),
        ],
      ),
    );
  }
}

class _ProfileTab extends StatelessWidget {
  const _ProfileTab({required this.controller});

  final WeChatMockLogic controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('我的')),
      body: Obx(() {
        final persona = controller.persona.value;
        final endpoint = controller.apiSettings.selectedEndpoint;
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.person_outline),
                title: Text(persona?.displayName ?? '未设置'),
                subtitle: Text(
                  persona == null
                      ? '点击设置你的 Persona，让 AI 更懂你'
                      : (persona.description.isNotEmpty
                          ? persona.description
                          : '未填写描述'),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => AppNavigator.startApiSettings(),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.tune),
                title: Text(endpoint?.name ?? '未选择接口'),
                subtitle:
                    Text(endpoint == null ? '点击配置 API 接口' : endpoint.baseUrl),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: AppNavigator.startApiSettings,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.history),
                title: const Text('世界信息 / Lorebook'),
                subtitle: Text(
                    '已启用 ${controller.worldInfos.where((e) => e.enabled).length} 条'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: AppNavigator.startApiSettings,
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _AvatarBadge extends StatelessWidget {
  const _AvatarBadge({required this.name, required this.color});

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name.characters.first : '?';
    return CircleAvatar(
      backgroundColor: color,
      child: Text(initial,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}

class _EmptyPlaceholder extends StatelessWidget {
  const _EmptyPlaceholder({
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 16),
              ElevatedButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}

String _formatTime(DateTime? time) {
  if (time == null) return '';
  final now = DateTime.now();
  if (now.difference(time).inDays == 0) {
    return DateFormat('HH:mm').format(time);
  }
  return DateFormat('MM-dd').format(time);
}
