import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:yolo_deepsort/common/images.dart';
import 'package:yolo_deepsort/common/style.dart';
import 'package:yolo_deepsort/screens/home_page.dart';
import 'package:yolo_deepsort/screens/onboarding/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              children: const [
                OnboardingPage(
                  image: Images.yolo,
                  title: 'Welcome to YOLO & DeepSort',
                  description:
                      'Detect and track multiple objects in real-time with YOLO and DeepSort working together.',
                ),
                OnboardingPage(
                  image: Images.deepSort,
                  title: 'Real-time Object Detection',
                  description:
                      'Use YOLO to detect various objects in images and videos instantly.',
                ),
                OnboardingPage(
                  image: Images.both,
                  title: 'Object Tracking with DeepSort',
                  description:
                      'Track detected objects across frames using the powerful DeepSort algorithm.',
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ));
                  },
                  child: Text(
                    'Skip',
                    style: AppTextStyle.primaryTextStyle
                        .copyWith(color: Colors.white),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: const WormEffect(
                    dotWidth: 12,
                    dotHeight: 12,
                    activeDotColor: Colors.blue,
                    dotColor: Colors.grey,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (_controller.page!.toInt() == 2) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ));
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(
                    'Next',
                    style: AppTextStyle.primaryTextStyle
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
