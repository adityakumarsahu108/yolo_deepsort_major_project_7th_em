import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:yolo_deepsort/bloc/media_bloc.dart';
import 'package:yolo_deepsort/bloc/media_state.dart';

class UploadContainer extends StatefulWidget {
  const UploadContainer({super.key});

  @override
  State<UploadContainer> createState() => _UploadContainerState();
}

class _UploadContainerState extends State<UploadContainer> {
  final ValueNotifier<VideoPlayerController?> _videoControllerNotifier =
      ValueNotifier<VideoPlayerController?>(null);
  final ValueNotifier<bool> _videoErrorNotifier = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _videoControllerNotifier.value?.dispose();
    _videoControllerNotifier.dispose();
    _videoErrorNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaPickerBloc, MediaPickState>(
      builder: (context, state) {
        File? mediaFile;

        if (state is MediaPickerImagePicked) {
          mediaFile = state.image;
        } else if (state is MediaPickerVideoPicked) {
          mediaFile = state.video;
          _initializeVideo(mediaFile);
        }

        return Padding(
          padding: EdgeInsets.all(18.0.sp),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: 400.h,
              minWidth: 300.w,
              maxWidth: 500.w,
            ),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(12.sp),
            ),
            child: mediaFile != null
                ? (state is MediaPickerImagePicked
                    ? Image.file(
                        mediaFile,
                        fit: BoxFit.cover,
                      )
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          return SizedBox(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight,
                            child:
                                ValueListenableBuilder<VideoPlayerController?>(
                              valueListenable: _videoControllerNotifier,
                              builder: (context, videoController, _) {
                                if (videoController != null &&
                                    videoController.value.isInitialized) {
                                  return FittedBox(
                                    fit: BoxFit.contain,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(12.sp),
                                      child: SizedBox(
                                        width: constraints.maxWidth,
                                        height: constraints.maxHeight,
                                        child: AspectRatio(
                                          aspectRatio:
                                              videoController.value.aspectRatio,
                                          child: VideoPlayer(videoController),
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (_videoErrorNotifier.value) {
                                  return const Text(
                                    'Error playing video.',
                                    style: TextStyle(color: Colors.red),
                                  );
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
                            ),
                          );
                        },
                      ))
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.upload_rounded,
                          size: 60.sp,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'Upload Image/Video',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }

  void _initializeVideo(File videoFile) {
    final controller = VideoPlayerController.file(videoFile);
    controller.initialize().then((_) {
      _videoControllerNotifier.value = controller;
      controller.play();
    }).catchError((error) {
      _videoErrorNotifier.value = true;
      _videoControllerNotifier.value = null;

      if (kDebugMode) {
        print('Error initializing video controller: $error');
      }
    });
  }
}
