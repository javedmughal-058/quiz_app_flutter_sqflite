import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_flutter_sqflite/provider/question_provider.dart';
import 'package:quiz_app_flutter_sqflite/provider/score_provider.dart';
import 'package:quiz_app_flutter_sqflite/screen/splash_screen.dart';
import 'package:quiz_app_flutter_sqflite/service/my_http_override.dart';


void main() {
  // HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) => QuestionProvider() ,
      ),
      ChangeNotifierProvider(
        create: (_)=>ScoreProvider(),
      )
    ],
      child: const MyApp(),
    )
);

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff05d377).withOpacity(.9)),
        useMaterial3: true,
      ),
      transitionDuration: const Duration(milliseconds: 700),
      defaultTransition: Transition.fadeIn,
      home: const SplashPage(),
    );
  }
}