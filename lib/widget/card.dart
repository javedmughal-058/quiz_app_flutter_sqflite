import 'package:flutter/material.dart';
import 'package:quiz_app_flutter_sqflite/model/categories.dart';
import 'package:quiz_app_flutter_sqflite/provider/question_provider.dart';

class CardItem extends StatelessWidget {
  final int index;
  final QuestionProvider questionProvider;

  const CardItem({Key? key, required this.index, required this.questionProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return questionProvider.showGrid
        ? Container(
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
        )
        : Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                const BoxShadow(
                  color: Colors.white
                ),BoxShadow(
                  offset: const Offset(5,5),
                  color: Colors.grey.shade200
                ),const BoxShadow(
                  color: Colors.white
                ),

              ]
              // image: DecorationImage(
              //     image: AssetImage(categories[index].image),
              //     fit: BoxFit.cover
              // )
          ),
          child: Row(
            children: [
              const SizedBox(width: 15),
              Container(
                height: 55, width: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: AssetImage(categories[index].image),
                        fit: BoxFit.cover
                    )
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  categories[index].name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400
                  ),
                ),
              ),
            ],
          ),
        );
  }
}
