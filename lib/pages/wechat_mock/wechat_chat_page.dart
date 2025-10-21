import 'package:characters/characters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../data/repositories/chat_repository.dart';
import '../../domain/entities/api_entities.dart';
import '../../domain/entities/chat_entities.dart' as chat;
import '../../services/chat_service.dart';
import 'wechat_mock_logic.dart';

class WeChatChatPage extends StatefulWidget {
  const WeChatChatPage(
      {super.key, required this.conversation, required this.character});

  final chat.ConversationSummary conversation;
  final AiCharacter character;

  @override
  State<WeChatChatPage> createState() => _WeChatChatPageState();
}

class _WeChatChatPageState extends State<WeChatChatPage> {
  late final ChatService _chatService = Get.find<ChatService>();
  late final ChatRepository _chatRepository = Get.find<ChatRepository>();
  late final WeChatMockLogic _logic = Get.find<WeChatMockLogic>();

  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _chatRepository.markConversationRead(widget.conversation.id);
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stream = _chatRepository.watchMessages(widget.conversation.id);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: widget.character.avatarColor,
              child: Text(widget.character.name.characters.first,
                  style: const TextStyle(color: Colors.white)),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.character.name,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                if (widget.conversation.providerProfileId != null)
                  Text(
                    '模型：${widget.conversation.modelPresetId ?? widget.conversation.providerProfileId}',
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_outlined),
            tooltip: '重生最新回复',
            onPressed: _regenerateLast,
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => AppNavigator.startApiSettings(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<chat.MessageModel>>(
              stream: stream,
              builder: (context, snapshot) {
                final messages = snapshot.data ?? const [];
                if (messages.isEmpty) {
                  return const Center(child: Text('和 AI 打个招呼吧'));
                }
                WidgetsBinding.instance
                    .addPostFrameCallback((_) => _scrollToBottom());
                return ListView.builder(
                  controller: _scrollController,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isSelf = message.senderType == chat.SenderType.user;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Align(
                        alignment: isSelf
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: _MessageBubble(
                          message: message,
                          isSelf: isSelf,
                          onRetry: !isSelf &&
                                  message.status == chat.MessageStatus.failed
                              ? _regenerateLast
                              : null,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          _InputBar(
            controller: _inputController,
            onSend: _sendMessage,
            isSending: _isSending,
          ),
        ],
      ),
    );
  }

  Future<void> _sendMessage() async {
    final text = _inputController.text.trim();
    if (text.isEmpty || _isSending) return;
    setState(() => _isSending = true);
    try {
      await _chatService.sendMessage(
        conversation: widget.conversation,
        character: widget.character,
        content: text,
      );
      _inputController.clear();
      await Future.delayed(const Duration(milliseconds: 120));
      _scrollToBottom();
    } catch (e) {
      Get.snackbar('发送失败', '$e', snackPosition: SnackPosition.BOTTOM);
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
      }
    }
  }

  Future<void> _regenerateLast() async {
    setState(() => _isSending = true);
    try {
      await _chatService.regenerateLastAssistant(
        conversation: widget.conversation,
        character: widget.character,
      );
      await Future.delayed(const Duration(milliseconds: 200));
      _scrollToBottom();
    } catch (e) {
      Get.snackbar('重生失败', '$e', snackPosition: SnackPosition.BOTTOM);
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 120,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}

class _InputBar extends StatelessWidget {
  const _InputBar(
      {required this.controller,
      required this.onSend,
      required this.isSending});

  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isSending;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.grey.shade50,
            border: Border(top: BorderSide(color: Colors.grey.shade200))),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  controller: controller,
                  minLines: 1,
                  maxLines: 4,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: '输入消息…'),
                ),
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: isSending ? null : onSend,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF07C160),
                  foregroundColor: Colors.white),
              child: isSending
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble(
      {required this.message, required this.isSelf, this.onRetry});

  final chat.MessageModel message;
  final bool isSelf;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final background = isSelf ? const Color(0xFF95EC69) : Colors.white;
    final radius = isSelf
        ? const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(4),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          );
    final statusText = _statusLabel(message.status);
    return Column(
      crossAxisAlignment:
          isSelf ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onLongPress: () {
            Clipboard.setData(ClipboardData(text: message.content));
            Get.snackbar('已复制', '消息内容已复制到剪贴板',
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 1));
          },
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: background,
              borderRadius: radius,
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Text(
              message.content,
              style: TextStyle(
                  color: isSelf ? Colors.white : Colors.black87,
                  fontSize: 15,
                  height: 1.35),
            ),
          ),
        ),
        if (statusText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(statusText,
                    style: const TextStyle(fontSize: 11, color: Colors.grey)),
                if (message.status == chat.MessageStatus.failed &&
                    onRetry != null)
                  TextButton(onPressed: onRetry, child: const Text('重试')),
              ],
            ),
          ),
      ],
    );
  }

  String? _statusLabel(chat.MessageStatus status) {
    switch (status) {
      case chat.MessageStatus.pending:
        return '生成中…';
      case chat.MessageStatus.streaming:
        return '生成中…';
      case chat.MessageStatus.failed:
        return '生成失败';
      case chat.MessageStatus.sent:
        return null;
    }
  }
}
