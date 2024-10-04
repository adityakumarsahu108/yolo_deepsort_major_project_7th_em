// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yolo_deepsort/common/color.dart';
import 'package:yolo_deepsort/common/style.dart';
import 'package:yolo_deepsort/widgets/info_drawer.dart';
import 'package:yolo_deepsort/widgets/info_page.dart';

class EndDrawer extends StatelessWidget {
  const EndDrawer({super.key});

  void goInfoPage(BuildContext context, String info) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => InfoPage(info: info)));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 2,
      backgroundColor: AppColor.primaryRegularColor,
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                'Project Information',
                style: AppTextStyle.primaryTextStyle
                    .copyWith(color: Colors.white, fontSize: 22.sp),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Find out More on :',
                  style: AppTextStyle.secondaryTextStyle.copyWith(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 15.h),
                GestureDetector(
                  onTap: () => goInfoPage(context, 'YOLO'),
                  child: const InforDrawer(
                      text: 'YOLO', icon: Icons.info_outline_rounded),
                ),
                SizedBox(height: 15.h),
                GestureDetector(
                  onTap: () => goInfoPage(context, 'DeepSort'),
                  child: const InforDrawer(
                      text: 'DeepSort', icon: Icons.info_outline_rounded),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
