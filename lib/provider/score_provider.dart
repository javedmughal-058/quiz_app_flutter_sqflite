import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quiz_app_flutter_sqflite/model/score.dart';
import 'package:quiz_app_flutter_sqflite/util/dbmanager.dart';

class ScoreProvider with ChangeNotifier{

  DbManager dbManger = DbManager();
  List<Score> arrScore = [];


  Future<Score> addScore(
      String nameUser,String categories, int score,
      String date, int totalAnswer, int totalQuestion) async{
    Score scoreModel = Score(nameUser: nameUser,categories: categories,score: score,date: date,totalAnswer: totalAnswer,totalQuestion: totalQuestion);
    await dbManger.addUserScore(scoreModel);
    notifyListeners();
    return scoreModel;
  }

  Future deleteScore(int id ) async {
    await dbManger.deleteScore(id);

    notifyListeners();
  }


  Future<List<Score>> getAllScore() async {
   await dbManger.getUserScore().then((value) => {
      arrScore = value
    });
    notifyListeners();
    return arrScore;
  }
}