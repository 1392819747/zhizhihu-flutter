import 'package:characters/characters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:openim_common/openim_common.dart';

class WeChatMockPage extends StatefulWidget {
  const WeChatMockPage({super.key});

  @override
  State<WeChatMockPage> createState() => _WeChatMockPageState();
}

class _WeChatMockPageState extends State<WeChatMockPage> {
  int _currentIndex = 0;
  late List<MockConversation> _conversations;

  @override
  void initState() {
    super.initState();
    _conversations = _buildSampleConversations();
  }

  List<MockConversation> _buildSampleConversations() {
    final now = DateTime.now();
    return [
      MockConversation(
        id: 'assistant',
        name: '小助手',
        avatarColor: const Color(0xFF4CD964),
        unreadCount: 2,
        cannedReplies: const [
          '会议安排已经发送到您邮箱，请注意查收。',
          '若需进一步帮助，随时告诉我。',
          '收到，稍后我会整理一份概要给您。',
        ],
        messages: [
          MockMessage(
            text: '您好，这里是小助手，请问有什么可以帮您？',
            isSelf: false,
            timestamp: now.subtract(const Duration(minutes: 28)),
          ),
          MockMessage(
            text: '想了解一下下午的会议安排。',
            isSelf: true,
            timestamp: now.subtract(const Duration(minutes: 25)),
          ),
          MockMessage(
            text: '好的，我立刻发给您。',
            isSelf: false,
            timestamp: now.subtract(const Duration(minutes: 24)),
          ),
        ],
      ),
      MockConversation(
        id: 'design-group',
        name: '设计讨论群',
        avatarColor: const Color(0xFF007AFF),
        unreadCount: 5,
        cannedReplies: const [
          '欢迎提出想法，大家一起讨论。',
          '新的配色方案已经同步在群文件。',
          '感谢，有任何建议随时反馈。',
        ],
        messages: [
          MockMessage(
            text: '新版图标大家觉得怎么样？',
            isSelf: false,
            timestamp: now.subtract(const Duration(hours: 2, minutes: 10)),
          ),
          MockMessage(
            text: '挺清爽的，可以再优化细节。',
            isSelf: true,
            timestamp: now.subtract(const Duration(hours: 2, minutes: 5)),
          ),
          MockMessage(
            text: '收到，后续再迭代一版。',
            isSelf: false,
            timestamp: now.subtract(const Duration(hours: 2, minutes: 2)),
          ),
        ],
      ),
      MockConversation(
        id: 'file-transfer',
        name: '文件传输助手',
        avatarColor: const Color(0xFF5856D6),
        unreadCount: 0,
        cannedReplies: const [
          '文件已妥善保存，如需帮助请告知。',
          '我可以继续为您传输其它文件。',
        ],
        messages: [
          MockMessage(
            text: '日报模板.xlsx 已上传 ✅',
            isSelf: false,
            timestamp: now.subtract(const Duration(hours: 6)),
          ),
          MockMessage(
            text: '收到，谢谢！',
            isSelf: true,
            timestamp: now.subtract(const Duration(hours: 5, minutes: 55)),
          ),
        ],
      ),
      MockConversation(
        id: 'ai-lab',
        name: 'AI Lab',
        avatarColor: const Color(0xFFFF9500),
        unreadCount: 0,
        cannedReplies: const [
          '我是您的智能助手，随时可以尝试新的对话体验。',
          '未来这里将接入 AI 能力，敬请期待。',
        ],
        messages: [
          MockMessage(
            text: '欢迎来到 AI Lab，您可以先随便聊聊。',
            isSelf: false,
            timestamp: now.subtract(const Duration(minutes: 40)),
          ),
        ],
      ),
    ];
  }

  void _openConversation(MockConversation conversation) async {
    final result = await Get.to<MockConversation>(
      () => WeChatChatPage(conversation: conversation),
      fullscreenDialog: false,
    );
    if (result != null) {
      setState(() {
        _conversations.removeWhere((element) => element.id == result.id);
        _conversations.insert(0, result.copyWith(unreadCount: 0));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      appBar: AppBar(
        backgroundColor: const Color(0xFF07C160),
        elevation: 0,
        centerTitle: true,
        title: Text(
          '微信',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_circle_outline),
            color: Colors.white,
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildChatsTab(),
          _buildPlaceholder('通讯录正在建设中'),
          _buildPlaceholder('发现更多精彩即将上线'),
          _buildPlaceholder('个人中心开发中'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF07C160),
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: '微信',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_outlined),
            activeIcon: Icon(Icons.group),
            label: '通讯录',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: '发现',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: '我',
          ),
        ],
      ),
    );
  }

  Widget _buildChatsTab() {
    if (_conversations.isEmpty) {
      return const Center(child: Text('暂无会话，开始一段新的聊天吧'));
    }
    return ListView.separated(
      itemCount: _conversations.length,
      separatorBuilder: (_, __) => Divider(
        height: 0,
        indent: 76.w,
        endIndent: 16.w,
      ),
      itemBuilder: (context, index) {
        final conversation = _conversations[index];
        return InkWell(
          onTap: () => _openConversation(conversation),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24.w,
                  backgroundColor: conversation.avatarColor,
                  child: Text(
                    conversation.name.characters.first,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              conversation.name,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Text(
                            _formatTime(conversation.lastTimestamp),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      6.verticalSpace,
                      Text(
                        conversation.lastSnippet,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (conversation.unreadCount > 0) ...[
                  10.horizontalSpace,
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF3B30),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      '${conversation.unreadCount}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlaceholder(String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.grey,
        ),
      ),
    );
  }

  String _formatTime(DateTime? time) {
    if (time == null) return '';
    final formatter = DateFormat('HH:mm');
    return formatter.format(time);
  }
}

class WeChatChatPage extends StatefulWidget {
  const WeChatChatPage({super.key, required this.conversation});

  final MockConversation conversation;

  @override
  State<WeChatChatPage> createState() => _WeChatChatPageState();
}

class _WeChatChatPageState extends State<WeChatChatPage> {
  late List<MockMessage> _messages;
  late MockConversation _conversation;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _conversation = widget.conversation;
    _messages = List<MockMessage>.from(widget.conversation.messages);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final content = _controller.text.trim();
    if (content.isEmpty) return;
    setState(() {
      _messages.add(MockMessage(
        text: content,
        isSelf: true,
        timestamp: DateTime.now(),
      ));
    });
    _controller.clear();
    _scrollToBottom();
    _scheduleMockReply();
  }

  void _scheduleMockReply() {
    if (_conversation.cannedReplies.isEmpty) return;
    final reply = _conversation.cannedReplies[_messages.length % _conversation.cannedReplies.length];
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      setState(() {
        _messages.add(MockMessage(
          text: reply,
          isSelf: false,
          timestamp: DateTime.now(),
        ));
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 80.h,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  void _returnResult() {
    final updated = _conversation.copyWith(
      messages: List<MockMessage>.from(_messages),
      unreadCount: 0,
    );
    Get.back(result: updated);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _returnResult();
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFEDEDED),
        appBar: AppBar(
          backgroundColor: const Color(0xFF07C160),
          elevation: 0,
          titleSpacing: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
            color: Colors.white,
            onPressed: _returnResult,
          ),
          title: Row(
            children: [
              CircleAvatar(
                radius: 16.w,
                backgroundColor: _conversation.avatarColor,
                child: Text(
                  _conversation.name.characters.first,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              8.horizontalSpace,
              Text(
                _conversation.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_horiz),
              color: Colors.white,
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
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
                        if (!isSelf) _buildChatAvatar(isSelf: false),
                        if (!isSelf) 8.horizontalSpace,
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: isSelf
                                  ? const Color(0xFF07C160)
                                  : Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.r),
                                topRight: Radius.circular(12.r),
                                bottomLeft:
                                    Radius.circular(isSelf ? 12.r : 4.r),
                                bottomRight:
                                    Radius.circular(isSelf ? 4.r : 12.r),
                              ),
                            ),
                            child: Text(
                              message.text,
                              style: TextStyle(
                                color: isSelf ? Colors.white : Colors.black87,
                                fontSize: 16.sp,
                                height: 1.35,
                              ),
                            ),
                          ),
                        ),
                        if (isSelf) 8.horizontalSpace,
                        if (isSelf) _buildChatAvatar(isSelf: true),
                      ],
                    ),
                  );
                },
              ),
            ),
            _buildInputBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildChatAvatar({required bool isSelf}) {
    return CircleAvatar(
      radius: 18.w,
      backgroundColor:
          isSelf ? const Color(0xFF07C160) : _conversation.avatarColor,
      child: Text(
        isSelf ? '我' : _conversation.name.characters.first,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
        ),
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
              color: Colors.grey,
            ),
            Expanded(
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration.collapsed(
                    hintText: '发消息…',
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
            ),
            8.horizontalSpace,
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.emoji_emotions_outlined),
              color: Colors.grey,
            ),
            IconButton(
              onPressed: _sendMessage,
              icon: const Icon(Icons.send),
              color: const Color(0xFF07C160),
            ),
          ],
        ),
      ),
    );
  }
}

class MockConversation {
  const MockConversation({
    required this.id,
    required this.name,
    required this.messages,
    required this.avatarColor,
    required this.unreadCount,
    required this.cannedReplies,
  });

  final String id;
  final String name;
  final List<MockMessage> messages;
  final Color avatarColor;
  final int unreadCount;
  final List<String> cannedReplies;

  MockConversation copyWith({
    List<MockMessage>? messages,
    int? unreadCount,
  }) {
    return MockConversation(
      id: id,
      name: name,
      avatarColor: avatarColor,
      cannedReplies: cannedReplies,
      messages: messages ?? this.messages,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  MockMessage? get lastMessage => messages.isNotEmpty ? messages.last : null;

  DateTime? get lastTimestamp => lastMessage?.timestamp;

  String get lastSnippet => lastMessage?.text ?? '';
}

class MockMessage {
  const MockMessage({
    required this.text,
    required this.isSelf,
    required this.timestamp,
  });

  final String text;
  final bool isSelf;
  final DateTime timestamp;
}
