import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_app_flutter_sqflite/screen/score_page.dart';
import 'package:quiz_app_flutter_sqflite/util/constant.dart';

import 'home_screen.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  int currentIndex = 0 ;


  List<Widget> listScreen = [
    const HomePage(),
    const ScorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: listScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Colors.white,
        selectedItemColor: kItemSelectBottomNav,
        elevation: 5.0,
        unselectedItemColor: kItemUnSelectBottomNav,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          _buildItemBottomNav(FontAwesomeIcons.house, "Home"),
          _buildItemBottomNav(FontAwesomeIcons.clockRotateLeft,"Point" )
        ],

      ),
    );
  }
  _buildItemBottomNav(IconData icon, String title){
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: title,
    );
  }
}
