import 'package:get/get.dart';
import 'package:quiz_app_flutter_sqflite/screen/dashboard_page.dart';

class FadeInAnimationController extends GetxController {
  static FadeInAnimationController get find => Get.find();

  RxBool animate = false.obs;

  //To be used in Splash Screen due to auto calling of next activity.
  Future startSplashAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;
    await Future.delayed(const Duration(milliseconds: 4000));
    animate.value = false;
    await Future.delayed(const Duration(milliseconds: 2000));
    Get.off(() => const DashBoardPage(),
        duration: const Duration(milliseconds: 1000),
        transition: Transition.fadeIn);
  }

  //Call where you need to animate In any widget.
  Future animationIn() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;
  }

  //Call where you need to animate Out any widget.
  Future animationOut() async {
    animate.value = false;
    await Future.delayed(const Duration(milliseconds: 100));
  }
}