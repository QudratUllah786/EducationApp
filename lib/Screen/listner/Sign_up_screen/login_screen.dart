import 'package:education/Screen/listner/Sign_up_screen/Sign_up_screen.dart';
import 'package:education/Utils/utils.dart';
import 'package:education/Widget/custom_botton.dart';
import 'package:education/Widget/custom_email_textfield.dart';
import 'package:education/Widget/custom_password_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../instructor/Auth_Screen/forget_password.dart';
import '../Homepage/homepage.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();

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
          title: Text("Log in"),
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
                  //  Image(image: AssetImage('assets/onbording/saly-4.png')),
                  // Text(
                  //   "Log in with",
                  //   style: TextStyle(color: Colors.white, fontSize: 14),
                  // ),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  // SizedBox(
                  //     width: double.infinity,
                  //     height: 50,
                  //     child: SignInButton(
                  //       text: "Log in with Google",
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
                  //     text: "Log in with Facebook",
                  //     Buttons.Facebook,
                  //     onPressed: () {},
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 40),
                  //   child: Center(
                  //       child: Text(
                  //     "or",
                  //     style: TextStyle(color: Colors.grey),
                  //   )),
                  // ),
                  Text(
                    "Login by using email",
                    style: TextStyle(color: Colors.grey.shade300),
                  ),
                  SizedBox(
                    height: 20.h,
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
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          },
                          child: Text(
                            'sign up',
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),

                  SizedBox(
                    height: 50.h,
                  ),
                  isLoading == true
                      ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(

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
                    ),
                  )
                      : CustomButton(
                    ontap: () {
                      if(_formKey.currentState!.validate()){
                        setState(() {
                          isLoading = true;
                        });


                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: emailcontroller.text.trim(),
                          password: passwordcontroller.text.trim(),
                        )
                            .then((value) {

                          setState(() {
                            isLoading = false;
                          });
                          if(FirebaseAuth.instance.currentUser!.emailVerified){
                            Get.to(()=>const HomePage());
                          }
                          else{
                            Get.defaultDialog(
                                title: 'Email Verification',
                                middleText: 'Email is not verified'
                            );
                          }
                        }).onError((error, stackTrace){
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
                      }

                    },
                    text: "Login",
                    color: Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          onPressed: () {
                            Get.to(() => const ForgotPassword());
                          },
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
