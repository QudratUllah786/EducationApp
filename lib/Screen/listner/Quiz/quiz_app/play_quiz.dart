import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/Screen/instructor/Quiz/quiz_app/quiz_database.dart';
import 'package:education/Screen/instructor/Quiz/quiz_app/quiz_play_widgets.dart';
import 'package:education/Screen/instructor/Quiz/quiz_app/result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/question_model.dart';
// import 'package:login/model/question_model.dart';
// import 'package:login/quiz_app/quiz_database.dart';
// import 'package:login/quiz_app/quiz_play_widgets.dart';
// import 'package:login/quiz_app/result.dart';

class PlayQuiz extends StatefulWidget {
  String quizId;

  PlayQuiz({required this.quizId});

  @override
  State<PlayQuiz> createState() => _PlayQuizState();
}

int total = 0;
int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;

class _PlayQuizState extends State<PlayQuiz> {
  DatabaseService databaseService = DatabaseService();
  Stream<QuerySnapshot>? quizStream;
  QuerySnapshot? querySnapshot;

  QuestionModel getQuestionModelFromDataSnapshot(
      DocumentSnapshot documentSnapshot, int index) {
    QuestionModel questionModel = QuestionModel();
    questionModel.question = querySnapshot!.docs[index]['question'];
    List<String> options = [
      querySnapshot!.docs[index]['option1'],
      querySnapshot!.docs[index]['option2'],
      querySnapshot!.docs[index]['option3'],
      querySnapshot!.docs[index]['option4'],
    ];
    options.shuffle();
    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = querySnapshot!.docs[index]['option1'];
    questionModel.answered = false;
    return questionModel;
  }

  @override
  void initState() {
    FirebaseFirestore.instance.collection('Quiz').doc(widget.quizId).collection('QNA').get().then((value){
      setState((){
        querySnapshot = value;
            _notAttempted = 0;
            _correct = 0;
            total = querySnapshot!.docs.length;
            _incorrect=0;
      });

       print(querySnapshot!.docs[0]['option1']);
       print(querySnapshot!.docs[1]['option1']);
      // print(value.docs[0]['option2']);
    });
    // databaseService.getQuizList(widget.quizId).then((val) {
    //   setState(() {
    //     querySnapshot = val;
    //     _notAttempted = 0;
    //     _correct = 0;
    //     total = querySnapshot!.docs.length;
    //   });
    // });
    super.initState();
  }

  //
  // List<String> list =[];
  // getOptions() async{
  //   var data = await FirebaseFirestore.instance.collection("Quiz")
  //       .doc(widget.quizId).collection("QNA").get();
  //       //.then((value) => print('^^^^^^^^^^^^^^^^^^^^^^^${value.docs[0]['answers']}'));
  //       list.add(data.docs[0]['answers']);
  //   //.doc().get().then((value) => print('^^^^^^^^^^^^^^^^^^^^^^^${value.id}'));
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black54),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        leading: IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.navigate_before)),
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
                color: Colors.blueAccent,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              )),
        ])),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.to(()=>ResultScreen(total: total, correct: _correct, incorrect:_incorrect));
        },
        child: Icon(Icons.check),
      ),
      body:
      Container(
        child: Column(
          children: [

            querySnapshot == null
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )

                : Expanded(
                  child: ListView.builder(
                  scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      // itemCount: snapshot.data!.,
                      itemCount: querySnapshot!.docs.length,
                      itemBuilder: (context, index) {
                       // return Text(querySnapshot!.docs[0]['option1']);
                        return QuizPlatTile(
                          questionModel: getQuestionModelFromDataSnapshot(
                              querySnapshot!.docs[index],index),
                          index: index,
                        );
                      }),
                )
          ],
        ),
      ),
    );
  }
}

class QuizPlatTile extends StatefulWidget {
  final QuestionModel questionModel;

  final int index;

  const QuizPlatTile({required this.questionModel, required this.index});

  @override
  State<QuizPlatTile> createState() => _QuizPlatTileState();
}

class _QuizPlatTileState extends State<QuizPlatTile> {
  String optionSelected = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Q${widget.index+1} ${widget.questionModel.question}",style: TextStyle(
              fontSize: 16,color: Colors.black87
            ),),
            SizedBox(
              height: 4,
            ),
            GestureDetector(
              onTap: (){
                if(!widget.questionModel.answered){
                  ///correct
                  if(widget.questionModel.option1
                  == widget.questionModel.correctOption){
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered = true;
                    _correct = _correct+1;
                    _notAttempted = _notAttempted -1;
                    setState((){});
                  }
                  else{
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered= true;
                    _incorrect = _incorrect + 1;
                    setState((){});
                  }
                }

              },
              child: OptionTile(
                  description: widget.questionModel.option1,
                  correctAnswer: widget.questionModel.correctOption,
                  option: 'A',
                  optionSelected: optionSelected),
            ),
            SizedBox(
              height: 4,
            ),
            GestureDetector(
              onTap: (){
                if(!widget.questionModel.answered){
                  ///correct
                  if(widget.questionModel.option2
                      == widget.questionModel.correctOption){
                    optionSelected = widget.questionModel.option2;
                    widget.questionModel.answered = true;
                    _correct = _correct+1;
                    _notAttempted = _notAttempted -1;
                    setState((){});
                  }
                  else{
                    optionSelected = widget.questionModel.option2;
                    widget.questionModel.answered= true;
                    _incorrect = _incorrect + 1;
                    setState((){});
                  }
                }

              },
              child: OptionTile(
                  description: widget.questionModel.option2,
                  correctAnswer: widget.questionModel.correctOption,
                  option: 'B',
                  optionSelected: optionSelected),
            ),
            SizedBox(
              height: 4,
            ),
            GestureDetector(
              onTap: (){
                if(!widget.questionModel.answered){
                  ///correct
                  if(widget.questionModel.option3
                      == widget.questionModel.correctOption){
                    optionSelected = widget.questionModel.option3;
                    widget.questionModel.answered = true;
                    _correct = _correct+1;
                    _notAttempted = _notAttempted -1;
                    setState((){});
                  }
                  else{
                    optionSelected = widget.questionModel.option3;
                    widget.questionModel.answered= true;
                    _incorrect = _incorrect + 1;
                    setState((){});
                  }
                }

              },
              child: OptionTile(
                  description: widget.questionModel.option3,
                  correctAnswer: widget.questionModel.correctOption,
                  option: 'C',
                  optionSelected: optionSelected),
            ),
            SizedBox(
              height: 4,
            ),
            GestureDetector(
              onTap: (){
                if(!widget.questionModel.answered){
                  ///correct
                  if(widget.questionModel.option4
                      == widget.questionModel.correctOption){
                    optionSelected = widget.questionModel.option4;
                    widget.questionModel.answered = true;
                    _correct = _correct+1;
                    _notAttempted = _notAttempted -1;
                    setState((){});
                  }
                  else{
                    optionSelected = widget.questionModel.option4;
                    widget.questionModel.answered= true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted -1;
                    setState((){});
                  }
                }

              },
              child: OptionTile(
                  description: widget.questionModel.option4,
                  correctAnswer: widget.questionModel.correctOption,
                  option: 'D',
                  optionSelected: optionSelected),
            )
          ],
        ),
      ),
    );
  }
}
