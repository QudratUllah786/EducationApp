import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class AddWorksheet extends StatefulWidget {
  AddWorksheet({Key? key, this.id}) : super(key: key);
  String? id;

  @override
  State<AddWorksheet> createState() => _AddWorksheetState();
}

class _AddWorksheetState extends State<AddWorksheet> {
  TextEditingController videoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.grey.shade300,
        automaticallyImplyLeading: true,
        title: Text("Add Worksheet"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.black)),
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () async {
                        await pickImage();
                      },
                      child: Text("Uplaod WorkSheet.."),
                    ),
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                await UploadImage(file!).then(
                  (value) async {
                    await FirebaseFirestore.instance
                        .collection('Subjects')
                        .doc(widget.id)
                        .collection('Data')
                        .doc()
                        .set(
                      {
                        "item": value,
                        'type':"Photo",

                      },
                    );
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

  File? file;

  ImagePicker pick = ImagePicker();

  Future pickImage() async {
    final pickFile = await pick.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickFile != null) {
        file = File(pickFile.path);
      } else {
        Get.snackbar("Hey", "Image Not Selected", colorText: Colors.black);
      }
    });
  }

  Future<String> UploadImage(File image) async {
    String ImageUrl = '';
    String fileName = path.basename(image.path);
    var ref = FirebaseStorage.instance.ref().child("Files/$fileName");
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then((value) {
      ImageUrl = value;
    }).catchError((e) {
      print(e);
    });
    return ImageUrl;
  }
}
