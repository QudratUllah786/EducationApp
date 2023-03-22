
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Quiz/quiz_app/home.dart';
import '../profile/profile_screen.dart';
import 'home.dart';
import 'instructor.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final screens = [
    Home(),
    HomeQuiz1(),
    Instructor(),
    ProfileScreen(),
   // Instructor(),
 //   ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.home,

              ),
              label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.quiz_outlined,

              ),
              label: 'Quiz'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.insert_chart_outlined,

              ),
              label: 'Instructor'),

          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.person,

              ),
              label: 'Profile'),

        ],
      ),
    );
  }
}