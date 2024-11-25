// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controller/splash_screen/screen_splash.dart';
// import '../../core/colors.dart';
// import '../../core/constant.dart';
// import '../widgets.dart';
//
// class ScreenSplash extends StatelessWidget {
//   ScreenSplash({super.key});
//
//   final ScreenSplashController _screenSplashController =
//       Get.put(ScreenSplashController());
//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await _screenSplashController.gotoHome(context);
//     });
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               functionText(
//                 appName,
//                 kWhiteColor,
//                 FontWeight.bold,
//                 48,
//               ),
//               functionText(
//                 'Music Player',
//                 kWhiteColor,
//                 FontWeight.bold,
//                 24,
//               ),
//               SizedBox(
//                 height: Get.height * 0.05,
//               ),
//               const CircularProgressIndicator(
//                 color: kWhiteColor,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/splash_screen/screen_splash.dart';
import '../../core/colors.dart'; // Ensure these imports exist
import '../../widgets/custom_progress_bar.dart';
import '../../widgets/widgets.dart'; // Ensure custom widgets are imported
import 'dart:math'; // For the liquid painter logic

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _animationValue = 0.0;
  final ScreenSplashController _screenSplashController =
      Get.put(ScreenSplashController());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4), // Duration for the liquid animation
    );

    _controller.addListener(() {
      setState(() {
        _animationValue = _controller.value;
      });
    });

    _controller.forward().then((_) async {
      await _screenSplashController
          .gotoHome(context); // Navigate after animation
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display the logo image
              Image.asset(
                "assets/images/applogo.png", // Ensure this path is correct in your assets
                height: 400,
                width: 400,
              ),
              // SizedBox(height: 20),

              // Custom liquid animation
              Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    painter: LiquidPainter(_animationValue, 1.0),
                    size: Size(200.0, 200.0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
