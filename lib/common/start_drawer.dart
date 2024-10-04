import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yolo_deepsort/common/color.dart';
import 'package:yolo_deepsort/common/style.dart';

class StartDrawer extends StatelessWidget {
  const StartDrawer({super.key});

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
                'Step By Step Guide',
                style: AppTextStyle.primaryTextStyle
                    .copyWith(color: Colors.white, fontSize: 22.sp),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                text('Choose Image or Video Input type', 1),
                text('Upload Image or Video in the Container', 2),
                text('Click on the Process Button', 3),
                text('Choose Yolo version', 4),
                text('Play the Processed Video/Image or Upload a new One', 5),
              ],
            ),
          )
        ],
      ),
    );
  }
}

text(String input, int number) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10.h),
    child: Row(
      children: [
        SizedBox(
          width: 20.w,
          child: Text(
            '$number',
            style: AppTextStyle.secondaryTextStyle.copyWith(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          width: 5.w,
        ),
        Expanded(
          child: Text(
            input,
            style: AppTextStyle.secondaryTextStyle.copyWith(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500),
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ],
    ),
  );
}
