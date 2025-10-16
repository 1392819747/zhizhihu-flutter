import 'package:flutter/material.dart';
import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';

import '../../routes/app_navigator.dart';
import 'chat_logic.dart';

class ChatPage extends StatelessWidget {
  final logic = Get.find<ChatLogic>(tag: GetTags.chat);

  ChatPage({super.key});

  Widget _buildItemView(Message message) => ChatItemView(
        key: logic.itemKey(message),
        message: message,
        textScaleFactor: logic.scaleFactor.value,
        allAtMap: logic.getAtMapping(message),
        timelineStr: logic.getShowTime(message),
        sendStatusSubject: logic.sendStatusSub,
        leftNickname: logic.getNewestNickname(message),
        leftFaceUrl: logic.getNewestFaceURL(message),
        rightNickname: logic.senderName,
        rightFaceUrl: OpenIM.iMManager.userInfo.faceURL,
        showLeftNickname: !logic.isSingleChat,
        showRightNickname: !logic.isSingleChat,
        onFailedToResend: () => logic.failedResend(message),
        onRevokeMessage: (msg) => logic.revokeMessage(msg),
        onClickItemView: () => logic.parseClickEvent(message),
        visibilityChange: (msg, visible) {
          logic.markMessageAsRead(message, visible);
        },
        onLongPressRightAvatar: () {},
        onTapLeftAvatar: () {
          logic.onTapLeftAvatar(message);
        },
        onVisibleTrulyText: (text) {
          logic.copyTextMap[message.clientMsgID] = text;
        },
        customTypeBuilder: _buildCustomTypeItemView,
        patterns: <MatchPattern>[
          MatchPattern(
            type: PatternType.email,
            onTap: logic.clickLinkText,
          ),
          MatchPattern(
            type: PatternType.url,
            onTap: logic.clickLinkText,
          ),
          MatchPattern(
            type: PatternType.mobile,
            onTap: logic.clickLinkText,
          ),
          MatchPattern(
            type: PatternType.tel,
            onTap: logic.clickLinkText,
          ),
        ],
        mediaItemBuilder: (context, message) {
          return _buildMediaItem(context, message);
        },
        onTapUserProfile: handleUserProfileTap,
      );

  void handleUserProfileTap(({String userID, String name, String? faceURL, String? groupID}) userProfile) {
    final userInfo = UserInfo(userID: userProfile.userID, nickname: userProfile.name, faceURL: userProfile.faceURL);
    logic.viewUserInfo(userInfo);
  }

  Widget? _buildMediaItem(BuildContext context, Message message) {
    if (message.contentType != MessageType.picture && message.contentType != MessageType.video) {
      return null;
    }

    return GestureDetector(
      onTap: () async {
        try {
          IMUtils.previewMediaFile(
              context: context,
              message: message,
              onAutoPlay: (index) {
                return !logic.playOnce;
              },
              muted: logic.rtcIsBusy,
              onPageChanged: (index) {
                logic.playOnce = true;
              }).then((value) {
            logic.playOnce = false;
          });
        } catch (e) {
          IMViews.showToast(e.toString());
        }
      },
      child: Hero(
        tag: message.clientMsgID!,
        child: _buildMediaContent(message),
        placeholderBuilder: (BuildContext context, Size heroSize, Widget child) => child,
      ),
    );
  }

  Widget _buildMediaContent(Message message) {
    final isOutgoing = message.sendID == OpenIM.iMManager.userID;

    if (message.isVideoType) {
      return const SizedBox();
    } else {
      return ChatPictureView(
        isISend: isOutgoing,
        message: message,
      );
    }
  }

  CustomTypeInfo? _buildCustomTypeItemView(_, Message message) {
    final data = IMUtils.parseCustomMessage(message);
    if (null != data) {
      final viewType = data['viewType'];
      if (viewType == CustomMessageType.call) {
        final type = data['type'];
        final content = data['content'];
        final view = ChatCallItemView(type: type, content: content);
        return CustomTypeInfo(view);
      } else if (viewType == CustomMessageType.deletedByFriend || viewType == CustomMessageType.blockedByFriend) {
        final view = ChatFriendRelationshipAbnormalHintView(
          name: logic.nickname.value,
          onTap: logic.sendFriendVerification,
          blockedByFriend: viewType == CustomMessageType.blockedByFriend,
          deletedByFriend: viewType == CustomMessageType.deletedByFriend,
        );
        return CustomTypeInfo(view, false, false);
      } else if (viewType == CustomMessageType.removedFromGroup) {
        return CustomTypeInfo(
          StrRes.removedFromGroupHint.toText..style = Styles.ts_8E9AB0_12sp,
          false,
          false,
        );
      } else if (viewType == CustomMessageType.groupDisbanded) {
        return CustomTypeInfo(
          StrRes.groupDisbanded.toText..style = Styles.ts_8E9AB0_12sp,
          false,
          false,
        );
      }
    }
    return null;
  }

  Widget? get _groupCallHintView => null;

  PreferredSizeWidget _buildCustomAppBar() {
    return AppBar(
      backgroundColor: Styles.c_FFFFFF,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          padding: EdgeInsets.all(10.w),
          child: ImageRes.backBlack.toImage
            ..width = 24.w
            ..height = 24.h,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 5,
            child: Text(
              logic.nickname.value,
              style: Styles.ts_0C1C33_17sp_semibold,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          if (logic.memberStr.isNotEmpty)
            Flexible(
              flex: 2,
              child: Text(
                logic.memberStr,
                style: Styles.ts_0C1C33_17sp_semibold,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          // 回到桌面按钮
          GestureDetector(
            onTap: () => AppNavigator.startDesktop(),
            child: Container(
              margin: EdgeInsets.only(left: 8.w),
              padding: EdgeInsets.all(4.w),
              child: Icon(
                Icons.home_outlined,
                size: 20.w,
                color: Styles.c_0C1C33,
              ),
            ),
          ),
        ],
      ),
      actions: [
        if (!logic.isGroupChat)
          GestureDetector(
            onTap: logic.call,
            child: Container(
              padding: EdgeInsets.all(10.w),
              child: ImageRes.callBack.toImage
                ..width = 28.w
                ..height = 28.h,
            ),
          ),
        SizedBox(width: 8.w),
        GestureDetector(
          onTap: logic.chatSetup,
          child: Container(
            padding: EdgeInsets.all(10.w),
            child: ImageRes.moreBlack.toImage
              ..width = 28.w
              ..height = 28.h,
          ),
        ),
        SizedBox(width: 16.w),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: logic.willPop(),
      child: Obx(() {
        return Scaffold(
            backgroundColor: Styles.c_F0F2F6,
            appBar: _buildCustomAppBar(),
            body: GestureDetector(
              onPanEnd: (details) {
                // 检测从右向左的滑动手势
                if (details.velocity.pixelsPerSecond.dx < -500) {
                  AppNavigator.startDesktop();
                }
              },
              child: SafeArea(
                child: WaterMarkBgView(
                  text: '',
                  path: logic.background.value,
                  backgroundColor: Styles.c_FFFFFF,
                  floatView: _groupCallHintView,
                  bottomView: ChatInputBox(
                    forceCloseToolboxSub: logic.forceCloseToolbox,
                    controller: logic.inputCtrl,
                    focusNode: logic.focusNode,
                    isNotInGroup: logic.isInvalidGroup,
                    directionalText: logic.directionalText(),
                    onCloseDirectional: logic.onClearDirectional,
                    onSend: (v) => logic.sendTextMsg(),
                    toolbox: ChatToolBox(
                      onTapAlbum: logic.onTapAlbum,
                      onTapCall: logic.isGroupChat ? null : logic.call,
                    ),
                    voiceRecordBar: const SizedBox(),
                  ),
                  child: ChatListView(
                    onTouch: () => logic.closeToolbox(),
                    itemCount: logic.messageList.length,
                    controller: logic.scrollController,
                    onScrollToBottomLoad: logic.onScrollToBottomLoad,
                    onScrollToTop: logic.onScrollToTop,
                    itemBuilder: (_, index) {
                      final message = logic.indexOfMessage(index);
                      return Obx(() => _buildItemView(message));
                    },
                  ),
                ),
              ),
            ));
      }),
    );
  }
}
