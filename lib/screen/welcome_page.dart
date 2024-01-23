import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app_flutter_sqflite/controllers/fade_animation_controller.dart';
import 'package:quiz_app_flutter_sqflite/model/fade_animation_model.dart';
import 'package:quiz_app_flutter_sqflite/screen/dashboard_page.dart';
import 'package:quiz_app_flutter_sqflite/util/constant.dart';
import 'package:quiz_app_flutter_sqflite/widget/fade_animation_widget.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final FadeInAnimationController controller = Get.find();
    controller.animationIn();
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white
        ),
        child: Stack(
          children: [
            CustFadeInAnimationWidget(
              durationInMs: 1600,
              animate: TAnimatePosition(
                  bottomBefore: -100,
                  bottomAfter: 0,
                  leftBefore: 0,
                  leftAfter: 0,
                  rightAfter: 0,
                  rightBefore: 0,
                  topAfter: 0,
                  topBefore: 0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 42),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Check Your ", style: TextStyle(
                        color: kItemUnSelectBottomNav,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.normal,
                        fontSize: 16)),
                    Text("Quiz\nKnowledge ", style: TextStyle(
                      color: kItemSelectBottomNav,
                      letterSpacing: 3.0,
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    )),
                    const Text("Using QAFs", style: TextStyle(
                        color: kItemUnSelectBottomNav,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.normal,
                        fontSize: 16)),
                    Image.asset('assets/icon2.png', height: 300, width: 300),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: ()=> Get.offAll(()=> const DashBoardPage()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kItemSelectBottomNav,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Start',style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 3.0,
                              fontWeight: FontWeight.bold,
                              fontSize: 16))),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
