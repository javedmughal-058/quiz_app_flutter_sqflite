import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_flutter_sqflite/model/categories.dart';
import 'package:quiz_app_flutter_sqflite/provider/question_provider.dart';
import 'package:quiz_app_flutter_sqflite/util/constant.dart';
import 'package:quiz_app_flutter_sqflite/widget/quiz_bottom_sheet.dart';

import '../widget/card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late final QuestionProvider questionProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    questionProvider = Provider.of<QuestionProvider>(context,listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: kItemSelectBottomNav
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              Consumer<QuestionProvider>(
                builder: (context, questionProvider, child) {
                  return GestureDetector(
                      onTap: (){
                        questionProvider.toggleCategoryView();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(questionProvider.showGrid
                              ? FontAwesomeIcons.thLarge
                              :  FontAwesomeIcons.bars, size: 18, color: Colors.white),
                          const SizedBox(width: 15),
                        ],
                      ));
                },
              ),
              const Text("Home",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),),
                  ),
                  child: SingleChildScrollView(
                    child: Consumer<QuestionProvider>(
                      builder: (context, questionProvider, child) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),


                            questionProvider.showGrid
                                ? _gridViewItems()
                                : _listViewItems()

                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }


  Widget _gridViewItems() => GridView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Set the number of columns in the grid
        crossAxisSpacing: 8.0, // Set the horizontal spacing between grid items
        mainAxisSpacing: 8.0, // Set the vertical spacing between grid items
      ),
      itemBuilder: (context, index){
        return Padding(
          padding: const EdgeInsets.only(bottom: 10,right:10 ,left: 10),
          child: InkWell(
              onTap: (){
                questionProvider.selectedCategory = categories[index].name;
                _buildBottomSheet(context,categories[index].id);
                },
              child: CardItem(
                index: index,
                questionProvider: questionProvider,
              )
          ),
        );
      });
  Widget _listViewItems() => ListView.builder(
    itemCount: categories.length,
    physics: const ClampingScrollPhysics(),
    shrinkWrap: true,
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10,right:10 ,left: 10),
        child: InkWell(
            onTap: (){
              questionProvider.selectedCategory = categories[index].name;
              _buildBottomSheet(context,categories[index].id);
            },
            child: CardItem(
              index: index,
              questionProvider: questionProvider,
            )
        ),
      );
    },
  );

  _buildBottomSheet(BuildContext context,int id){
    return showModalBottomSheet(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),

        ),
        context: context, builder: (_) {
      return QuizBottomSheet(id: id);
    });
  }
}