import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../services/api_settings_service.dart';
import 'api_settings_logic.dart';

class ApiSettingsPage extends StatefulWidget {
  const ApiSettingsPage({super.key});

  @override
  State<ApiSettingsPage> createState() => _ApiSettingsPageState();
}

class _ApiSettingsPageState extends State<ApiSettingsPage> with SingleTickerProviderStateMixin {
  late final ApiSettingsLogic controller;
  late final ApiSettingsService service;
  late final TabController _tabController;
  late final Worker _sectionWorker;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ApiSettingsLogic>();
    service = controller.service;
    _tabController = TabController(length: 3, vsync: this, initialIndex: controller.selectedSection.value);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      controller.switchSection(_tabController.index);
    });
    _sectionWorker = ever<int>(controller.selectedSection, (index) {
      if (_tabController.index != index) {
        _tabController.animateTo(index);
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _sectionWorker.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = TDTheme.of(context);
    return Scaffold(
      backgroundColor: theme.grayColor1,
      body: SafeArea(
        child: Column(
          children: [
            TDNavBar(
              title: 'API 设置',
              centerTitle: true,
              leftBarItems: [
                TDNavBarItem(
                  icon: TDIcons.arrow_left,
                  iconColor: theme.fontGyColor1,
                  action: () => Get.back(),
                ),
              ],
              rightBarItems: [
                TDNavBarItem(
                  icon: TDIcons.add,
                  iconColor: theme.brandColor8,
                  action: () => controller.handleSectionAction(controller.selectedSection.value),
                ),
              ],
              useDefaultBack: false,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              height: 60,
              boxShadow: theme.shadowsTop,
              backgroundColor: theme.whiteColor1,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
              child: TDTabBar(
                controller: _tabController,
                outlineType: TDTabBarOutlineType.capsule,
                backgroundColor: theme.grayColor1,
                selectedBgColor: theme.brandColor1,
                unSelectedBgColor: theme.grayColor1,
                showIndicator: false,
                labelColor: theme.brandColor8,
                unselectedLabelColor: theme.fontGyColor2,
                labelPadding: EdgeInsets.symmetric(horizontal: 12.w),
                height: 44,
                tabs: const [
                  TDTab(icon: Icon(TDIcons.api, size: 20), text: '接口'),
                  TDTab(icon: Icon(TDIcons.user_1, size: 20), text: '个性'),
                  TDTab(icon: Icon(TDIcons.book, size: 20), text: '世界信息'),
                ],
                onTap: (index) => controller.switchSection(index),
              ),
            ),
            Expanded(
              child: Obx(() {
                switch (controller.selectedSection.value) {
                  case 0:
                    return _buildEndpointSection(context);
                  case 1:
                    return _buildPersonaSection(context);
                  default:
                    return _buildWorldInfoSection(context);
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEndpointSection(BuildContext context) {
    final theme = TDTheme.of(context);
    return Obx(() {
      final endpoints = service.endpoints;
      final selectedId = service.selectedEndpointId.value;
      if (endpoints.isEmpty) {
        return _buildEmpty(
          context,
          icon: TDIcons.api,
          description: '尚未配置接口，立即创建一个 OpenAI 或 Gemini 网关吧。',
          actionLabel: '新增接口',
          onAction: controller.addOrEditEndpoint,
        );
      }
      return ListView(
        padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
        children: endpoints.map((endpoint) {
          final isSelected = selectedId == endpoint.id;
          final generation = endpoint.generationConfig;
          final chips = [
            _buildInfoChip('Temp', generation.temperature.toStringAsFixed(2)),
            _buildInfoChip('TopP', generation.topP.toStringAsFixed(2)),
            _buildInfoChip('TopK', '${generation.topK}'),
            _buildInfoChip('Max', '${generation.maxTokens}'),
            _buildInfoChip('Stream', generation.stream ? 'ON' : 'OFF'),
          ];
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: TDCellGroup(
              theme: TDCellGroupTheme.cardTheme,
              bordered: false,
              cells: [
                TDCell(
                  bordered: false,
                  titleWidget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              endpoint.name,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: theme.fontGyColor1,
                              ),
                            ),
                          ),
                          if (isSelected)
                            TDTag(
                              '当前使用',
                              theme: TDTagTheme.success,
                              size: TDTagSize.small,
                              isLight: true,
                            ),
                        ],
                      ),
                      6.verticalSpace,
                      Wrap(
                        spacing: 6.w,
                        runSpacing: 6.h,
                        children: [
                          TDTag(
                            endpoint.type == ApiProviderType.openai ? 'OpenAI 兼容' : 'Google Gemini',
                            theme: TDTagTheme.primary,
                            size: TDTagSize.small,
                            isLight: true,
                          ),
                          TDTag(
                            endpoint.model.isEmpty ? '未指定模型' : endpoint.model,
                            theme: TDTagTheme.defaultTheme,
                            size: TDTagSize.small,
                            isLight: true,
                          ),
                          ...endpoint.enabledFunctions
                              .map<Widget>(
                                (feature) => TDTag(
                                  feature.toUpperCase(),
                                  theme: TDTagTheme.defaultTheme,
                                  size: TDTagSize.small,
                                  isLight: true,
                                ),
                              )
                              .toList(),
                        ],
                      ),
                    ],
                  ),
                  descriptionWidget: Padding(
                    padding: EdgeInsets.only(top: 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          endpoint.baseUrl,
                          style: TextStyle(fontSize: 12.sp, color: theme.fontGyColor3),
                        ),
                        SizedBox(height: 10.h),
                        Wrap(
                          spacing: 6.w,
                          runSpacing: 6.h,
                          children: chips,
                        ),
                        if (endpoint.notes.isNotEmpty) ...[
                          SizedBox(height: 10.h),
                          Text(
                            endpoint.notes,
                            style: TextStyle(fontSize: 12.sp, color: theme.fontGyColor2),
                          ),
                        ],
                      ],
                    ),
                  ),
                  arrow: true,
                  onClick: (_) => _showEndpointActions(context, endpoint, isSelected),
                ),
              ],
            ),
          );
        }).toList(),
      );
    });
  }

  Widget _buildPersonaSection(BuildContext context) {
    final theme = TDTheme.of(context);
    return Obx(() {
      final persona = service.persona.value;
      final defaultCharacter = service.selectedCharacter;
      final worldCount = service.worldInfos.length;
      if (persona == null) {
        return _buildEmpty(
          context,
          icon: TDIcons.user_circle,
          description: '还没有配置用户个性。设置语气、目标、说话风格，让 AI 更懂你。',
          actionLabel: '创建 Persona',
          onAction: controller.editPersona,
        );
      }
      return ListView(
        padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
        children: [
          TDCellGroup(
            theme: TDCellGroupTheme.cardTheme,
            bordered: false,
            cells: [
              TDCell(
                bordered: false,
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
                            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: theme.fontGyColor1),
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
                      text: '管理',
                      size: TDButtonSize.small,
                      theme: TDButtonTheme.primary,
                      type: TDButtonType.outline,
                      onTap: () => controller.handleSectionAction(1),
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
              ),
            ],
          ),
          if (defaultCharacter != null) ...[
            SizedBox(height: 16.h),
            Text(
              '默认 AI 角色',
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: theme.fontGyColor3),
            ),
            SizedBox(height: 8.h),
            TDCellGroup(
              theme: TDCellGroupTheme.cardTheme,
              bordered: false,
              cells: [
                TDCell(
                  bordered: false,
                  titleWidget: Row(
                    children: [
                      CircleAvatar(
                        radius: 24.w,
                        backgroundColor: defaultCharacter.avatarColor,
                        child: Text(
                          defaultCharacter.name.characters.first,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      12.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              defaultCharacter.name,
                              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: theme.fontGyColor1),
                            ),
                            4.verticalSpace,
                            Text(
                              service.ensureEndpointForCharacter(defaultCharacter).name,
                              style: TextStyle(fontSize: 12.sp, color: theme.fontGyColor3),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  descriptionWidget: defaultCharacter.persona.isEmpty
                      ? null
                      : Padding(
                          padding: EdgeInsets.only(top: 12.h),
                          child: Text(
                            defaultCharacter.persona,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12.sp, color: theme.fontGyColor2),
                          ),
                        ),
                  onClick: (_) => controller.addOrEditCharacter(character: defaultCharacter),
                ),
              ],
            ),
          ],
        ],
      );
    });
  }

  Widget _buildWorldInfoSection(BuildContext context) {
    final theme = TDTheme.of(context);
    return Obx(() {
      final entries = service.worldInfos;
      if (entries.isEmpty) {
        return _buildEmpty(
          context,
          icon: TDIcons.book,
          description: '世界书为空。导入 SillyTavern Lorebook，或手动新增设定片段。',
          actionLabel: '新增世界信息',
          onAction: controller.addOrEditWorldInfo,
        );
      }
      return ReorderableListView.builder(
        padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
        itemCount: entries.length,
        onReorder: (oldIndex, newIndex) => controller.service.reorderWorldInfos(oldIndex, newIndex),
        itemBuilder: (context, index) {
          final entry = entries[index];
          return Padding(
            key: ValueKey(entry.id),
            padding: EdgeInsets.only(bottom: 12.h),
            child: TDCellGroup(
              theme: TDCellGroupTheme.cardTheme,
              bordered: false,
              cells: [
                TDCell(
                  bordered: false,
                  titleWidget: Row(
                    children: [
                      Expanded(
                        child: Text(
                          entry.title,
                          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: theme.fontGyColor1),
                        ),
                      ),
                      TDSwitch(
                        isOn: entry.enabled,
                        onChanged: (value) {
                          controller.toggleWorldInfo(entry, value);
                          return true;
                        },
                      ),
                      8.horizontalSpace,
                      GestureDetector(
                        onTap: () => controller.addOrEditWorldInfo(entry: entry),
                        child: Icon(TDIcons.edit_1, size: 20.w, color: theme.fontGyColor2),
                      ),
                      12.horizontalSpace,
                      GestureDetector(
                        onTap: () => controller.removeWorldInfo(entry),
                        child: Icon(TDIcons.delete, size: 20.w, color: theme.errorColor6),
                      ),
                      12.horizontalSpace,
                      Icon(TDIcons.move, size: 20.w, color: theme.fontGyColor3),
                    ],
                  ),
                  descriptionWidget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (entry.keywords.isNotEmpty)
                        Wrap(
                          spacing: 6.w,
                          runSpacing: 6.h,
                          children: entry.keywords
                              .map<Widget>(
                                (keyword) => TDTag(
                                  '#$keyword',
                                  theme: TDTagTheme.defaultTheme,
                                  size: TDTagSize.small,
                                  isLight: true,
                                ),
                              )
                              .toList(),
                        ),
                      SizedBox(height: 8.h),
                      Text(
                        entry.content,
                        style: TextStyle(fontSize: 12.sp, color: theme.fontGyColor2),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '优先级：${entry.priority}',
                        style: TextStyle(fontSize: 11.sp, color: theme.fontGyColor3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  Widget _buildEmpty(
    BuildContext context, {
    required IconData icon,
    required String description,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    return Center(
      child: TDEmpty(
        image: Icon(icon, size: 72.w, color: TDTheme.of(context).fontGyColor3),
        emptyText: description,
        type: actionLabel != null && onAction != null ? TDEmptyType.operation : TDEmptyType.plain,
        operationText: actionLabel,
        onTapEvent: onAction,
        operationTheme: TDButtonTheme.primary,
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
      child: Text(
        '$label = $value',
        style: const TextStyle(fontSize: 11, color: Color(0xFF3C3C43)),
      ),
    );
  }

  void _showEndpointActions(BuildContext context, ApiEndpoint endpoint, bool isSelected) {
    final items = <TDActionSheetItem>[
      if (!isSelected) TDActionSheetItem(label: '设为当前接口'),
      TDActionSheetItem(label: '编辑'),
      TDActionSheetItem(label: '生成参数'),
      TDActionSheetItem(label: '功能开关'),
      TDActionSheetItem(
        label: '删除接口',
        textStyle: TextStyle(color: TDTheme.of(context).errorColor6),
      ),
    ];
    TDActionSheet.showListActionSheet(
      context,
      items: items,
      onSelected: (item, index) {
        var offset = 0;
        if (!isSelected) {
          if (index == 0) {
            controller.setDefaultEndpoint(endpoint.id);
            return;
          }
        } else {
          offset = 1;
        }
        switch (index - offset) {
          case 0:
            controller.addOrEditEndpoint(endpoint: endpoint);
            break;
          case 1:
            controller.editGenerationConfig(endpoint);
            break;
          case 2:
            controller.editEnabledFunctions(endpoint);
            break;
          case 3:
            controller.removeEndpoint(endpoint);
            break;
        }
      },
    );
  }
}
