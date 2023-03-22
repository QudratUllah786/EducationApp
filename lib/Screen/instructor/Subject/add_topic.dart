

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/Screen/instructor/Subject/topic_detail.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/firebase_database.dart'as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Utils/utils.dart';


class AddTopic extends StatefulWidget {
   AddTopic({Key? key,this.type,this.id}) : super(key: key);
  String? type;
  String? id;

  @override
  State<AddTopic> createState() => _AddTopicState();
}

class _AddTopicState extends State<AddTopic> {
  final TextEditingController postController = TextEditingController();
  bool loading = false;
 // final databaseRef = FirebaseDatabase.instance.ref().child("Topic");
 // firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: true,
        title: Text("Add Topic"),
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
                  hintText: "Enter Topic Name...",
                  hintStyle: TextStyle(fontSize: 14,color: Colors.black),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  )
                ),
              ),
            ),


            SizedBox(height: 20,),
            ElevatedButton(onPressed: ()async{
              {
                var currentUser =  FirebaseAuth.instance.currentUser;
                print(currentUser!.uid);
                await FirebaseFirestore.instance.collection('Subjects').doc().set({
                  "Category": postController.text,
                  "Id":currentUser.uid,
                  'SubjectType': widget.type,
                });
                // setState(() {
                //   loading=true;
                // });
                // final id= DateTime.now().millisecondsSinceEpoch.toString();
                //
                //
                // databaseRef.child(id).set({
                //   'title': postController.text.toString(),
                //   'id': id
                //
                // }).then((value) {
                //   Utils().toastMessage("Post Added");
                //   setState(() {
                //     loading=false;
                //   });
                // }).onError((error, stackTrace) {
                //   Utils().toastMessage(error.toString());
                //   setState(() {
                //     loading=false;
                //   });
                // });

              }
              Get.back();
             // Get.to(TopicDetail());
            }, child: Text("Submit"),)
          ],
        ),
      )
    );
  }
}
