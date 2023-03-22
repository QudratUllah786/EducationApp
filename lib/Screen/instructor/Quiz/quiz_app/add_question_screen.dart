import 'package:education/Screen/instructor/Quiz/quiz_app/home.dart';
import 'package:education/Screen/instructor/Quiz/quiz_app/quiz_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
// import 'package:login/quiz_app/quiz_database.dart';
import 'package:random_string/random_string.dart';
class AddQuestionScreen extends StatefulWidget {
  String quizId;
   AddQuestionScreen(this.quizId);

  @override
  State<AddQuestionScreen> createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  DatabaseService databaseService = DatabaseService();
  String? question,option1,option2,option3,option4;
  bool isLoading =false;
  uploadQuestionData(){
    if(_formKey.currentState!.validate()){
      setState((){
        isLoading = true;
      });
    }
    Map<String,String> questionData = {
      'question':question!,
      'option1':option1!,
      'option2':option2!,
      'option3':option3!,
      'option4':option4!,
    };

    databaseService.addQuestionData(questionData, widget.quizId).then((value){
      setState((){
        isLoading = false;
      });
    });
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
      body: isLoading == true? Container(
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ) :Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  return value!.isEmpty ? 'Please Enter Question' : null;
                },
                decoration: InputDecoration(
                  hintText: 'Question',
                ),
                onChanged: (value) {
                  question = value;
                },
              ),
              const SizedBox(height: 6,),
              TextFormField(
                validator: (value) {
                  return value!.isEmpty ? 'Please Enter Option 1' : null;
                },
                decoration: const InputDecoration(
                  hintText: 'Option 1 (correct Answer)',
                ),
                onChanged: (value) {
                  option1 = value;
                },
              ),
              const SizedBox(height: 6,),
              TextFormField(
                validator: (value) {
                  return value!.isEmpty ? 'Please Enter Option 2' : null;
                },
                decoration: const InputDecoration(
                  hintText: 'Option 2',
                ),
                onChanged: (value) {
                  option2 = value;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (value) {
                  return value!.isEmpty ? 'Please Enter Option3' : null;
                },
                decoration: InputDecoration(
                  hintText: 'Option3',
                ),
                onChanged: (value) {
                  option3 = value;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (value) {
                  return value!.isEmpty ? 'Please Enter Option4' : null;
                },
                decoration: InputDecoration(
                  hintText: 'Option4',
                ),
                onChanged: (value) {
                  option4 = value;
                },
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.074,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                   uploadQuestionData();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.074,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Text(
                        'Add Question',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(height: 20,)

            ],
          ),
        ),
      ),
    );
  }
}
