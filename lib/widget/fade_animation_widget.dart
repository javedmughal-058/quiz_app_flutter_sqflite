import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app_flutter_sqflite/controllers/fade_animation_controller.dart';
import 'package:quiz_app_flutter_sqflite/model/fade_animation_model.dart';

class CustFadeInAnimationWidget extends StatelessWidget {
  CustFadeInAnimationWidget({
    Key? key,
    required this.durationInMs,
    required this.child,
    this.animate,
  }) : super(key: key);

  final controller = Get.put(FadeInAnimationController());
  final int durationInMs;
  final TAnimatePosition? animate;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => AnimatedPositioned(
            duration: Duration(milliseconds: durationInMs),
            top: controller.animate.value ? animate!.topAfter : animate!.topBefore,
            left:
            controller.animate.value ? animate!.leftAfter : animate!.leftBefore,
            bottom: controller.animate.value
                ? animate!.bottomAfter
                : animate!.bottomBefore,
            right: controller.animate.value
                ? animate!.rightAfter
                : animate!.rightBefore,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: durationInMs),
              opacity: controller.animate.value ? 1 : 0,
              child: child,
            ),
          ),
    );
  }
}