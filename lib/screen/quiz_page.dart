import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_flutter_sqflite/model/question.dart';
import 'package:quiz_app_flutter_sqflite/provider/score_provider.dart';
import 'package:quiz_app_flutter_sqflite/util/constant.dart';
import 'package:quiz_app_flutter_sqflite/util/snack_bar.dart';
import 'package:quiz_app_flutter_sqflite/widget/awesomedialog.dart';

import '../provider/question_provider.dart';

class QuizPage extends StatefulWidget {
  final List<Question> listQuestion;
  final int id;
  final String difficult;
  const QuizPage({super.key, required this.listQuestion, required this.id, required this.difficult});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ScoreProvider>(context,listen: false).getAllScore();
    log("length ${widget.listQuestion.length}");
  }

  @override
  Widget build(BuildContext context) {
    List<int> listQuestionNumber = List<int>.generate(widget.listQuestion.length, (i) =>i  ); // convert array to int

    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: kItemSelectBottomNav,
            elevation: 0.0,
            leading: IconButton(
              onPressed: (){
                buildDialog(context, "Warning!", 'Do you want to cancel this quiz? '
                    , DialogType.warning, ()=>Navigator.pop(context),(){});
              },
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            centerTitle: true,
            title: Column(
              children: <Widget>[

                Text(widget.listQuestion[widget.id].category ?? "N/A",
                  style: kHeadingTextStyleAppBar.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Difficult: ${widget.difficult}",
                  style: kHeadingTextStyleAppBar.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.white
                  ),
                ),

              ],
            )
        ),
        body: SizedBox(
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  height: 280,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 50),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                      color: kItemSelectBottomNav
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  Consumer<QuestionProvider>(
                    builder: (BuildContext context, QuestionProvider value, Widget? child) {
                      Question question = widget.listQuestion[value.currentIndex];
                      final List<String> listOptions = question.incorrectAnswers ?? [];
                      if (!listOptions.contains(question.correctAnswer)) {
                        listOptions.add(question.correctAnswer!);
                        listOptions.shuffle();
                      }
                      return Column(
                        children: <Widget>[
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: <Widget>[
                                ...listQuestionNumber.map((e) => SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  child: InkWell(
                                    onTap: (){
                                      value.selectQuestion(e);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15,right: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: value.currentIndex == e ? Colors.grey[200] : const Color(0xff7146ff),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(7),
                                            child: Text(
                                              e.toString(),
                                              style: TextStyle(
                                                  color: value.currentIndex == e ? Colors.black : Colors.white,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                            child: Text(HtmlUnescape().convert(widget.listQuestion[value.currentIndex].question),
                              style: kHeadingTextStyleAppBar.copyWith(
                                color: Colors.white,
                                fontSize: 22
                            )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20,),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      const BoxShadow(
                                        color: Colors.white,
                                      ),
                                      BoxShadow(
                                        offset: const Offset(10, 10),

                                        color: Colors.grey.shade200,
                                      ),
                                      const BoxShadow(
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                  child:Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ...listOptions.map((e) =>
                                          RadioListTile(
                                            groupValue: value.answer[value.currentIndex],
                                            activeColor: Colors.red,
                                            title: Text(""),
                                            // title: Text(HtmlUnescape().convert(e)),
                                            onChanged: (abc) {
                                              value.selectRadio(e);
                                            },
                                            value: e,
                                          ),
                                      ),
                                    ],
                                  ) ,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: SizedBox(
                                width: 150,
                                child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                      backgroundColor: kItemSelectBottomNav,
                                      shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      ),
                                  ),
                                  onPressed: () {
                                    if (value.answer[value.currentIndex] == null) {
                                      SnackBarUtils.showSnackBar(context, "Please checked answer!");
                                    } else if (value.currentIndex == widget.listQuestion.length -1 ) {
                                      buildDialog(
                                        context,
                                        "Finish?", "Are you sure finish quiz?",
                                        DialogType.success, (){
                                        // Navigator.pushReplacement(context,
                                        //   MaterialPageRoute(builder: (_)=>
                                        //       QuizFinishPage(title: widget.listQuestion[widget.id].category,
                                        //         answer: value.answer,
                                        //         listQuestion: widget.listQuestion,
                                        //       ),
                                        //   ),
                                        // );
                                      },(){},
                                      );
                                    }
                                    else{
                                      value.submitQuiz(widget.listQuestion);
                                    }
                                  },
                                  child: Text(value.currentIndex == widget.listQuestion.length-1 ? "Submit" : "Next",
                                    style: kHeadingTextStyleAppBar.copyWith(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),) ,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> onBackPress(){
    return   buildDialog(context, "Warning!", 'Do you want to cancel this quiz? '
        , DialogType.WARNING, ()=>Navigator.pop(context,true),()=>null);
  }
}
class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = Path();
    path.lineTo(0.0, size.height -40);
    path.quadraticBezierTo(size.width/4, size.height, size.width/2, size.height);
    path.quadraticBezierTo(size.width- (size.width /4 ), size.height, size.width,size.height-40);
    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;

}