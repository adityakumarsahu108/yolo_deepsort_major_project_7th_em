import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yolo_deepsort/bloc/media_bloc.dart';
import 'package:yolo_deepsort/bloc/media_event.dart';
import 'package:yolo_deepsort/bloc/media_state.dart';
import 'package:yolo_deepsort/common/button.dart';
import 'package:yolo_deepsort/common/color.dart';
import 'package:yolo_deepsort/common/style.dart';
import 'package:yolo_deepsort/widgets/container.dart';
import 'package:yolo_deepsort/widgets/info_drawer.dart';
import 'package:yolo_deepsort/widgets/info_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void goInfoPage(BuildContext context, String info) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => InfoPage(info: info)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mini Project',
          style: AppTextStyle.primaryTextStyle
              .copyWith(color: Colors.white, fontSize: 25.sp),
        ),
        centerTitle: true,
      ),
      endDrawer: Drawer(
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
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Text(
                'Choose',
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
            commonButton(text: 'Process', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
