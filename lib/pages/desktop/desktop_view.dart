import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../services/weather_visuals.dart';

import 'desktop_logic.dart';

class DesktopPage extends StatelessWidget {
  final logic = Get.find<DesktopLogic>();

  DesktopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'packages/openim_common/assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // 顶部状态栏占位空间
            SizedBox(height: MediaQuery.of(context).padding.top),

            // 桌面页面内容区域
            Expanded(
              child: GetBuilder<DesktopLogic>(
                id: DesktopLogic.appsUpdateId,
                builder: (_) {
                  return PageView.builder(
                    controller: logic.pageController,
                    itemCount: logic.getPageCount(),
                    physics: const BouncingScrollPhysics(), // 添加iOS风格的滑动物理效果
                    itemBuilder: (context, pageIndex) {
                      return _buildDesktopPage(pageIndex);
                    },
                  );
                },
              ),
            ),

            // 底部Dock栏 - Liquid Glass风格
            _buildDockBar(),

            // 底部安全区域占位
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopPage(int pageIndex) {
    return Column(
      children: [
        // 顶部天气小组件 - Liquid Glass风格
        _buildWeatherWidget(),

        // App列表区域
        Expanded(
          child: _buildAppGridForPage(pageIndex),
        ),
      ],
    );
  }

  Widget _buildWeatherWidget() {
    return Obx(() => GestureDetector(
        onTap: () => logic.onWeatherWidgetTap(),
        child: Container(
          margin: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 20.h),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: logic.getWeatherGradientColors(),
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 顶部行：城市名称和夜间模式切换
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.white.withOpacity(0.9),
                                size: 16.w,
                              ),
                              4.horizontalSpace,
                              Expanded(
                                child: Text(
                                  logic.getCurrentCityName(),
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 夜间模式切换按钮
                        GestureDetector(
                          onTap: logic.toggleDarkMode,
                          child: Container(
                            padding: EdgeInsets.all(6.w),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              logic.isDarkMode.value
                                  ? Icons.light_mode
                                  : Icons.dark_mode,
                              color: Colors.white.withOpacity(0.9),
                              size: 18.w,
                            ),
                          ),
                        ),
                      ],
                    ),

                    16.verticalSpace,

                    // 主要温度和天气图标
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 主要温度
                              Text(
                                logic.getCurrentTemperature(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 42.sp,
                                  fontWeight: FontWeight.w300,
                                  height: 1.0,
                                ),
                              ),
                              4.verticalSpace,
                              // 天气描述
                              Text(
                                logic.getCurrentWeatherDescription(),
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 天气图标
                        Container(
                          width: 60.w,
                          height: 60.w,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(
                            child: Image.asset(
                              logic.getWeatherIconPath(),
                              package: 'openim_common',
                              width: 40.w,
                              height: 40.w,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) {
                                return Image.asset(
                                  WeatherVisuals.iconAsset(null),
                                  package: 'openim_common',
                                  width: 40.w,
                                  height: 40.w,
                                  fit: BoxFit.contain,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    16.verticalSpace,

                    // 底部信息行：高低温度和详细信息
                    Row(
                      children: [
                        // 高低温度
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.keyboard_arrow_up,
                                color: Colors.white.withOpacity(0.8),
                                size: 16.w,
                              ),
                              Text(
                                logic.getHighTemperature(),
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              8.horizontalSpace,
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white.withOpacity(0.8),
                                size: 16.w,
                              ),
                              Text(
                                logic.getLowTemperature(),
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 体感温度
                        Text(
                          '体感 ${logic.getFeelsLikeTemperature()}°',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),

                    8.verticalSpace,

                    // 底部标签
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          '点击查看详情',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )));
  }

  Widget _buildAppGridForPage(int pageIndex) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(), // 禁用GridView的滚动
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 16.h,
          childAspectRatio: 0.9,
        ),
        itemCount: logic.getAppsForPage(pageIndex).length,
        itemBuilder: (context, index) {
          final app = logic.getAppsForPage(pageIndex)[index];
          if (app == null) {
            return _buildEmptySlot(pageIndex, index);
          }
          return _buildDraggableAppItem(app, pageIndex, index);
        },
      ),
    );
  }

  Widget _buildEmptySlot(int pageIndex, int index) {
    return DragTarget<AppItem>(
      onWillAccept: (data) {
        print('空位 $pageIndex-$index 准备接受: ${data?.name}');
        return data != null;
      },
      onAccept: (data) {
        print('空位 $pageIndex-$index 接受: ${data.name}');
        // 处理拖拽到空位
        logic.moveAppToPosition(data, pageIndex, index);
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: 60.w,
          height: 60.w,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(18.r),
          ),
        );
      },
    );
  }

  Widget _buildDraggableAppItem(AppItem app, int pageIndex, int index) {
    return LongPressDraggable<AppItem>(
      data: app,
      dragAnchorStrategy: (draggable, context, position) => Offset(30.w, 30.w),
      hapticFeedbackOnStart: true, // 长按震动反馈
      feedback: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(18.r),
        child: Container(
          width: 60.w,
          height: 60.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: _buildAppIconBody(app, 60.w),
        ),
      ),
      childWhenDragging: Container(
        width: 60.w,
        height: 60.w,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(18.r),
        ),
      ),
      child: GestureDetector(
        onTap: () => logic.onAppTap(app),
        child: DragTarget<AppItem>(
          onWillAccept: (data) {
            print('App位置 $pageIndex-$index 准备接受: ${data?.name}');
            return data != null && data != app; // 不能拖拽到自己身上
          },
          onAccept: (data) {
            print('App位置 $pageIndex-$index 接受: ${data.name}');
            // 处理拖拽到其他位置
            logic.moveAppToPosition(data, pageIndex, index);
          },
          builder: (context, candidateData, rejectedData) {
            return _buildAppItem(app);
          },
        ),
      ),
    );
  }

  Widget _buildAppItem(AppItem app) {
    return GestureDetector(
      onTap: () => logic.onAppTap(app),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: _buildAppIconBody(app, 60.w),
          ),
          8.verticalSpace,
          Text(
            app.name,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildAppIconBody(AppItem app, double dimension) {
    final borderRadius = BorderRadius.circular(18.r);
    final image = _resolveAppImage(app, dimension);
    if (image != null) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: image,
      );
    }
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            app.color,
            app.color.withOpacity(0.8),
          ],
        ),
        borderRadius: borderRadius,
      ),
      child: Icon(
        app.icon ?? Icons.apps,
        color: Colors.white,
        size: dimension * 0.5,
      ),
    );
  }

  Widget? _resolveAppImage(AppItem app, double dimension) {
    final localPath = app.localIconPath;
    if (localPath != null && localPath.isNotEmpty) {
      final file = File(localPath);
      if (file.existsSync()) {
        return Image.file(
          file,
          width: dimension,
          height: dimension,
          fit: BoxFit.cover,
        );
      }
    }

    final assetPath = app.assetIconPath;
    if (assetPath != null && assetPath.isNotEmpty) {
      return Image.asset(
        assetPath,
        width: dimension,
        height: dimension,
        fit: BoxFit.cover,
      );
    }

    return null;
  }

  Widget _buildDockBar() {
    return Container(
      margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 10.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.25),
                  Colors.white.withOpacity(0.15),
                ],
              ),
              borderRadius: BorderRadius.circular(28.r),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: logic.dockApps.map((app) {
                return GestureDetector(
                  onTap: () => logic.onAppTap(app),
                  child: Container(
                    width: 60.w,
                    height: 60.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: _buildAppIconBody(app, 60.w),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
