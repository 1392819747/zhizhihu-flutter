import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:openim_common/openim_common.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../routes/app_navigator.dart';
import '../../services/api_settings_service.dart';
import '../api_settings/api_settings_logic.dart';
import 'wechat_mock_logic.dart';

class WeChatMockPage extends StatefulWidget {
  const WeChatMockPage({super.key});

  @override
  State<WeChatMockPage> createState() => _WeChatMockPageState();
}

class _WeChatMockPageState extends State<WeChatMockPage> {
  late final WeChatMockLogic logic;
  late final ApiSettingsLogic apiLogic;
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    logic = Get.find<WeChatMockLogic>();
    apiLogic = Get.find<ApiSettingsLogic>();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _switchTab(int index) {
    if (_currentIndex == index) {
      return;
    }
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = TDTheme.of(context);
    return Scaffold(
      backgroundColor: theme.grayColor1,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildChatsPage(context),
                _buildContactsPage(context),
                _buildDiscoverPage(context),
                _buildProfilePage(context),
              ],
            ),
          ),
          TDBottomTabBar(
            TDBottomTabBarBasicType.iconText,
            outlineType: TDBottomTabBarOutlineType.capsule,
            componentType: TDBottomTabBarComponentType.label,
            backgroundColor: Colors.transparent,
            selectedBgColor: theme.brandColor1,
            unselectedBgColor: theme.grayColor1,
            currentIndex: _currentIndex,
            navigationTabs: _buildTabConfigs(context),
          ),
        ],
      ),
    );
  }

  List<TDBottomTabBarTabConfig> _buildTabConfigs(BuildContext context) {
    final theme = TDTheme.of(context);
    final selectedStyle = TextStyle(
      fontSize: 11.sp,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );
    final unselectedStyle = TextStyle(
      fontSize: 11.sp,
      fontWeight: FontWeight.w500,
      color: theme.fontGyColor2,
    );
    return [
      TDBottomTabBarTabConfig(
        tabText: '微信',
        selectedIcon: Icon(TDIcons.chat_bubble_filled, color: Colors.white, size: 22.w),
        unselectedIcon: Icon(TDIcons.chat_bubble, color: theme.fontGyColor2, size: 22.w),
        selectTabTextStyle: selectedStyle,
        unselectTabTextStyle: unselectedStyle,
        onTap: () => _switchTab(0),
      ),
      TDBottomTabBarTabConfig(
        tabText: '通讯录',
        selectedIcon: Icon(TDIcons.user_1_filled, color: Colors.white, size: 22.w),
        unselectedIcon: Icon(TDIcons.user_1, color: theme.fontGyColor2, size: 22.w),
        selectTabTextStyle: selectedStyle,
        unselectTabTextStyle: unselectedStyle,
        onTap: () => _switchTab(1),
      ),
      TDBottomTabBarTabConfig(
        tabText: '发现',
        selectedIcon: Icon(TDIcons.compass_filled, color: Colors.white, size: 22.w),
        unselectedIcon: Icon(TDIcons.compass, color: theme.fontGyColor2, size: 22.w),
        selectTabTextStyle: selectedStyle,
        unselectTabTextStyle: unselectedStyle,
        onTap: () => _switchTab(2),
      ),
      TDBottomTabBarTabConfig(
        tabText: '我',
        selectedIcon: Icon(TDIcons.user_circle_filled, color: Colors.white, size: 22.w),
        unselectedIcon: Icon(TDIcons.user_circle, color: theme.fontGyColor2, size: 22.w),
        selectTabTextStyle: selectedStyle,
        unselectTabTextStyle: unselectedStyle,
        onTap: () => _switchTab(3),
      ),
    ];
  }

  Widget _buildChatsPage(BuildContext context) {
    final theme = TDTheme.of(context);
    return Column(
      children: [
        _buildNavBar(
          context,
          title: '微信',
          actions: [
            TDNavBarItem(
              icon: TDIcons.setting_1,
              iconColor: Colors.white,
              action: AppNavigator.startApiSettings,
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: TDSearchBar(
            placeHolder: '搜索对话或角色',
            backgroundColor: Colors.white,
            style: TDSearchStyle.round,
            readOnly: true,
            onInputClick: () => IMViews.showToast('搜索功能开发中'),
          ),
        ),
        Expanded(
          child: Obx(() {
            final items = logic.conversations;
            if (items.isEmpty) {
              return _buildEmpty(
                context,
                description: '还没有配置 AI 伙伴，点击右上角「API 设置」去创建吧。',
                actionText: '前往设置',
                onTap: AppNavigator.startApiSettings,
              );
            }
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Column(
                children: items
                    .map(
                      (conversation) => Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: TDCellGroup(
                          theme: TDCellGroupTheme.cardTheme,
                          bordered: false,
                          cells: [
                            TDCell(
                              titleWidget: Row(
                                children: [
                                  Container(
                                    width: 44.w,
                                    height: 44.w,
                                    decoration: BoxDecoration(
                                      color: conversation.character.avatarColor,
                                      borderRadius: BorderRadius.circular(12.w),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      conversation.character.name.characters.first,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700,
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
                                                conversation.character.name,
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: theme.fontGyColor1,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              _formatTime(conversation.preview.lastTime),
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                color: theme.fontGyColor3,
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
                                            fontSize: 12.sp,
                                            color: theme.fontGyColor2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              descriptionWidget: Padding(
                                padding: EdgeInsets.only(top: 12.h),
                                child: Wrap(
                                  spacing: 6.w,
                                  runSpacing: 6.h,
                                  children: [
                                    TDTag(
                                      conversation.endpoint.name,
                                      theme: TDTagTheme.primary,
                                      size: TDTagSize.small,
                                      isLight: true,
                                    ),
                                    if (conversation.persona != null)
                                      TDTag(
                                        'Persona',
                                        theme: TDTagTheme.success,
                                        size: TDTagSize.small,
                                        isLight: true,
                                      ),
                                    if (conversation.worldInfos.isNotEmpty)
                                      TDTag(
                                        '世界书 ${conversation.worldInfos.length}',
                                        theme: TDTagTheme.warning,
                                        size: TDTagSize.small,
                                        isLight: true,
                                      ),
                                  ],
                                ),
                              ),
                              bordered: false,
                              arrow: true,
                              onClick: (_) => _openConversation(conversation),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildContactsPage(BuildContext context) {
    final theme = TDTheme.of(context);
    return Column(
      children: [
        _buildNavBar(
          context,
          title: '通讯录',
          actions: [
            TDNavBarItem(
              icon: TDIcons.api,
              iconColor: Colors.white,
              action: AppNavigator.startApiSettings,
            ),
          ],
        ),
        Expanded(
          child: Obx(() {
            final characters = logic.service.characters;
            if (characters.isEmpty) {
              return _buildEmpty(
                context,
                description: '暂无联系人。创建 AI 角色后，这里将显示可对话的伙伴。',
                actionText: '新增 AI 角色',
                onTap: apiLogic.addOrEditCharacter,
              );
            }
            final selectedId = logic.service.selectedCharacterId.value;
            final persona = logic.service.persona.value;
            final worldCount = logic.service.worldInfos.length;
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (persona != null) _buildPersonaCard(theme, persona, worldCount),
                  TDButton(
                    size: TDButtonSize.large,
                    theme: TDButtonTheme.primary,
                    type: TDButtonType.fill,
                    text: '新增 AI 角色',
                    margin: EdgeInsets.only(top: persona == null ? 0 : 16.h, bottom: 12.h),
                    onTap: apiLogic.addOrEditCharacter,
                  ),
                  ...characters.map((character) {
                    final endpoint = logic.endpointForCharacter(character);
                    final isDefault = selectedId == character.id;
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: TDCellGroup(
                        theme: TDCellGroupTheme.cardTheme,
                        bordered: false,
                        cells: [
                          TDCell(
                            titleWidget: Row(
                              children: [
                                CircleAvatar(
                                  radius: 24.w,
                                  backgroundColor: character.avatarColor,
                                  child: Text(
                                    character.name.characters.first,
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w600,
                                                color: theme.fontGyColor1,
                                              ),
                                            ),
                                          ),
                                          if (isDefault)
                                            TDTag(
                                              '默认',
                                              theme: TDTagTheme.success,
                                              size: TDTagSize.small,
                                              isLight: true,
                                            ),
                                        ],
                                      ),
                                      4.verticalSpace,
                                      Text(
                                        endpoint == null
                                            ? '未绑定接口'
                                            : '${endpoint.name} · ${endpoint.model.isEmpty ? endpoint.baseUrl : endpoint.model}',
                                        style: TextStyle(fontSize: 12.sp, color: theme.fontGyColor3),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            descriptionWidget: character.persona.isEmpty
                                ? null
                                : Padding(
                                    padding: EdgeInsets.only(top: 12.h),
                                    child: Text(
                                      character.persona,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 12.sp, color: theme.fontGyColor2),
                                    ),
                                  ),
                            rightIconWidget: Icon(TDIcons.more, color: theme.fontGyColor3),
                            bordered: false,
                            onClick: (_) => _openCharacterConversation(character),
                            onLongPress: (_) => _showCharacterActions(character),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildPersonaCard(TDThemeData theme, UserPersona persona, int worldCount) {
    return TDCellGroup(
      theme: TDCellGroupTheme.cardTheme,
      bordered: false,
      cells: [
        TDCell(
          titleWidget: Row(
            children: [
              Icon(TDIcons.user_circle, color: theme.brandColor8, size: 28.w),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      persona.displayName,
                      style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: theme.fontGyColor1),
                    ),
                    if (persona.style.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: Text(
                          persona.style,
                          style: TextStyle(fontSize: 12.sp, color: theme.fontGyColor3),
                        ),
                      ),
                  ],
                ),
              ),
              TDButton(
                text: '配置',
                size: TDButtonSize.small,
                theme: TDButtonTheme.primary,
                type: TDButtonType.outline,
                onTap: () => apiLogic.handleSectionAction(1),
              ),
            ],
          ),
          descriptionWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (persona.description.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: Text(
                    persona.description,
                    style: TextStyle(fontSize: 12.sp, color: theme.fontGyColor2),
                  ),
                ),
              if (persona.goals.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Text(
                    '目标：${persona.goals}',
                    style: TextStyle(fontSize: 12.sp, color: theme.fontGyColor3),
                  ),
                ),
              if (worldCount > 0)
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: TDTag(
                    '世界信息 $worldCount',
                    theme: TDTagTheme.warning,
                    size: TDTagSize.small,
                    isLight: true,
                  ),
                ),
            ],
          ),
          bordered: false,
        ),
      ],
    );
  }

  Widget _buildDiscoverPage(BuildContext context) {
    return Column(
      children: [
        _buildNavBar(context, title: '发现'),
        Expanded(
          child: _buildEmpty(
            context,
            description: '探索更多玩法，未来将接入 SillyTavern 式扩展。',
          ),
        ),
      ],
    );
  }

  Widget _buildProfilePage(BuildContext context) {
    return Column(
      children: [
        _buildNavBar(context, title: '我'),
        Expanded(
          child: _buildEmpty(
            context,
            description: '个人中心正在开发中，敬请期待。',
          ),
        ),
      ],
    );
  }

  Widget _buildNavBar(BuildContext context,
      {required String title, List<TDNavBarItem>? actions}) {
    final theme = TDTheme.of(context);
    return TDNavBar(
      title: title,
      centerTitle: true,
      useDefaultBack: false,
      backgroundColor: const Color(0xFF07C160),
      titleColor: Colors.white,
      titleFontWeight: FontWeight.w600,
      height: 52,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      rightBarItems: actions,
      boxShadow: theme.shadowsTop,
    );
  }

  Widget _buildEmpty(
    BuildContext context, {
    required String description,
    String? actionText,
    VoidCallback? onTap,
  }) {
    final hasAction = actionText != null && onTap != null;
    return Center(
      child: TDEmpty(
        emptyText: description,
        type: hasAction ? TDEmptyType.operation : TDEmptyType.plain,
        operationText: hasAction ? actionText : null,
        onTapEvent: hasAction ? onTap : null,
        operationTheme: TDButtonTheme.primary,
      ),
    );
  }

  Future<void> _openConversation(WeChatConversation conversation) async {
    final result = await Get.to<ChatPreview>(
      () => WeChatChatPage(conversation: conversation),
    );
    if (result != null) {
      logic.updatePreview(conversation.character.id, result);
    }
  }

  void _openCharacterConversation(AiCharacter character) {
    final conv = logic.conversations.firstWhereOrNull(
      (element) => element.character.id == character.id,
    );
    if (conv != null) {
      _openConversation(conv);
    } else {
      IMViews.showToast('请先为该角色绑定接口');
    }
  }

  void _showCharacterActions(AiCharacter character) {
    final context = Get.context;
    if (context == null) return;
    final isDefault = logic.service.selectedCharacterId.value == character.id;
    final items = <TDActionSheetItem>[
      TDActionSheetItem(label: '发起聊天'),
      TDActionSheetItem(label: '查看提示组合'),
      TDActionSheetItem(label: '设为默认角色',
          textStyle: TextStyle(color: isDefault ? TDTheme.of(context).fontGyColor4 : TDTheme.of(context).brandColor8),
          disabled: isDefault),
      TDActionSheetItem(label: '编辑资料'),
      TDActionSheetItem(
        label: '删除角色',
        textStyle: TextStyle(color: TDTheme.of(context).errorColor6),
      ),
    ];

    TDActionSheet.showListActionSheet(
      context,
      items: items,
      onSelected: (item, index) {
        switch (index) {
          case 0:
            _openCharacterConversation(character);
            break;
          case 1:
            _showCharacterPromptPreview(character);
            break;
          case 2:
            if (!isDefault) {
              apiLogic.setDefaultCharacter(character.id);
            }
            break;
          case 3:
            apiLogic.addOrEditCharacter(character: character);
            break;
          case 4:
            apiLogic.removeCharacter(character);
            break;
        }
      },
    );
  }

  void _showCharacterPromptPreview(AiCharacter character) {
    final conv = logic.conversations.firstWhereOrNull(
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
              if (conv.persona != null) ...[
                Text(
                  'Persona · ${conv.persona!.displayName}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
                ),
                SizedBox(height: 6.h),
                if (conv.persona!.description.isNotEmpty)
                  Text(
                    conv.persona!.description,
                    style: TextStyle(fontSize: 12.sp, color: TDTheme.of(context).fontGyColor2),
                  ),
                if (conv.persona!.goals.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Text(
                      '目标：${conv.persona!.goals}',
                      style: TextStyle(fontSize: 12.sp, color: TDTheme.of(context).fontGyColor3),
                    ),
                  ),
                SizedBox(height: 12.h),
              ],
              Text(
                '角色设定',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
              ),
              SizedBox(height: 6.h),
              Text(
                character.persona.isEmpty ? '未填写' : character.persona,
                style: TextStyle(fontSize: 12.sp, color: TDTheme.of(context).fontGyColor2),
              ),
              SizedBox(height: 12.h),
              Text(
                '世界信息 (${conv.worldInfos.length})',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
              ),
              SizedBox(height: 6.h),
              if (conv.worldInfos.isEmpty)
                Text(
                  '暂无设定条目',
                  style: TextStyle(fontSize: 12.sp, color: TDTheme.of(context).fontGyColor3),
                )
              else
                ...conv.worldInfos.map(
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
                          style: TextStyle(fontSize: 12.sp, color: TDTheme.of(context).fontGyColor2),
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

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    if (now.year == time.year && now.month == time.month && now.day == time.day) {
      return DateFormat('HH:mm').format(time);
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
      final duration = Duration(milliseconds: distance < 120 ? 140 : 220);
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
    final theme = TDTheme.of(context);
    final contextBanner = _buildConversationContextBanner(theme);
    return Scaffold(
      backgroundColor: theme.grayColor1,
      body: Column(
        children: [
          TDNavBar(
            useDefaultBack: false,
            centerTitle: false,
            titleWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.character.name,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.endpoint.name,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
            backgroundColor: const Color(0xFF07C160),
            titleColor: Colors.white,
            boxShadow: theme.shadowsTop,
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            leftBarItems: [
              TDNavBarItem(
                icon: TDIcons.arrow_left,
                iconColor: Colors.white,
                action: _exit,
              ),
            ],
            rightBarItems: [
              TDNavBarItem(
                icon: TDIcons.info_circle,
                iconColor: Colors.white,
                action: _showEndpointInfo,
              ),
            ],
          ),
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
                      if (!isSelf) _buildAvatar(theme, isSelf: false),
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
                            boxShadow: isSelf ? null : theme.shadowsTop,
                          ),
                          child: Text(
                            message.text,
                            style: TextStyle(
                              color: isSelf ? Colors.white : theme.fontGyColor1,
                              fontSize: 15.sp,
                              height: 1.35,
                            ),
                          ),
                        ),
                      ),
                      if (isSelf) 8.horizontalSpace,
                      if (isSelf) _buildAvatar(theme, isSelf: true),
                    ],
                  ),
                );
              },
            ),
          ),
          _buildInputBar(theme),
        ],
      ),
    );
  }

  Widget _buildAvatar(TDThemeData theme, {required bool isSelf}) {
    return CircleAvatar(
      radius: 18.w,
      backgroundColor: isSelf ? theme.brandColor6 : widget.character.avatarColor,
      child: Text(
        isSelf ? '我' : widget.character.name.characters.first,
        style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget? _buildConversationContextBanner(TDThemeData theme) {
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
        boxShadow: theme.shadowsTop,
      ),
      child: Row(
        children: [
          Icon(TDIcons.info_circle_filled, color: theme.brandColor8),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '上下文已启用',
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: theme.fontGyColor1),
                ),
                SizedBox(height: 4.h),
                Text(
                  [
                    if (persona != null) 'Persona：${persona.displayName}',
                    if (lore.isNotEmpty) '世界信息：${lore.length} 条',
                  ].join(' · '),
                  style: TextStyle(fontSize: 12.sp, color: theme.fontGyColor3),
                ),
              ],
            ),
          ),
          TDButton(
            theme: TDButtonTheme.primary,
            type: TDButtonType.text,
            text: '详情',
            size: TDButtonSize.small,
            onTap: _showPromptContextSheet,
          ),
        ],
      ),
    );
  }

  Widget _buildInputBar(TDThemeData theme) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.mic_none), color: theme.fontGyColor3),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: theme.grayColor1,
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
            IconButton(onPressed: () {}, icon: const Icon(Icons.emoji_emotions_outlined), color: theme.fontGyColor3),
            IconButton(onPressed: _sendMessage, icon: const Icon(Icons.send), color: const Color(0xFF07C160)),
          ],
        ),
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
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                if (persona.description.isNotEmpty)
                  Text(
                    persona.description,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                if (persona.goals.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '目标：${persona.goals}',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                if (persona.style.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '风格：${persona.style}',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                const SizedBox(height: 12),
              ],
              Text(
                '世界信息 (${lore.length})',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              if (lore.isEmpty)
                Text(
                  '暂无设定条目',
                  style: TextStyle(color: Colors.grey.shade600),
                )
              else
                ...lore.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.title,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          entry.content,
                          style: TextStyle(color: Colors.grey.shade700),
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

  void _showEndpointInfo() {
    final generation = widget.generationConfig;
    Get.dialog(
      AlertDialog(
        title: Text(widget.endpoint.name),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('类型：${widget.endpoint.type == ApiProviderType.openai ? 'OpenAI 兼容' : 'Google Gemini'}'),
              const SizedBox(height: 8),
              Text('Base URL：${widget.endpoint.baseUrl}'),
              const SizedBox(height: 8),
              Text('默认模型：${widget.endpoint.model.isEmpty ? '未设置' : widget.endpoint.model}'),
              const SizedBox(height: 12),
              Text('生成参数', style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: [
                  _buildInfoChip('temperature', generation.temperature.toStringAsFixed(2)),
                  _buildInfoChip('top_p', generation.topP.toStringAsFixed(2)),
                  _buildInfoChip('top_k', generation.topK.toString()),
                  _buildInfoChip('max_tokens', generation.maxTokens.toString()),
                  _buildInfoChip('presence_penalty', generation.presencePenalty.toStringAsFixed(2)),
                  _buildInfoChip('frequency_penalty', generation.frequencyPenalty.toStringAsFixed(2)),
                  _buildInfoChip('stream', generation.stream ? 'ON' : 'OFF'),
                ],
              ),
              if (widget.endpoint.notes.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text('备注：${widget.endpoint.notes}'),
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

  Widget _buildInfoChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E5EA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text('$label = $value', style: const TextStyle(fontSize: 11, color: Color(0xFF3C3C43))),
    );
  }
}

class _ChatMessage {
  _ChatMessage({required this.text, required this.isSelf, required this.timestamp});

  final String text;
  final bool isSelf;
  final DateTime timestamp;
}
