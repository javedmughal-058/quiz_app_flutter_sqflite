import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:quiz_app_flutter_sqflite/model/question.dart';
import 'package:quiz_app_flutter_sqflite/util/constant.dart';

class ShowQuestionPage extends StatelessWidget {
  final List<Question> listQuestion;
  final Map<int,dynamic> answer;

  const ShowQuestionPage({Key? key, required this.listQuestion,required this.answer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Show Question"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          child: Column(
            children: <Widget>[
              ListView.builder(

                itemCount: listQuestion.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  Question question = listQuestion[index];
                  bool correct = question.correctAnswer == answer[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: double.infinity,

                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(4, 4),
                              blurRadius: 10,
                              color: Colors.grey.withOpacity(.5),
                            ),
                            BoxShadow(
                              offset: const Offset(-3, 0),
                              blurRadius: 15,
                              color: const Color(0xffb8bfce).withOpacity(.5),
                            ),
                          ]
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(HtmlUnescape().convert(listQuestion[index].question!),
                            style: kHeadingTextStyleAppBar.copyWith(fontSize: 22)),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              ...question.incorrectAnswers!.map((e) => Expanded(child: Text(HtmlUnescape().convert(e)))),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                    "Answer: "
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  answer[index] ?? "",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: correct ? Colors.green : Colors.red,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Icon(
                                  correct ? Icons.check_circle : Icons.close,
                                  color: correct ? Colors.green : Colors.red,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          correct ? Container() : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text("Correct: "),
                              Text(HtmlUnescape().convert(question.correctAnswer!),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),)
                            ],
                          )
                        ],
                      ),
                    ),
                  );

                },)
            ],
          ),
        ),
      ),
    );
  }

}