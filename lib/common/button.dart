import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yolo_deepsort/common/color.dart';
import 'package:yolo_deepsort/common/style.dart';

Widget commonButton({
  required String text,
  required VoidCallback onPressed,
  double width = 110.0,
  double height = 45.0,
}) {
  return SizedBox(
    width: width.w,
    height: height.h,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryRegularColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0.sp),
        ),
      ),
      child: Text(
        text,
        style: AppTextStyle.secondaryBlackTextStyle
            .copyWith(color: Colors.white, fontSize: 15.sp),
      ),
    ),
  );
}
