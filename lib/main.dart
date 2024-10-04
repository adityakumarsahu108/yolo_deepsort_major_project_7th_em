import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yolo_deepsort/bloc/media_bloc.dart';
import 'package:yolo_deepsort/screens/onboarding/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return BlocProvider(
          create: (context) => MediaPickerBloc(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const OnboardingScreen(),
            theme: ThemeData.dark(),
          ),
        );
      },
    );
  }
}
