import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yolo_deepsort/common/style.dart';

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 325.h),
          SizedBox(height: 30.h),
          Text(
            title,
            style: AppTextStyle.primaryTextStyle
                .copyWith(color: Colors.white, fontSize: 24.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          Text(
            description,
            style: AppTextStyle.secondaryBlackTextStyle
                .copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
