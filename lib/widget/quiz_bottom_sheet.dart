import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_flutter_sqflite/provider/question_provider.dart';
import 'package:quiz_app_flutter_sqflite/screen/quiz_page.dart';
import 'package:quiz_app_flutter_sqflite/util/constant.dart';

class QuizBottomSheet extends StatefulWidget {
  final int id;

  const QuizBottomSheet(
      {Key? key, required this.id})
      : super(key: key);

  @override
  State<QuizBottomSheet> createState() => _QuizBottomSheetState();
}

class _QuizBottomSheetState extends State<QuizBottomSheet> {
  int selectNumber = 0;
  String selectDifficult = "";
  String selectType = "";
  final globalKey = GlobalKey<ScaffoldState>();
  late QuestionProvider questionProvider;

  @override
  void initState() {
    super.initState();
    questionProvider = Provider.of<QuestionProvider>(context,listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(questionProvider.selectedCategory,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Select Total Number of Questions"),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // _buildNumberQuestion(5),
                _buildNumberQuestion(10),
                _buildNumberQuestion(20),
                _buildNumberQuestion(30),
                _buildNumberQuestion(40),
                _buildNumberQuestion(50),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Select Difficulty"),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildDifficultQuestion("Any"),
                _buildDifficultQuestion("Easy"),
                _buildDifficultQuestion("Medium"),
                _buildDifficultQuestion("Hard"),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Consumer<QuestionProvider>(
                builder: (BuildContext context, QuestionProvider value, Widget? child) {
                  return value.isLoading
                      ? CircularProgressIndicator(backgroundColor: kItemSelectBottomNav, color: Colors.white,)
                      : Visibility(
                        visible: !value.isLoading,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kItemSelectBottomNav,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            )
                          ),
                          onPressed: () => _startQuiz(value),
                          child: Text(
                            "Start Quiz",
                            style: kHeadingTextStyleAppBar.copyWith(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildNumberQuestion(int number) {
    return InkWell(
      onTap: () {
        setState(() {
          selectNumber = number;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            const BoxShadow(
              offset: Offset(5, 5),
              blurRadius: 5,
              color: Colors.white,
            ),
            BoxShadow(
              offset: const Offset(-5, -5),
              blurRadius: 5,
              color: const Color(0xffb8bfce).withOpacity(.1),
            ),
          ],
          color:
          selectNumber == number ? kItemSelectBottomNav : Colors.grey[200],
        ),
        child: Text(
          number.toString(),
          style: selectNumber == number
              ? const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
              : const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  _buildDifficultQuestion(String difficult) {
    return InkWell(
      onTap: () {
        setState(() {
          selectDifficult = difficult;
        });
      },
      child: Container(
        width: 70,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          boxShadow: [
            const BoxShadow(
              offset: Offset(5, 5),
              blurRadius: 5,
              color: Colors.white,
            ),
            BoxShadow(
              offset: const Offset(-5, -5),
              blurRadius: 5,
              color: const Color(0xffb8bfce).withOpacity(.1),
            ),
          ],
          color: selectDifficult == difficult
              ? kItemSelectBottomNav
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            difficult,
            style: selectDifficult == difficult
                ? const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                : const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  _startQuiz(QuestionProvider provider) async {
    if (selectNumber != null) {
      provider.isLoadingFunc(false);
      await provider.getDataQuestion(
          selectDifficult.toLowerCase(),
          selectNumber,
          widget.id).then((listQuestion){
        if (listQuestion.isEmpty) {
          log("Not found question");
          const snackBar = SnackBar(
            duration: Duration(milliseconds: 800),
            elevation: 5.0,
            content: Text(
              'Not found question',
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        else {
          Navigator.pop(context); // close show bottom sheet
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => QuizPage(
                difficult: selectDifficult,
                id: widget.id,
                listQuestion: listQuestion,
              ),
            ),
          );

        }
      });


    }
    else {
      const snackBar = SnackBar(
        duration: Duration(milliseconds: 800),
        elevation: 5.0,
        content: Text(
          'Please choose option!',
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}