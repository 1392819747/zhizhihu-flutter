import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';

import 'desktop_logic.dart';

class DesktopPage extends StatelessWidget {
  final logic = Get.find<DesktopLogic>();

  DesktopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // 顶部天气小组件
            _buildWeatherWidget(),
            
            // App列表区域
            Expanded(
              child: _buildAppGrid(),
            ),
            
            // 底部Dock栏
            _buildDockBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherWidget() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // 天气图标
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Icon(
              Icons.wb_sunny,
              color: Colors.white,
              size: 30.w,
            ),
          ),
          
          16.horizontalSpace,
          
          // 天气信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '北京',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                4.verticalSpace,
                Text(
                  '晴 25°C',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14.sp,
                  ),
                ),
                4.verticalSpace,
                Text(
                  '2024年10月16日 周三',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          
          // 温度
          Text(
            '25°',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppGrid() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
          childAspectRatio: 0.8,
        ),
        itemCount: logic.appList.length,
        itemBuilder: (context, index) {
          final app = logic.appList[index];
          return _buildAppItem(app);
        },
      ),
    );
  }

  Widget _buildAppItem(AppItem app) {
    return GestureDetector(
      onTap: () => logic.onAppTap(app),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                color: app.color,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                app.icon,
                color: Colors.white,
                size: 24.w,
              ),
            ),
            8.verticalSpace,
            Text(
              app.name,
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF333333),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDockBar() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: logic.dockApps.map((app) {
          return GestureDetector(
            onTap: () => logic.onAppTap(app),
            child: Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                color: app.color,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                app.icon,
                color: Colors.white,
                size: 24.w,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
