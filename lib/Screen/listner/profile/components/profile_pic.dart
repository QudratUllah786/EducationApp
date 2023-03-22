import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../../Controllers/profile_pic_controller.dart';

class ProfilePic extends StatefulWidget {
   ProfilePic({
     Key ?key,
  }) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
   StudentProfileController controller = Get.put(StudentProfileController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [



           Obx(()=>
             CircleAvatar(
                backgroundImage:
                controller.imageUrl.isNotEmpty?
                FileImage(File(controller.imageUrl.toString()))
                    :null
            ),
           ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white),
                  ),
                  primary: Colors.grey.shade500,
                  backgroundColor: Color(0xFFFFFFFF),
                ),
                onPressed: () {},
                child: IconButton(onPressed: (){controller.uploadImg();}, icon: Icon(CupertinoIcons.camera,color: Colors.black,))
              ),
            ),
          )
        ],
      ),
    );
  }

  File? file;

  ImagePicker pick = ImagePicker();

  Future pickImage() async {
    final pickFile = await pick.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickFile != null) {
       
        setState(() {
          file = File(pickFile.path);   
        });
      } else {
        Get.snackbar("Hey", "Image Not Selected", colorText: Colors.black);
      }
    });
  }
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
}
