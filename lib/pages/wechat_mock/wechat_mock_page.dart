import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:openim_common/openim_common.dart';

import '../../services/api_settings_service.dart';
import '../../routes/app_navigator.dart';
import '../api_settings/api_settings_logic.dart';
import 'wechat_mock_logic.dart';

class WeChatMockPage extends GetView<WeChatMockLogic> {
  const WeChatMockPage({super.key});

  ApiSettingsLogic get _apiLogic => Get.find<ApiSettingsLogic>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color(0xFFEDEDED),
        appBar: AppBar(
          backgroundColor: const Color(0xFF07C160),
          elevation: 0,
          title: const Text('微信'),
          centerTitle: true,
          actions: const [
            IconButton(
              onPressed: AppNavigator.startApiSettings,
              icon: Icon(Icons.tune),
              color: Colors.white,
              tooltip: 'API 设置',
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: '微信'),
              Tab(text: '通讯录'),
              Tab(text: '发现'),
              Tab(text: '我'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildChatsTab(),
            _buildContactsTab(),
            _buildPlaceholder('探索更多玩法，未来将接入 SillyTavern 式扩展。'),
            _buildPlaceholder('个人中心正在开发中，敬请期待。'),
          ],
        ),
      ),
    );
  }

  Widget _buildChatsTab() {
    return Obx(() {
      final items = controller.conversations;
      if (items.isEmpty) {
        return _buildPlaceholder('还没有配置 AI 伙伴，点击右上角「API 设置」去创建吧。');
      }
      return ListView.separated(
        itemCount: items.length,
        separatorBuilder: (_, __) => Divider(height: 0, indent: 76.w, endIndent: 16.w),
        itemBuilder: (context, index) {
          final conversation = items[index];
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
                    backgroundColor: conversation.character.avatarColor,
                    child: Text(
                      conversation.character.name.characters.first,
                      style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
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
                                conversation.character.name,
                                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black),
                              ),
                            ),
                            Text(_formatTime(conversation.preview.lastTime),
                                style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600)),
                          ],
                        ),
                        6.verticalSpace,
                        Text(
                          conversation.preview.lastMessage,
                          style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade700),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildContactsTab() {
    return Obx(() {
      final characters = controller.service.characters;
      final selectedId = controller.service.selectedCharacterId.value;
      final endpoints = {for (final ep in controller.service.endpoints) ep.id: ep};
      final padding = EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h);

      if (characters.isEmpty) {
        return Container(
          color: const Color(0xFFF2F2F7),
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContactsHeader(),
              SizedBox(height: 16.h),
              _buildAddCharacterButton(),
              SizedBox(height: 24.h),
              _buildContactsEmptyHint(),
            ],
          ),
        );
      }

      return Container(
        color: const Color(0xFFF2F2F7),
        child: ListView(
          padding: padding,
          children: [
            _buildContactsHeader(),
            SizedBox(height: 16.h),
            _buildAddCharacterButton(),
            SizedBox(height: 16.h),
            ...characters.map((character) {
              final endpoint = endpoints[character.endpointId];
              final isDefault = selectedId == character.id;
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: _buildContactCard(
                  character: character,
                  endpoint: endpoint,
                  isDefault: isDefault,
                ),
              );
            }),
          ],
        ),
      );
    });
  }

  Widget _buildContactsHeader() {
    final persona = controller.service.persona.value;
    final loreCount = controller.service.worldInfos.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'AI 联系人',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1C1C1E),
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          '集中管理 SillyTavern 风格的 AI 伙伴，轻点卡片即可开始对话。',
          style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
        ),
        if (persona != null) ...[
          SizedBox(height: 16.h),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0F000000),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            padding: EdgeInsets.all(16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: const BoxDecoration(
                    color: Color(0x26007AFF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(CupertinoIcons.person_crop_circle, color: Color(0xFF007AFF)),
                ),
                12.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        persona.displayName,
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                      ),
                      if (persona.description.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 6.h),
                          child: Text(
                            persona.description,
                            style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
                          ),
                        ),
                    ],
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  minSize: 0,
                  onPressed: AppNavigator.startApiSettings,
                  child: const Icon(CupertinoIcons.chevron_forward, color: Color(0xFF8E8E93)),
                ),
              ],
            ),
          ),
        ],
        if (loreCount > 0) ...[
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: AppNavigator.startApiSettings,
            child: Text(
              '世界信息：$loreCount 条（点击管理）',
              style: TextStyle(fontSize: 12.sp, color: const Color(0xFF007AFF)),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildAddCharacterButton() {
    return CupertinoButton.filled(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      borderRadius: BorderRadius.circular(14.r),
      onPressed: () => _apiLogic.addOrEditCharacter(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(CupertinoIcons.person_add_solid, size: 18),
          6.horizontalSpace,
          Text(
            '新增 AI 角色',
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildContactsEmptyHint() {
    final borderRadius = BorderRadius.circular(18.r);
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: const BoxDecoration(
                  color: Color(0x2607C160),
                  shape: BoxShape.circle,
                ),
                child: const Icon(CupertinoIcons.chat_bubble_text, color: Color(0xFF07C160)),
              ),
              12.horizontalSpace,
              Expanded(
                child: Text(
                  '还没有 AI 联系人',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            '点击上方按钮创建你的第一个 AI 伙伴，绑定接口后会自动出现在列表中。',
            style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade600, height: 1.35),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required AiCharacter character,
    required ApiEndpoint? endpoint,
    required bool isDefault,
  }) {
    return GestureDetector(
      onTap: () => _openCharacterConversation(character),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 14,
              offset: Offset(0, 6),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24.w,
              backgroundColor: character.avatarColor,
              child: Text(
                character.name.characters.first,
                style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
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
                          character.name,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1C1C1E),
                          ),
                        ),
                      ),
                      if (isDefault)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: const Color(0x1F34C759),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            '默认',
                            style: TextStyle(fontSize: 11.sp, color: const Color(0xFF34C759)),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    endpoint == null
                        ? '未绑定接口'
                        : '${endpoint.name} · ${endpoint.model.isEmpty ? endpoint.baseUrl : endpoint.model}',
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => _showCharacterActions(character),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                child: const Icon(
                  CupertinoIcons.ellipsis_vertical,
                  size: 20,
                  color: Color(0xFF8E8E93),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openCharacterConversation(AiCharacter character) {
    final conv = controller.conversations.firstWhereOrNull(
      (element) => element.character.id == character.id,
    );
    if (conv != null) {
      _openConversation(conv);
    } else {
      IMViews.showToast('请先为该角色绑定接口');
    }
  }

  void _showCharacterActions(AiCharacter character) {
    final isDefault = controller.service.selectedCharacterId.value == character.id;
    final endpoint = controller.service.endpoints.firstWhereOrNull(
      (element) => element.id == character.endpointId,
    );
    showCupertinoModalPopup(
      context: Get.context!,
      builder: (_) => CupertinoActionSheet(
        title: Text(character.name),
        message: Text(
          endpoint == null
              ? '未绑定接口'
              : '${endpoint.name} · ${endpoint.model.isEmpty ? endpoint.baseUrl : endpoint.model}',
          style: const TextStyle(fontSize: 13),
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Get.back();
              _openCharacterConversation(character);
            },
            child: const Text('发起聊天'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Get.back();
              _showCharacterPromptPreview(character);
            },
            child: const Text('查看提示组合'),
          ),
          if (!isDefault)
            CupertinoActionSheetAction(
              onPressed: () {
                Get.back();
                _apiLogic.setDefaultCharacter(character.id);
              },
              child: const Text('设为默认角色'),
            ),
          CupertinoActionSheetAction(
            onPressed: () {
              Get.back();
              _apiLogic.addOrEditCharacter(character: character);
            },
            child: const Text('编辑资料'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Get.back();
              _apiLogic.removeCharacter(character);
            },
            child: const Text('删除角色'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Get.back(),
          child: const Text('取消'),
        ),
      ),
    );
  }

  void _showCharacterPromptPreview(AiCharacter character) {
    final conv = controller.conversations.firstWhereOrNull(
      (element) => element.character.id == character.id,
    );
    if (conv == null) {
      IMViews.showToast('请先为该角色绑定接口');
      return;
    }
    Get.dialog(
      AlertDialog(
        title: Text('${character.name} · 提示预览'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Persona',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
              ),
              SizedBox(height: 6.h),
              if (conv.persona != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(conv.persona!.displayName, style: TextStyle(fontSize: 13.sp)),
                    if (conv.persona!.description.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: Text(
                          conv.persona!.description,
                          style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
                        ),
                      ),
                  ],
                )
              else
                Text('未设置用户个性', style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade500)),
              SizedBox(height: 12.h),
              Text(
                '角色设定',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
              ),
              SizedBox(height: 6.h),
              Text(character.persona.isEmpty ? '未填写' : character.persona,
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade700)),
              SizedBox(height: 12.h),
              Text(
                '世界信息 (${conv.worldInfos.length})',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
              ),
              SizedBox(height: 6.h),
              if (conv.worldInfos.isEmpty)
                Text('暂无设定条目', style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade500))
              else
                ...conv.worldInfos.map(
                  (entry) => Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(entry.title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp)),
                        SizedBox(height: 4.h),
                        Text(entry.content, style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade700)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('关闭')),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(String text) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Text(
          text,
          style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Future<void> _openConversation(WeChatConversation conversation) async {
    final result = await Get.to<ChatPreview>(
      () => WeChatChatPage(conversation: conversation),
    );
    if (result != null) {
      controller.updatePreview(conversation.character.id, result);
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final formatter = DateFormat('HH:mm');
    if (now.day == time.day && now.month == time.month && now.year == time.year) {
      return formatter.format(time);
    }
    return DateFormat('MM-dd HH:mm').format(time);
  }
}

class WeChatChatPage extends StatefulWidget {
  const WeChatChatPage({super.key, required this.conversation});

  final WeChatConversation conversation;

  AiCharacter get character => conversation.character;
  ApiEndpoint get endpoint => conversation.endpoint;
  UserPersona? get persona => conversation.persona;
  List<WorldInfoEntry> get worldInfos => conversation.worldInfos;
  GenerationConfig get generationConfig => conversation.generationConfig;

  @override
  State<WeChatChatPage> createState() => _WeChatChatPageState();
}

class _WeChatChatPageState extends State<WeChatChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late List<_ChatMessage> _messages;

  List<String> get _fallbackReplies => widget.character.sampleReplies.isNotEmpty
      ? widget.character.sampleReplies
      : [
          if (widget.persona?.style.isNotEmpty == true)
            '按照我的风格（${widget.persona!.style}）来回应你。'
          else
            '这听起来很有意思，我们继续聊聊吧。',
          if (widget.persona?.goals.isNotEmpty == true)
            '记得我们的目标：${widget.persona!.goals}。'
          else
            '让我整理一下思路，再为你提供建议。',
          '收到，我会以 ${widget.endpoint.name} 的接口风格进行输出。',
        ];

  @override
  void initState() {
    super.initState();
    _messages = [
      _ChatMessage(
        text: widget.character.greeting,
        isSelf: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
      ),
    ];
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
      _messages.add(_ChatMessage(text: content, isSelf: true, timestamp: DateTime.now()));
    });
    _controller.clear();
    _scrollToBottom(animated: false);
    _scheduleMockReply();
  }

  void _scheduleMockReply() {
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      final reply = _fallbackReplies[_messages.length % _fallbackReplies.length];
      setState(() {
        _messages.add(_ChatMessage(text: reply, isSelf: false, timestamp: DateTime.now()));
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom({bool animated = true}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      final target = _scrollController.position.maxScrollExtent;
      if (!animated) {
        _scrollController.jumpTo(target);
        return;
      }
      final distance = (target - _scrollController.position.pixels).abs();
      final duration = Duration(
        milliseconds: distance < 120 ? 140 : 220,
      );
      _scrollController.animateTo(
        target,
        duration: duration,
        curve: Curves.easeOut,
      );
    });
  }

  void _exit() {
    final last = _messages.isNotEmpty ? _messages.last : null;
    if (last != null) {
      Get.back(result: ChatPreview(lastMessage: last.text, lastTime: last.timestamp));
    } else {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    final contextBanner = _buildConversationContextBanner();
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      appBar: AppBar(
        backgroundColor: const Color(0xFF07C160),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          color: Colors.white,
          onPressed: _exit,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.character.name, style: const TextStyle(color: Colors.white)),
            Text(
              widget.endpoint.name,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => _showEndpointInfo(),
            icon: const Icon(Icons.info_outline, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          if (contextBanner != null) contextBanner,
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
                    mainAxisAlignment: isSelf ? MainAxisAlignment.end : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isSelf) _buildAvatar(isSelf: false),
                      if (!isSelf) 8.horizontalSpace,
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: isSelf ? const Color(0xFF07C160) : Colors.white,
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
      backgroundColor: isSelf ? const Color(0xFF07C160) : widget.character.avatarColor,
      child: Text(
        isSelf ? '我' : widget.character.name.characters.first,
        style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget? _buildConversationContextBanner() {
    final persona = widget.persona;
    final lore = widget.worldInfos;
    if (persona == null && lore.isEmpty) {
      return null;
    }
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 0),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(CupertinoIcons.info_circle_fill, color: Color(0xFF07C160)),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '上下文已启用',
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: const Color(0xFF1C1C1E)),
                ),
                SizedBox(height: 4.h),
                Text(
                  [
                    if (persona != null) 'Persona：${persona.displayName}',
                    if (lore.isNotEmpty) '世界信息：${lore.length} 条',
                  ].join(' · '),
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            minSize: 0,
            onPressed: _showPromptContextSheet,
            child: const Icon(CupertinoIcons.chevron_forward, color: Color(0xFF8E8E93)),
          ),
        ],
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
            IconButton(onPressed: () {}, icon: const Icon(Icons.mic_none), color: Colors.grey),
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
            IconButton(onPressed: () {}, icon: const Icon(Icons.emoji_emotions_outlined), color: Colors.grey),
            IconButton(onPressed: _sendMessage, icon: const Icon(Icons.send), color: const Color(0xFF07C160)),
          ],
        ),
      ),
    );
  }

  void _showEndpointInfo() {
    Get.dialog(
      AlertDialog(
        title: Text(widget.endpoint.name),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('类型：${widget.endpoint.type == ApiProviderType.openai ? 'OpenAI 兼容' : 'Google Gemini'}'),
              const SizedBox(height: 8),
              Text('Base URL：${widget.endpoint.baseUrl}'),
              const SizedBox(height: 8),
              Text('默认模型：${widget.endpoint.model.isEmpty ? '未设置' : widget.endpoint.model}'),
              const SizedBox(height: 12),
              Text(
                '生成参数',
                style: TextStyle(fontWeight: FontWeight.w600, color: const Color(0xFF1C1C1E), fontSize: 14.sp),
              ),
              SizedBox(height: 8.h),
              Wrap(
                spacing: 10.w,
                runSpacing: 6.h,
                children: [
                  _buildInfoChip('temperature', widget.generationConfig.temperature.toStringAsFixed(2)),
                  _buildInfoChip('top_p', widget.generationConfig.topP.toStringAsFixed(2)),
                  _buildInfoChip('top_k', widget.generationConfig.topK.toString()),
                  _buildInfoChip('max_tokens', widget.generationConfig.maxTokens.toString()),
                  _buildInfoChip(
                    'presence_penalty',
                    widget.generationConfig.presencePenalty.toStringAsFixed(2),
                  ),
                  _buildInfoChip(
                    'frequency_penalty',
                    widget.generationConfig.frequencyPenalty.toStringAsFixed(2),
                  ),
                  _buildInfoChip('stream', widget.generationConfig.stream ? 'ON' : 'OFF'),
                ],
              ),
              if (widget.endpoint.notes.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text('备注：${widget.endpoint.notes}'),
              ],
              if (widget.persona != null) ...[
                SizedBox(height: 16.h),
                Text(
                  'Persona',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
                ),
                SizedBox(height: 8.h),
                Text(
                  widget.persona!.description.isEmpty
                      ? widget.persona!.displayName
                      : '${widget.persona!.displayName} · ${widget.persona!.description}',
                ),
              ],
              if (widget.worldInfos.isNotEmpty) ...[
                SizedBox(height: 16.h),
                Text(
                  '世界信息 (${widget.worldInfos.length})',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
                ),
                SizedBox(height: 8.h),
                ...widget.worldInfos.map(
                  (entry) => Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.title,
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          entry.content,
                          style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('关闭')),
        ],
      ),
    );
  }

  void _showPromptContextSheet() {
    final persona = widget.persona;
    final lore = widget.worldInfos;
    Get.dialog(
      AlertDialog(
        title: Text('${widget.character.name} · 对话上下文'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (persona != null) ...[
                Text(
                  'Persona · ${persona.displayName}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
                ),
                SizedBox(height: 6.h),
                if (persona.description.isNotEmpty)
                  Text(persona.description, style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade700)),
                if (persona.goals.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text('目标：${persona.goals}', style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600)),
                ],
                if (persona.style.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text('风格：${persona.style}', style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600)),
                ],
                SizedBox(height: 12.h),
              ],
              Text(
                '世界信息 (${lore.length})',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
              ),
              SizedBox(height: 6.h),
              if (lore.isEmpty)
                Text('暂无设定条目', style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600))
              else
                ...lore.map(
                  (entry) => Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                entry.title,
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
                              ),
                            ),
                            Text(
                              '优先级 ${entry.priority}',
                              style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          entry.content,
                          style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade700),
                        ),
                        SizedBox(height: 4.h),
                        Wrap(
                          spacing: 6.w,
                          children: entry.keywords
                              .map((k) => Chip(
                                    label: Text(k, style: TextStyle(fontSize: 11.sp)),
                                    backgroundColor: const Color(0xFFE5E5EA),
                                    padding: EdgeInsets.zero,
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('关闭')),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E5EA),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        '$label = $value',
        style: TextStyle(fontSize: 11.sp, color: const Color(0xFF3C3C43)),
      ),
    );
  }
}

class _ChatMessage {
  _ChatMessage({required this.text, required this.isSelf, required this.timestamp});

  final String text;
  final bool isSelf;
  final DateTime timestamp;
}
