import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/Screen/instructor/Quiz/quiz_app/play_quiz.dart';
import 'package:education/Screen/instructor/Quiz/quiz_app/quiz_database.dart';
import 'package:education/Screen/instructor/Quiz/quiz_app/quiz_maker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeQuiz extends StatefulWidget {
  const HomeQuiz({Key? key}) : super(key: key);

  @override
  State<HomeQuiz> createState() => _HomeQuizState();
}

class _HomeQuizState extends State<HomeQuiz> {
  DatabaseService databaseService = DatabaseService();
  Stream<QuerySnapshot>? quizStream;

  Widget quizList() {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return AlertDialog(
              title: Text('Something Went Wrong'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return QuizTile(
                title: data['title'],
                imgUrl: data['imgUrl'],
                desc: data['desc'],
                quizId: data['quizId'],
              );
            }).toList(),
          );
        },
        stream: quizStream,
      ),
    );
  }

  @override
  void initState() {
    databaseService.getQuizData().then((val) {
      setState(() {
        quizStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.navigate_before)),
        //automaticallyImplyLeading: true,
        //leading: Icon(Icons.navigate_before),
        title: RichText(
            text: TextSpan(children: [
          TextSpan(
              text: 'Quiz',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              )),
          TextSpan(
              text: 'Maker',
              style: TextStyle(
                color: Colors.purple.shade500,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              )),
        ])),
      ),
      floatingActionButton: FloatingActionButton(
          heroTag: 1,
          child: Icon(Icons.add),
          onPressed: () {
            Get.to(
              () => QuizMaker(),
            );
          }),
      body: quizList(),
    );
  }
}

class QuizTile extends StatelessWidget {
  String quizId;
  String imgUrl;
  String title;
  String desc;

  QuizTile({
    Key? key,
    required this.title,
    required this.imgUrl,
    required this.desc,
    required this.quizId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => PlayQuiz(quizId: quizId));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.grey.shade300,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 0, left: 15, top: 10),
                height: 150,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imgUrl,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width - 48,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          Text(
                            desc,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              TextButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('Quiz')
                        .doc(quizId)
                        .delete();
                  },
                  child: Text(
                    "Delete",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
