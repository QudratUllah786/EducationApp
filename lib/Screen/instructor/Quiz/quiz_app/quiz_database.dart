import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  QuerySnapshot? querySnapshot;
  Future<void> addQuizData(Map<String,String> quizData,String quizId) async{
   await FirebaseFirestore.instance.collection('Quiz').doc(quizId).set(quizData).catchError(
       (e){
         print(e.toString());
       }
   );

  }

  Future<void> addQuestionData(Map<String,String> questionData, String quizId) async{
    await FirebaseFirestore.instance.collection('Quiz').doc(quizId).collection('QNA').add(questionData).catchError((e){
      print(e);
    });
  }
  getQuizData()async{

    return await FirebaseFirestore.instance.collection('Quiz').snapshots();
  }
  getQuizList(String quizId) async{
    await FirebaseFirestore.instance.collection('Quiz').doc(quizId).collection("QNA").get();
    }
  }
