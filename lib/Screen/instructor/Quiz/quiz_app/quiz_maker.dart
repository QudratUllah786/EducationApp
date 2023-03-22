import 'package:education/Screen/instructor/Quiz/quiz_app/quiz_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:login/quiz_app/add_question_screen.dart';
// import 'package:login/quiz_app/quiz_database.dart';
import 'package:random_string/random_string.dart';

import 'add_question_screen.dart';

class QuizMaker extends StatefulWidget {
  @override
  State<QuizMaker> createState() => _QuizMakerState();
}

class _QuizMakerState extends State<QuizMaker> {
  DatabaseService databaseService = DatabaseService();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  String? imgUrl,title,desc,quizId;
 createQuizOnline(){
   if(_formKey.currentState!.validate()){
     setState((){
       isLoading = true;
     });
     quizId = randomAlphaNumeric(16);
     Map<String,String> quizMap = {
       'quizId':quizId!,
       'imgUrl':imgUrl!,
       'title':title!,
       'desc':desc!,
     };
     databaseService.addQuizData(quizMap, quizId!).then((value){
       setState((){
         isLoading = false;
         Get.to(AddQuestionScreen(
           quizId!,
         ));
       });

     });
   }
   // databaseService.addQuizData(
   //     quizData, quizId
   // )
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
      body: isLoading == true?  Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ): Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                return  value!.isEmpty ? 'Please Enter Image Url' : null;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Image Url',
                ),
                onChanged: (value) {
                  imgUrl = value;
                },
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (value) {
                return value!.isEmpty ? 'Please Enter Title' : null;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Title',
                ),
                onChanged: (value) {
                  title = value;
                },
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (value) {
                return  value!.isEmpty ? 'Please Enter Description' : null;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Description',
                ),
                onChanged: (value) {
                 desc = value;
                },
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  createQuizOnline();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.074,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: isLoading == true? Center(child: CircularProgressIndicator(),): Text(
                    'Create Quiz',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
