import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_flutter_sqflite/model/question.dart';
import 'package:quiz_app_flutter_sqflite/provider/score_provider.dart';
import 'package:quiz_app_flutter_sqflite/screen/dashboard_page.dart';
import 'package:quiz_app_flutter_sqflite/screen/show_question_page.dart';
import 'package:quiz_app_flutter_sqflite/util/constant.dart';
import 'package:quiz_app_flutter_sqflite/widget/button.dart';

class QuizFinishPage extends StatefulWidget {
  final String title;
  final Map<int,dynamic> answer;
  final List<Question> listQuestion;

  const QuizFinishPage({Key? key, required this.title, required this.answer, required this.listQuestion}) : super(key: key);

  @override
  State<QuizFinishPage> createState() => _QuizFinishPageState();
}

class _QuizFinishPageState extends State<QuizFinishPage> {
  int correct = 0 ;
  int incorrect = 0;
  int score = 0 ;
  final nameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initializeDateFormatting();
    widget.answer.forEach((key, value) {
      if (widget.listQuestion[key].correctAnswer == value) {
        correct ++;
        score +=10;
      }else{
        incorrect ++;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            left: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/ballon2.png'),
                    fit: BoxFit.cover
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/ballon4.png'),
                    fit: BoxFit.cover
                ),
              ),
            ),
          ),
          Positioned(
            left: 40,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/ballon2.png'),
                    fit: BoxFit.cover
                ),
              ),
            ),
          ),
          Positioned(
            // bottom: -20,
            right: -20,
            child: Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/ballon4.png'),
                    fit: BoxFit.cover
                ),
              ),
            ),
          ),
          Positioned(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 250,
                  child: Image.asset('assets/congratulate.png'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Your Score : ",
                      style: kHeadingTextStyleAppBar.copyWith(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "$score",
                      style: kHeadingTextStyleAppBar.copyWith(
                        fontSize: 24,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "You have successfully completed",
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(widget.title,style: kHeadingTextStyleAppBar.copyWith(fontSize: 25)),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Chip(
                        elevation: 5.0,
                        shadowColor: Colors.black54,
                        backgroundColor: Colors.grey[200],
                        label: Row(
                          children: <Widget>[
                            const Icon(Icons.check,color: Colors.green,),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("$correct  correct"),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        )
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Chip(
                        elevation: 5.0,
                        shadowColor: Colors.black54,
                        backgroundColor: Colors.grey[200],
                        label: Row(
                          children: <Widget>[
                            const Icon(Icons.close,color: Colors.red,),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("$incorrect incorrect"),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        )
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 120,
                  child: Button(
                    title: 'Show Question',
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>ShowQuestionPage(
                        answer: widget.answer,
                        listQuestion: widget.listQuestion)));
                    },
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: 120,
                    child: Button(
                        title: 'Save Score',
                        onTap: (){
                          _buildDialogSaveScore();
                        })
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: 120,
                    child: Button(
                        title: 'Home',
                        onTap: (){
                          Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (_)=> const DashBoardPage()), (e) => false);
                        })
                ),
              ],
            ),
          ),


        ],
      ),
    );
  }
  _buildDialogSaveScore(){
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetAnimationDuration:
          const Duration(milliseconds: 100),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            width: double.infinity,
            height: 230,
            child: Column(
              children: <Widget>[
                Text('Save Score',
                  style: kHeadingTextStyleAppBar.copyWith(
                      fontSize: 20
                  ),),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: "Your Name",
                      prefixIcon: Icon(Icons.save),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(alignment: Alignment.topLeft,
                  child: Row(
                    children: <Widget>[
                      const Text("Your Score: ",style: TextStyle(
                          fontSize: 18
                      ),),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(score.toString(),style: kHeadingTextStyleAppBar.copyWith(
                          fontSize: 18,
                          color: Colors.red
                      ),),
                    ],
                  ),),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kItemSelectBottomNav,
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(15),
                          )),
                      onPressed: () {},
                      child: const Text('Cancel',
                        style: TextStyle(
                          color: Colors.white,
                        ),),
                    ),
                    ElevatedButton(
                      onPressed: ()  => _saveScore(),
                      child: const Text("Save"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  _saveScore() async {
    var now =  DateTime.now();
    // String datetime =  DateFormat.yMd().format(now);
    String datetime =  "";
    await Provider.of<ScoreProvider>(context,listen: false).addScore(nameController.text,
        widget.title, score,datetime ,correct,widget.listQuestion.length).then((value){
      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (_)=> const DashBoardPage()), (e) => false);
    });

  }
}