import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_flutter_sqflite/model/question.dart';
import 'package:quiz_app_flutter_sqflite/service/api_service.dart';


class QuestionProvider with ChangeNotifier {
  var api = APIService();
  bool showGrid = false;
  List<Question> listQuestion = [];
  bool isLoading = false;
  String error = "";
  int currentIndex = 0;
  Map<int,dynamic> answer = {};
  String selectedCategory = "";



  Future<List<Question>> getDataQuestion(String difficulty,int totalQuestion,int categoriesId) async {
    listQuestion.clear();
    answer.clear();
    String url = "${api.baseURL}?amount=$totalQuestion&category=$categoriesId&difficulty=$difficulty";
    var dio = Dio();
    isLoading = true;
    log(url);
    try {
      var res = await dio.get(url);
      if (res.statusCode == 200) {
        var jsonData = res.data;
        for (var i in jsonData['results']) {
          listQuestion.add(Question.fromJson(i));
        }
      }
      if (res.statusCode == 1) {

      }
    } on DioException catch (e){
      isLoading = true;
      log("getDataQuestion ${e.error}");
    }

    isLoading =false;
    notifyListeners();
    return listQuestion;
  }

  void selectRadio(dynamic e){
      answer[currentIndex] = e;
      notifyListeners();
      return;
  }

  void toggleCategoryView(){
    showGrid = !showGrid;
    notifyListeners();
  }

  void selectQuestion(dynamic e){
    currentIndex = e;
    notifyListeners();
  }

  Future<void> submitQuiz(List<Question> listQuestion) async {
    if (currentIndex < (listQuestion.length - 1) ) {
      currentIndex ++;
      notifyListeners();
    }
    notifyListeners();
  }

  void isLoadingFunc(bool status){
    isLoading = status;
    notifyListeners();
  }
}