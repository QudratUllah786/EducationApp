import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class AddSubject extends StatefulWidget {
  AddSubject({Key? key,this.type,this.id}) : super(key: key);
  String? type;
  String? id;

  @override
  State<AddSubject> createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {
  final TextEditingController postController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: true,
          title: Text("Add Subject"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1,color: Colors.black)
                ),
                child: TextField(
                  controller: postController,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: "Enter Subject Name...",
                      hintStyle: TextStyle(fontSize: 14,color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      )
                  ),
                ),
              ),


              SizedBox(height: 20,),
              ElevatedButton(onPressed: ()async{
                var currentUser =  FirebaseAuth.instance.currentUser;
                String? instructor;
               await FirebaseFirestore.instance.collection('Teacher').doc(currentUser!.uid).get().then((value) =>{
                 instructor = value['Name'],
               });
                  print(currentUser!.uid);
                  await FirebaseFirestore.instance.collection('Categories').doc().set({
                    "CategoryType": postController.text,
                    "CurrentId" : currentUser.uid,
                    'Instructor': instructor,
                  });


                Get.back();
                // Get.to(TopicDetail());
              }, child: Text("Submit"),)
            ],
          ),
        )
    );
  }
}
