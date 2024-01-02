
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app_flutter_sqflite/controllers/fade_animation_controller.dart';
import 'package:quiz_app_flutter_sqflite/model/fade_animation_model.dart';
import 'package:quiz_app_flutter_sqflite/util/constant.dart';
import 'package:quiz_app_flutter_sqflite/widget/fade_animation_widget.dart';


class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FadeInAnimationController controller = Get.put(FadeInAnimationController());
    controller.startSplashAnimation();

    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: kItemSelectBottomNav
        ),
        child: Stack(
          children: [
            CustFadeInAnimationWidget(
              durationInMs: 1600,
              animate: TAnimatePosition(topAfter: size.height * 0.15, topBefore: -30, leftBefore: -30, leftAfter: 30),
              child: const Text("Quiz ", style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 3.0,
                    fontWeight: FontWeight.bold,
                    fontSize: 40)),
            ),
            const SizedBox(height: 10),
            CustFadeInAnimationWidget(
              durationInMs: 2000,
              animate: TAnimatePosition(topAfter: size.height * 0.25, topBefore: 50, leftBefore: -80, leftAfter: 30),
              child:  const Text("Knowledge ", style: TextStyle(
                color: Colors.white,
                letterSpacing: 3.0,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              )),
            ),
            const SizedBox(height: 20),
            CustFadeInAnimationWidget(
              durationInMs: 2400,
              animate: TAnimatePosition(bottomBefore: 0, bottomAfter: 120, leftBefore: -80, leftAfter: 20),
              child: Center(child: Image.asset('assets/icon.png', height: 300, width: 300)),
            ),
            const SizedBox(height: 20),
            CustFadeInAnimationWidget(
              durationInMs: 2400,
              animate: TAnimatePosition(bottomBefore: 0, bottomAfter: 100, leftBefore: -80, leftAfter: 30),
              child: const Text("By (MJ) ", style: TextStyle(
                color: Colors.white,
                letterSpacing: 3.0,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              )),
            ),
            const SizedBox(height: 10),
            CustFadeInAnimationWidget(
              durationInMs: 2400,
              animate: TAnimatePosition(bottomBefore: 0, bottomAfter: 60, leftBefore: 30, leftAfter: 30),
              child: const Text("© Tech CoderGuru Pvt Ltd, Inc. All rights reserved", style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.0,
                fontWeight: FontWeight.normal,
                fontSize: 12,
              )),
            ),

          ],
        ),
      ),
    );
  }
}
