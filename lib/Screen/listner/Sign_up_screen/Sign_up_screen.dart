import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/Screen/listner/Sign_up_screen/login_screen.dart';
import 'package:education/Utils/utils.dart';
import 'package:education/Widget/custom_botton.dart';
import 'package:education/Widget/custom_email_textfield.dart';
import 'package:education/Widget/custom_password_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/get_utils.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key,}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              //Color(0xff141835),
              Colors.purple.shade800,
              Colors.black,
              Colors.black,
            ]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          brightness: Brightness.dark,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leadingWidth: 100,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.blue.shade900,
                ),
                Text(
                  "Back",
                  style: TextStyle(color: Colors.blue.shade900),
                )
              ],
            ),
          ),
          title: Text("Sign up"),
          titleTextStyle: TextStyle(fontSize: 17.sp),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(
                  //   "Sign up with",
                  //   style: TextStyle(color: Colors.white, fontSize: 14),
                  // ),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  // SizedBox(
                  //     width: double.infinity,
                  //     height: 50,
                  //     child: SignInButton(
                  //       Buttons.Google,
                  //       onPressed: () {},
                  //     )),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  // SizedBox(
                  //   width: double.infinity,
                  //   height: 50,
                  //   child: SignInButton(
                  //     Buttons.Facebook,
                  //     onPressed: () {},
                  //   ),
                  // ),
                  //
                  //
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 40),
                  //   child: Center(
                  //       child: Text(
                  //         "or",
                  //         style: TextStyle(color: Colors.grey),
                  //       )),
                  // ),
                  Text(
                    "Creating account by using email",
                    style: TextStyle(color: Colors.grey.shade300),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Your Name",
                    style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomEmailTextfield(
                    emailcontroller: namecontroller,

                    icon: Icons.person,
                    hinttext: "Name",
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Your Email",
                    style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),

                  CustomEmailTextfield(
                    emailcontroller: emailcontroller,

                    icon: Icons.email_outlined,
                    hinttext: "example@istudy.com",
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Your Password",
                    style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomPasswordTextfield(
                    passwordcontroller: passwordcontroller,
                    hinttext: "password",
                    icon: Icons.lock_open_outlined,
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      TextButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (
                            context) => LoginScreen()));
                      },
                          child: Text(
                            'Login', style: TextStyle(color: Colors.white),))
                    ],
                  ),

                  SizedBox(
                    height: 90.h,
                  ),
                  isLoading == true
                      ? Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,

                        border: Border.all(
                          color: Colors.black12,
                          width: 1,
                        )
                    ),
                    child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        )),
                  )
                      : CustomButton(
                    ontap: () async{

                      if(_formKey.currentState!.validate())
                        setState(() {
                          isLoading = true;
                        });


                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailcontroller.text.trim(),
                          password: passwordcontroller.text.trim())
                          .then((value)
                      {
                        setState(() {
                          isLoading = false;
                        });
                        FirebaseFirestore.instance.collection("student").doc(value.user!.uid).set({
                          "Email": emailcontroller.text,
                          "Name": namecontroller.text,
                          "Role": "student",
                        });
                        FirebaseAuth.instance.currentUser!.sendEmailVerification();
                        Get.defaultDialog(
                            title: 'Verification Email',
                            middleText: 'We have sent a verification mail to ${emailcontroller.text}',
                            onConfirm: (){
                              Get.back();
                              Get.back();
                            },
                            textConfirm: 'Please check your Email First'
                        );
                        if(FirebaseAuth.instance.currentUser!.emailVerified){

                          Get.to(LoginScreen());
                        }
                        else{
                          Get.defaultDialog(
                              title: 'Email Verification',
                              middleText: 'Email is not verified'
                          );
                        }

                      }
                      ).onError((error, stackTrace){
                        setState((){
                          isLoading = false;
                        });
                        Get.defaultDialog(
                            onConfirm: () {
                              Get.back();
                            },
                            title:'Error',
                            middleText: error.toString(),
                            textConfirm: 'OK'


                        );
                      });





                      // .onError((error, stackTrace){
                      //
                      //     Utils().toastMessage(error.toString());
                      //     setState(() {
                      //       isLoading=false;
                      //     });
                      //   });
                    },
                    text: "Sign up",
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
