
import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
class AddBook extends StatefulWidget {
  AddBook({Key? key,this.id}) : super(key: key);
  String ? id;
  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  int? number;
  TextEditingController videoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    number = Random().nextInt(10);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.grey.shade300,
        automaticallyImplyLeading: true,
        title: Text("Add Book"),
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
                child: TextButton(
                  onPressed: () async{
                    await fileToPick();
                  },
                  child: Text("Uplaod Book.."),
                )),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                String? neededFile;
                await UploadFile(pdfFile!).then((value)async {
                  neededFile = value;
                  setState(() {

                  });
                  await FirebaseFirestore.instance
                      .collection('Subjects')
                      .doc(widget.id)
                      .collection('Data')
                      .doc()
                      .set(
                    {
                      "item": neededFile,
                      "type":"PdfFileUrl",

                    },
                  );
                });
                Get.back();

              },
              child: Text("Submit"),
            )

          ],
        ),
      ),
    );
  }
  Future<String> UploadFile(File file) async{
    String ImageUrl = '';
    String fileName = path.basename(file.path);
    var ref = FirebaseStorage.instance.ref().child("PdfFiles/$fileName");
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then((value) {
      ImageUrl = value;
    }).catchError((e) {
      print(e);
    });
    return ImageUrl;
  }

  File? pdfFile;
  Future<String> fileToPick()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result!.files.single.path.toString());
      pdfFile = file;
      setState(() {
      });
    } else {
      print("No file selected");
    }
    return pdfFile.toString();
  }

  File? book;

  // Future uploadImageToFirebase(BuildContext context) async {
  Future<void> pickFile() async {
    FilePickerResult? result =
    await FilePicker.platform.pickFiles();
    if(book != null){
      File file = File(book!.path);
      setState(() {

      });
    }
  }



}
