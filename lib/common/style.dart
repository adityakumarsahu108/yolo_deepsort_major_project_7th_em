import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yolo_deepsort/common/color.dart';

class AppTextStyle {
  static final TextStyle primaryTextStyle = TextStyle(
    color: AppColor.primaryTextColor,
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle secondaryTextStyle = TextStyle(
    color: AppColor.primaryTextColor,
    fontSize: 14.sp,
    fontWeight: FontWeight.w800,
  );
  static final TextStyle secondaryBlackTextStyle = TextStyle(
    color: AppColor.secondaryTextColor,
    fontSize: 14.sp,
    fontWeight: FontWeight.w800,
  );
}
