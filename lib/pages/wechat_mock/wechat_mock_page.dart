import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../services/api_settings_service.dart';
import '../../routes/app_navigator.dart';
import 'wechat_mock_logic.dart';

class WeChatMockPage extends GetView<WeChatMockLogic> {
  const WeChatMockPage({super.key});

  static const _gradientColors = [
    Color(0xFF5D6CF5),
    Color(0xFF2646F7),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _gradientColors,
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                _buildStatusBar(),
                _buildHeader(),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(28)),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: _buildChatsSection(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 16.w,
                            right: 16.w,
                            bottom:
                                12.h + MediaQuery.of(context).padding.bottom,
                            top: 8.h,
                          ),
                          child: _buildBottomNavigation(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Chats',
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: IconButton(
              tooltip: 'API 设置',
              onPressed: AppNavigator.startApiSettings,
              icon: const Icon(Icons.tune),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBar() {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 12.h),
      child: Row(
        children: [
          Text(
            '9:41',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1,
            ),
          ),
          const Spacer(),
          Icon(Icons.signal_cellular_alt, size: 16.w, color: Colors.white),
          6.horizontalSpace,
          Icon(Icons.wifi, size: 16.w, color: Colors.white),
          6.horizontalSpace,
          Icon(Icons.battery_full, size: 18.w, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildChatsSection() {
    return Obx(() {
      final items = controller.conversations;
      if (items.isEmpty) {
        return _buildPlaceholder('还没有配置 AI 伙伴，点击右上角「API 设置」去创建吧。');
      }
      return ListView.separated(
        padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
        itemCount: items.length,
        separatorBuilder: (_, __) =>
            Divider(height: 1.h, thickness: 1, color: const Color(0xFFEAEAF5)),
        itemBuilder: (context, index) {
          final conversation = items[index];
          return _ConversationTile(
            conversation: conversation,
            onTap: () => _openConversation(conversation),
          );
        },
      );
    });
  }

  Widget _buildPlaceholder(String text) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Text(
          text,
          style: TextStyle(fontSize: 16.sp, color: const Color(0xFF646B7C)),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Obx(() {
      final conversationCount = controller.conversations.length;
      return Row(
        children: [
          Expanded(
            child: _NavItem.primary(
              icon: Icons.chat_bubble,
              label: 'Chats',
              badge: conversationCount > 0
                  ? conversationCount.clamp(0, 99).toString()
                  : null,
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: _NavItem.secondary(
              icon: Icons.search,
              label: 'Search',
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: _NavItem.profile(
              label: 'Profile',
              character: controller.defaultCharacter,
            ),
          ),
        ],
      );
    });
  }

  Future<void> _openConversation(WeChatConversation conversation) async {
    final result = await Get.to<ChatPreview>(
      () => WeChatChatPage(
          character: conversation.character, endpoint: conversation.endpoint),
    );
    if (result != null) {
      controller.updatePreview(conversation.character.id, result);
    }
  }
}

class _ConversationTile extends StatelessWidget {
  const _ConversationTile({required this.conversation, required this.onTap});

  final WeChatConversation conversation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 76.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _Avatar(character: conversation.character, size: 48.w),
            12.horizontalSpace,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation.character.name,
                          style: TextStyle(
                            fontSize: 23.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            height: 1,
                          ),
                        ),
                      ),
                      Text(
                        _formatTime(conversation.preview.lastTime),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0x99000000),
                        ),
                      ),
                    ],
                  ),
                  4.verticalSpace,
                  Text(
                    conversation.preview.lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 21.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF1F2432),
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.character, required this.size});

  final AiCharacter character;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        width: size,
        height: size,
        color: character.avatarColor,
        alignment: Alignment.center,
        child: Text(
          character.name.characters.first,
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.45,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem._({
    required this.label,
    this.icon,
    this.badge,
    this.character,
    required this.active,
  });

  factory _NavItem.primary({
    required IconData icon,
    required String label,
    String? badge,
  }) {
    return _NavItem._(
      icon: icon,
      label: label,
      badge: badge,
      active: true,
    );
  }

  factory _NavItem.secondary({
    required IconData icon,
    required String label,
  }) {
    return _NavItem._(
      icon: icon,
      label: label,
      active: false,
    );
  }

  factory _NavItem.profile({
    required String label,
    AiCharacter? character,
  }) {
    return _NavItem._(
      label: label,
      character: character,
      active: false,
    );
  }

  final IconData? icon;
  final String? badge;
  final AiCharacter? character;
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    const Color inactiveColor = Color(0x99000000);
    final Widget circleContent;

    if (character != null) {
      circleContent = _Avatar(character: character!, size: 40.w);
    } else {
      final IconData iconData = icon ?? Icons.person;
      circleContent = Icon(
        iconData,
        size: 24.w,
        color: active ? Colors.black : inactiveColor,
      );
    }

    final double circleSize = 56.w;
    final Widget decorated = Container(
      height: circleSize,
      width: circleSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: active
            ? const LinearGradient(
                colors: WeChatMockPage._gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: active ? null : const Color(0xFFF4F5FF),
        boxShadow: active
            ? [
                BoxShadow(
                  color: const Color(0x405D6CF5),
                  blurRadius: 20.r,
                  offset: Offset(0, 8.h),
                ),
              ]
            : null,
      ),
      child: badge == null
          ? Center(child: circleContent)
          : Stack(
              clipBehavior: Clip.none,
              children: [
                Center(child: circleContent),
                Positioned(
                  top: 6.h,
                  right: 4.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF5D6CF5),
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x405D6CF5),
                          blurRadius: 12.r,
                          offset: Offset(0, 6.h),
                        ),
                      ],
                    ),
                    child: Text(
                      badge!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        decorated,
        8.verticalSpace,
        Text(
          label,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: active ? Colors.black : inactiveColor,
          ),
        ),
      ],
    );
  }
}

class WeChatChatPage extends StatefulWidget {
  const WeChatChatPage(
      {super.key, required this.character, required this.endpoint});

  final AiCharacter character;
  final ApiEndpoint endpoint;

  @override
  State<WeChatChatPage> createState() => _WeChatChatPageState();
}

class _WeChatChatPageState extends State<WeChatChatPage> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final _messages = <_ChatMessage>[];

  @override
  void initState() {
    super.initState();
    _messages.addAll([
      _ChatMessage(
          text: widget.character.greeting,
          isSelf: false,
          timestamp: DateTime.now().subtract(const Duration(minutes: 3))),
      _ChatMessage(
          text: '很高兴认识你，我是 ${widget.endpoint.name}。',
          isSelf: false,
          timestamp: DateTime.now().subtract(const Duration(minutes: 2))),
      _ChatMessage(
          text: 'Hi~',
          isSelf: true,
          timestamp: DateTime.now().subtract(const Duration(minutes: 1))),
    ]);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(
          _ChatMessage(text: text, isSelf: true, timestamp: DateTime.now()));
      _controller.clear();
    });
    Future.delayed(const Duration(milliseconds: 50), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 80,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: widget.character.avatarColor,
              child: Text(
                widget.character.name.characters.first,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.character.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  Text(widget.endpoint.name,
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: _showEndpointInfo),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isSelf = message.isSelf;
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: Row(
                    mainAxisAlignment: isSelf
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isSelf) _buildAvatar(isSelf: false),
                      if (!isSelf) 8.horizontalSpace,
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color:
                                isSelf ? const Color(0xFF07C160) : Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.r),
                              topRight: Radius.circular(12.r),
                              bottomLeft: Radius.circular(isSelf ? 12.r : 4.r),
                              bottomRight: Radius.circular(isSelf ? 4.r : 12.r),
                            ),
                          ),
                          child: Text(
                            message.text,
                            style: TextStyle(
                              color: isSelf ? Colors.white : Colors.black87,
                              fontSize: 15.sp,
                              height: 1.35,
                            ),
                          ),
                        ),
                      ),
                      if (isSelf) 8.horizontalSpace,
                      if (isSelf) _buildAvatar(isSelf: true),
                    ],
                  ),
                );
              },
            ),
          ),
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildAvatar({required bool isSelf}) {
    return CircleAvatar(
      radius: 18.w,
      backgroundColor:
          isSelf ? const Color(0xFF07C160) : widget.character.avatarColor,
      child: Text(
        isSelf ? '我' : widget.character.name.characters.first,
        style: TextStyle(
            color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.mic_none),
                color: Colors.grey),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration.collapsed(hintText: '发消息…'),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
            ),
            8.horizontalSpace,
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.emoji_emotions_outlined),
                color: Colors.grey),
            IconButton(
                onPressed: _sendMessage,
                icon: const Icon(Icons.send),
                color: const Color(0xFF07C160)),
          ],
        ),
      ),
    );
  }

  void _showEndpointInfo() {
    Get.dialog(
      AlertDialog(
        title: Text(widget.endpoint.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '类型：${widget.endpoint.type == ApiProviderType.openai ? 'OpenAI 兼容' : 'Google Gemini'}'),
            const SizedBox(height: 8),
            Text('Base URL：${widget.endpoint.baseUrl}'),
            const SizedBox(height: 8),
            Text(
                '默认模型：${widget.endpoint.model.isEmpty ? '未设置' : widget.endpoint.model}'),
            if (widget.endpoint.notes.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text('备注：${widget.endpoint.notes}')
            ],
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('关闭')),
        ],
      ),
    );
  }
}

class _ChatMessage {
  _ChatMessage(
      {required this.text, required this.isSelf, required this.timestamp});

  final String text;
  final bool isSelf;
  final DateTime timestamp;
}

String _formatTime(DateTime time) {
  final now = DateTime.now();
  if (now.year == time.year && now.month == time.month && now.day == time.day) {
    return DateFormat('HH:mm').format(time);
  }
  return DateFormat('MM-dd HH:mm').format(time);
}
