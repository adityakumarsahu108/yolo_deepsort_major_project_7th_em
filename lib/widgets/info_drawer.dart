import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yolo_deepsort/common/style.dart';

class InforDrawer extends StatelessWidget {
  final String text;
  final IconData? icon;
  const InforDrawer({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(
          width: 5.w,
        ),
        Text(text,
            style: AppTextStyle.secondaryBlackTextStyle
                .copyWith(color: Colors.white))
      ],
    );
  }
}
