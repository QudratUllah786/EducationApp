import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/Screen/instructor/Subject/book.dart';
import 'package:education/Screen/instructor/Subject/video.dart';
import 'package:education/Screen/instructor/Subject/worksheet.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class TopicDetail extends StatefulWidget {
  TopicDetail({Key? key, this.id}) : super(key: key);
  String? id;

  @override
  State<TopicDetail> createState() => _TopicDetailState();
}

class _TopicDetailState extends State<TopicDetail> {
  // TextEditingController videoController = TextEditingController();
  // int currentIndex = 0;
  // final screens = [
  //   Video(),
  //   WorkSheet(),
  //   Book(),
  //
  // ];
  @override
  void initState() {
    // TODO: implement initState
    print('#############################################');
    print(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 1,
          backgroundColor: Colors.grey.shade300,
          automaticallyImplyLeading: true,
          title: Text("Topic detail"),
        ),
      body:  Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200
              ),
              child: TextButton(
                onPressed: (){
                  print(widget.id);
                  Get.to(Video(id: widget.id,type:'Video'));
                },
                child: Text("ADD VIDEO",style: TextStyle(color: Colors.black),),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200
              ),
              child: TextButton(
                onPressed: (){

                  Get.to(WorkSheet(id: widget.id,type: 'Photo',));
                },
                child: Text("ADD WORKSHEET",style: TextStyle(color: Colors.black),),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200
              ),
              child: TextButton(
                onPressed: (){
                  Get.to(Book(id: widget.id,type: "PdfFileUrl",));
                  print(widget.id);
                },
                child: Text("ADD BOOK",style: TextStyle(color: Colors.black),),
              ),
            ),

          ],
        ),
      )

      // IndexedStack(
      //   index: currentIndex,
      //   children: screens,
      // ),

        // body: Padding(
        //   padding: const EdgeInsets.all(15.0),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       //video link wiget
        //       Container(
        //         height: 70,
        //         width: double.infinity,
        //         decoration: BoxDecoration(
        //             color: Colors.grey.shade200,
        //             borderRadius: BorderRadius.circular(10),
        //             border: Border.all(width: 1, color: Colors.black)),
        //         child: TextField(
        //           controller: videoController,
        //           maxLines: 50,
        //           decoration: InputDecoration(
        //               labelStyle: TextStyle(color: Colors.black),
        //               hintText: "Enter video Link...",
        //               hintStyle: TextStyle(fontSize: 14, color: Colors.black),
        //               border: OutlineInputBorder(
        //                 borderSide: BorderSide.none,
        //               )),
        //         ),
        //       ),
        //       SizedBox(
        //         height: 10,
        //       ),
        //       //worksheet widget
        //       Container(
        //           height: 100,
        //           width: double.infinity,
        //           decoration: BoxDecoration(
        //               color: Colors.grey.shade200,
        //               borderRadius: BorderRadius.circular(10),
        //               border: Border.all(width: 1, color: Colors.black)),
        //           child: Column(
        //             children: [
        //               TextButton(
        //                 onPressed: () async {
        //                   await pickImage();
        //                 },
        //                 child: Text("Uplaod WorkSheet.."),
        //               ),
        //             ],
        //           )),
        //       SizedBox(
        //         height: 10,
        //       ),
        //       //book widget
        //       Container(
        //           height: 100,
        //           width: double.infinity,
        //           decoration: BoxDecoration(
        //               color: Colors.grey.shade200,
        //               borderRadius: BorderRadius.circular(10),
        //               border: Border.all(width: 1, color: Colors.black)),
        //           child: TextButton(
        //             onPressed: () async{
        //               await fileToPick();
        //             },
        //             child: Text("Uplaod Book.."),
        //           )),
        //       SizedBox(
        //         height: 20,
        //       ),
        //       //Add button widget
        //       ElevatedButton(
        //         onPressed: () async {
        //           String? neededFile;
        //           await UploadFile(pdfFile!).then((value) {
        //             neededFile = value;
        //             setState(() {
        //
        //             });
        //           });
        //           await UploadImage(file!).then(
        //             (value) async {
        //
        //               await FirebaseFirestore.instance
        //                   .collection('Subjects')
        //                   .doc(widget.id)
        //                   .collection('Data')
        //                   .doc()
        //                   .set(
        //                 {
        //                   "Image": value,
        //                   'VideoUrl': videoController.text,
        //                   "PdfFileUrl": neededFile,
        //                 },
        //               );
        //             },
        //           );
        //
        //         },
        //         child: Text("Submit"),
        //       )
        //     ],
        //   ),
        // ),
      // bottomNavigationBar: BottomNavigationBar(
      //   elevation: 10,
      //   backgroundColor: Colors.white,
      //   selectedItemColor: Colors.purple,
      //   unselectedItemColor: Colors.grey,
      //   type: BottomNavigationBarType.fixed,
      //   currentIndex: currentIndex,
      //   onTap: (index) => setState(() => currentIndex = index),
      //   items: [
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           CupertinoIcons.play_rectangle,
      //
      //         ),
      //         label: 'Video'),
      //
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           CupertinoIcons.photo,
      //
      //         ),
      //         label: 'Worksheet'),
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           CupertinoIcons.book,
      //
      //         ),
      //         label: 'Book'),
      //
      //   ],
      // ),
    );
  }

  // File? file;
  //
  // ImagePicker pick = ImagePicker();
  //
  // Future pickImage() async {
  //   final pickFile = await pick.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     if (pickFile != null) {
  //       file = File(pickFile.path);
  //     } else {
  //       Get.snackbar("Hey", "Image Not Selected");
  //     }
  //   });
  // }
  //
  // Future<String> UploadImage(File image) async {
  //   String ImageUrl = '';
  //   String fileName = path.basename(image.path);
  //   var ref = FirebaseStorage.instance.ref().child("Files/$fileName");
  //   UploadTask uploadTask = ref.putFile(image);
  //   TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
  //   await taskSnapshot.ref.getDownloadURL().then((value) {
  //     ImageUrl = value;
  //   }).catchError((e) {
  //     print(e);
  //   });
  //   return ImageUrl;
  // }
  //
  // Future<String> UploadFile(File file) async{
  //   String ImageUrl = '';
  //   String fileName = path.basename(file.path);
  //   var ref = FirebaseStorage.instance.ref().child("PdfFiles/$fileName");
  //   UploadTask uploadTask = ref.putFile(file);
  //   TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
  //   await taskSnapshot.ref.getDownloadURL().then((value) {
  //     ImageUrl = value;
  //   }).catchError((e) {
  //     print(e);
  //   });
  //   return ImageUrl;
  // }
  //
  // File? pdfFile;
  // Future<String> fileToPick()async{
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();
  //
  //   if (result != null) {
  //     File file = File(result!.files.single.path.toString());
  //     pdfFile = file;
  //     setState(() {
  //     });
  //   } else {
  //     print("No file selected");
  //   }
  //   return pdfFile.toString();
  // }
  //
  // File? book;
  //
  //
  // Future<void> pickFile() async {
  //   FilePickerResult? result =
  //       await FilePicker.platform.pickFiles();
  //   if(book != null){
  //     File file = File(book!.path);
  //     setState(() {
  //
  //     });
  //   }
  // }
}
