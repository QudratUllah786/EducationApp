import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:path/path.dart' as path;

class AddVideo extends StatelessWidget {
   AddVideo({Key? key,this.id}) : super(key: key);
  String ? id;
  TextEditingController videoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.grey.shade300,
        automaticallyImplyLeading: true,
        title: Text("Add Video"),
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
                  border: Border.all(width: 1, color: Colors.black)),
              child: TextField(
                controller: videoController,
                maxLines: 50,
                decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: "Enter video Link...",
                    hintStyle: TextStyle(fontSize: 14, color: Colors.black),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            ElevatedButton(
              onPressed: () async {




                print(id);
                    await FirebaseFirestore.instance
                        .collection('Subjects')
                        .doc(id)
                        .collection('Data')
                        .doc()
                        .set(
                      {

                        'item': videoController.text,
                        'type': "Video",

                      },
                    );
                    Get.back();
                  },




              child: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
