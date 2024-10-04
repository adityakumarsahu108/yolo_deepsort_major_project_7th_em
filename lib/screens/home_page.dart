import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yolo_deepsort/bloc/media_bloc.dart';
import 'package:yolo_deepsort/bloc/media_event.dart';
import 'package:yolo_deepsort/bloc/media_state.dart';
import 'package:yolo_deepsort/common/button.dart';
import 'package:yolo_deepsort/common/color.dart';
import 'package:yolo_deepsort/common/end_drawer.dart';
import 'package:yolo_deepsort/common/start_drawer.dart';
import 'package:yolo_deepsort/common/style.dart';
import 'package:yolo_deepsort/widgets/container.dart';
import 'package:yolo_deepsort/widgets/pop_up.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Major Project',
          style: AppTextStyle.primaryTextStyle
              .copyWith(color: Colors.white, fontSize: 25.sp),
        ),
        centerTitle: true,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.info_outline_rounded,
              ));
        }),
      ),
      drawer: const StartDrawer(),
      endDrawer: const EndDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Text(
                'Choose Input Type',
                style: AppTextStyle.secondaryBlackTextStyle.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            BlocBuilder<MediaPickerBloc, MediaPickState>(
              builder: (context, state) {
                bool isImageMode = true;

                if (state is MediaPickerModeChanged) {
                  isImageMode = state.isImageMode;
                }

                return ToggleButtons(
                  isSelected: [isImageMode, !isImageMode],
                  onPressed: (int index) {
                    context.read<MediaPickerBloc>().add(ToggleMediaModeEvent());
                  },
                  fillColor: AppColor.primaryTextColor,
                  borderRadius: BorderRadius.circular(8.0),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                      child: Text(
                        'Image',
                        style: AppTextStyle.secondaryBlackTextStyle
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                      child: Text(
                        'Video',
                        style: AppTextStyle.secondaryBlackTextStyle
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              onTap: () {
                final currentState = context.read<MediaPickerBloc>().state;
                if (currentState is MediaPickerModeChanged) {
                  final isImageMode = currentState.isImageMode;
                  if (isImageMode) {
                    context.read<MediaPickerBloc>().add(PickImageEvent());
                  } else {
                    context.read<MediaPickerBloc>().add(PickVideoEvent());
                  }
                }
              },
              child: const UploadContainer(),
            ),
            SizedBox(
              height: 15.h,
            ),
            commonButton(
                text: 'Process',
                onPressed: () => _showYoloSelectionDialog(context)),
          ],
        ),
      ),
    );
  }
}

void _showYoloSelectionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const PopUp();
    },
  );
}
