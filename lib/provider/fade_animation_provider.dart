import 'package:flutter/material.dart';
import 'package:quiz_app_flutter_sqflite/screen/dashboard_page.dart';

class FadeInAnimationProvider with ChangeNotifier {

  bool animate = false;
  //To be used in Splash Screen due to auto calling of next activity.
  Future startSplashAnimation(context) async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 3000));
    animate = false;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 2000));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const DashBoardPage()));
  }


}