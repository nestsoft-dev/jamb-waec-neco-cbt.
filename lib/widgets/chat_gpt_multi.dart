import 'package:flutter/material.dart';

import 'QuizPage.dart';

class QuizHomePage extends StatelessWidget {
  QuizHomePage({
    super.key,
    required this.subjectsList,
    required this.firstsubject,
    required this.secondsubject,
    required this.thirdsubject,
    required this.fourthsubject,
    required this.examType,
    required this.year,
  });
  List<String> subjectsList;
  String firstsubject;
  String secondsubject;
  String thirdsubject;
  String fourthsubject;
  String examType;
  String year;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Exam type is $examType for the year $year'),
          bottom: TabBar(
            tabs: [
              Tab(text: subjectsList[0]),
              Tab(text: subjectsList[1]),
              Tab(text: subjectsList[2]),
              Tab(text: subjectsList[3]),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            QuizPage(
              tabIndex: 0,
              subject: subjectsList[0],
              type: examType,
              year: year,
            ),
            QuizPage(
              tabIndex: 1,
              subject: subjectsList[1],
              type: examType,
              year: year,
            ),
            QuizPage(
              tabIndex: 2,
              subject: subjectsList[2],
              type: examType,
              year: year,
            ),
            QuizPage(
              tabIndex: 3,
              subject: subjectsList[3],
              type: examType,
              year: year,
            ),
          ],
        ),
      ),
    );
  }
}
