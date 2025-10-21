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
        backgroundColor: const Color(0xFFF5F7FA),
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
                          bottom: 12.h + MediaQuery.of(context).padding.bottom,
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
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _gradientColors,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chats',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1,
                  ),
                ),
                Text(
                  '与AI伙伴畅聊',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
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


  Widget _buildChatsSection() {
    return Obx(() {
      final items = controller.conversations;
      if (items.isEmpty) {
        return _buildEmptyState();
      }
      return ListView.separated(
        padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
        itemCount: items.length,
        separatorBuilder: (_, __) => SizedBox(height: 8.h),
        itemBuilder: (context, index) {
          final conversation = items[index];
          return _ConversationCard(
            conversation: conversation,
            onTap: () => _openConversation(conversation),
          );
        },
      );
    });
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F7FA),
              borderRadius: BorderRadius.circular(60.r),
            ),
            child: Icon(
              Icons.chat_bubble_outline,
              size: 60.w,
              color: const Color(0xFF9CA3AF),
            ),
          ),
          24.verticalSpace,
          Text(
            '还没有AI伙伴',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF374151),
            ),
          ),
          8.verticalSpace,
          Text(
            '点击右上角「API 设置」去创建你的第一个AI伙伴吧',
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF6B7280),
            ),
            textAlign: TextAlign.center,
          ),
          32.verticalSpace,
          ElevatedButton.icon(
            onPressed: AppNavigator.startApiSettings,
            icon: const Icon(Icons.add),
            label: const Text('创建AI伙伴'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5D6CF5),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Obx(() {
      final conversationCount = controller.conversations.length;
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
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
            16.horizontalSpace,
            Expanded(
              child: _NavItem.secondary(
                icon: Icons.search,
                label: 'Search',
                onTap: () => AppNavigator.startSearch(),
              ),
            ),
            16.horizontalSpace,
            Expanded(
              child: _NavItem.profile(
                label: 'Profile',
                character: controller.defaultCharacter,
              ),
            ),
          ],
        ),
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

class _ConversationCard extends StatelessWidget {
  const _ConversationCard({required this.conversation, required this.onTap});

  final WeChatConversation conversation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            _Avatar(character: conversation.character, size: 56.w),
            16.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation.character.name,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF111827),
                          ),
                        ),
                      ),
                      Text(
                        _formatTime(conversation.preview.lastTime),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                  4.verticalSpace,
                  Text(
                    conversation.preview.lastMessage,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF6B7280),
                      height: 1.4,
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
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            character.avatarColor,
            character.avatarColor.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(size / 2),
        boxShadow: [
          BoxShadow(
            color: character.avatarColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          character.name.characters.first,
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.4,
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
    this.onTap,
    required this.active,
  });

  factory _NavItem.primary({
    required IconData icon,
    required String label,
    String? badge,
    VoidCallback? onTap,
  }) {
    return _NavItem._(
      icon: icon,
      label: label,
      badge: badge,
      onTap: onTap,
      active: true,
    );
  }

  factory _NavItem.secondary({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return _NavItem._(
      icon: icon,
      label: label,
      onTap: onTap,
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
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Color activeColor = const Color(0xFF5D6CF5);
    final Color inactiveColor = const Color(0xFF9CA3AF);
    
    final Widget circleContent;

    if (character != null) {
      circleContent = _Avatar(character: character!, size: 32.w);
    } else {
      final IconData iconData = icon ?? Icons.person;
      circleContent = Icon(
        iconData,
        size: 20.w,
        color: active ? activeColor : inactiveColor,
      );
    }

    final double circleSize = 48.w;
    final Widget decorated = Container(
      height: circleSize,
      width: circleSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: active ? activeColor.withOpacity(0.1) : const Color(0xFFF9FAFB),
        border: active 
            ? Border.all(color: activeColor.withOpacity(0.2), width: 1)
            : null,
      ),
      child: badge == null
          ? Center(child: circleContent)
          : Stack(
              clipBehavior: Clip.none,
              children: [
                Center(child: circleContent),
                Positioned(
                  top: 4.h,
                  right: 4.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: activeColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      badge!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
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
        GestureDetector(
          onTap: onTap,
          child: decorated,
        ),
        6.verticalSpace,
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: active ? activeColor : inactiveColor,
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
