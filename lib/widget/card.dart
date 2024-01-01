import 'package:flutter/material.dart';
import 'package:quiz_app_flutter_sqflite/model/categories.dart';
import 'package:quiz_app_flutter_sqflite/provider/question_provider.dart';

class CardItem extends StatelessWidget {
  final int index;
  final QuestionProvider questionProvider;

  const CardItem({Key? key, required this.index, required this.questionProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(categories[index].image),
            fit: BoxFit.cover
          )
        ),
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  categories[index].name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: questionProvider.showGrid ? 14 : 19,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            )
          ],
        ),
      );
  }
}
