import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiz_app_flutter_sqflite/util/constant.dart';
import 'dashboard_page.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  void startTimer(){
    Timer(const Duration(seconds: 1), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const DashBoardPage()));
    });
  }
@override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: kItemSelectBottomNav
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Quiz ", style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 3.0,
                  fontWeight: FontWeight.bold,
                  fontSize: 40)),
            SizedBox(height: 10),
            Text("Knowledge ", style: TextStyle(
                color: Colors.white,
                letterSpacing: 3.0,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              )),
            SizedBox(height: 20),
            Text("By (MJ) ", style: TextStyle(
              color: Colors.white,
              letterSpacing: 3.0,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            )),
            SizedBox(height: 10),
            Text("© RankCoder Technology, Inc. All rights reserved", style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.0,
              fontWeight: FontWeight.normal,
              fontSize: 12,
            )),

          ],
        ),
      ),
    );
  }
}
