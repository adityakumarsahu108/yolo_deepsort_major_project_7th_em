import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yolo_deepsort/common/button.dart';
import 'package:yolo_deepsort/common/style.dart';

class PopUp extends StatelessWidget {
  const PopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(
        'Choose YOLO Version',
        style:
            AppTextStyle.secondaryBlackTextStyle.copyWith(color: Colors.white),
      ),
      content: Text(
        'Please select one of the YOLO versions:',
        style:
            AppTextStyle.secondaryBlackTextStyle.copyWith(color: Colors.white),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            commonButton(
                text: 'YOLO v5',
                onPressed: () {
                  Navigator.pop(context);
                }),
            SizedBox(
              width: 10.w,
            ),
            commonButton(
                text: 'YOLO v8',
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        )
      ],
    );
  }
}
