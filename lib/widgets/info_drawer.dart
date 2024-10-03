import 'package:flutter/material.dart';
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
        Text(text,
            style: AppTextStyle.secondaryBlackTextStyle
                .copyWith(color: Colors.white))
      ],
    );
  }
}
