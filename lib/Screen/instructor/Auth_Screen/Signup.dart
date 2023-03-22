import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/Screen/instructor/Auth_Screen/Login.dart';
import 'package:education/Screen/instructor/HomePage/MainPage.dart';
import 'package:education/Screen/instructor/HomePage/homepage.dart';
import 'package:education/Screen/listner/Homepage/homepage.dart';
import 'package:education/Utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:random_string/random_string.dart';

class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String teacherId = randomAlphaNumeric(16);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text("Teacher Signup"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Name';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                    ),
                    prefixIconColor: Colors.black,
                    hintText: "Enter Name",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    fillColor: Colors.white10,
                    //Color(0xff141626).withOpacity(0.5),

                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                            style: BorderStyle.solid)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Email';
                    }
                    else if(!value.isEmail){
                      return 'Please Enter @ Format';
                    }
                    else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined,
                    ),
                    prefixIconColor: Colors.black,
                    hintText: "Enter Email",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    fillColor: Colors.white10,
                    //Color(0xff141626).withOpacity(0.5),

                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                            style: BorderStyle.solid)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Please Enter Passowrd';
                    }
                    else if(value.length<6){
                      return 'Please Enter at least 6 digits Password';
                    }
                    else{
                      return null;
                    }
                  },
                  controller: passwordController,
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_open_outlined,
                    ),
                    prefixIconColor: Colors.white,
                    hintText: "Enter password",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    fillColor: Colors.white10,
                    //Color(0xff141626).withOpacity(0.5),
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                            style: BorderStyle.solid)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        passwordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Please Enter Mobile No';
                    }
                    else if(value.length<6){
                      return 'Please Enter at least 11 digits No';
                    }
                    else{
                      return null;
                    }
                  },
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone,
                    ),
                    prefixIconColor: Colors.black,
                    hintText: "Enter Mobile No(e.g 03000000000)",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    fillColor: Colors.white10,
                    //Color(0xff141626).withOpacity(0.5),

                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                            style: BorderStyle.solid)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    if(_formKey.currentState!.validate())
                     setState(() {
                       isLoading = true;
                     });

                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim())
                          .then((value)  {
                        setState(() {
                          isLoading = false;
                        });
                        FirebaseFirestore.instance
                            .collection("Teacher")
                            .doc(value.user!.uid)
                            .set({
                          "Email": emailController.text,
                          "Name": nameController.text,
                          "Phone": phoneController.text,
                          "Role": "Teacher",
                        });
                        FirebaseAuth.instance.currentUser!.sendEmailVerification();
                        Get.defaultDialog(
                            title: 'Verification Email',
                            middleText: 'We have sent a verification mail to ${emailController.text}',
                            onConfirm: (){
                              Get.back();
                              Get.back();
                            },
                            textConfirm: 'Please check your Email First'
                        );

                        if(FirebaseAuth.instance.currentUser!.emailVerified){

                          Get.to(()=>const MainPage());
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
                  },

                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey.shade300,
                        border: Border.all(
                          color: Colors.black12,
                          width: 1,
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                       isLoading == true?
                       Center(
                         child: CircularProgressIndicator(
                           color: Colors.black,
                         ),
                       ):
                       Text(
                          "Sign up",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                        onPressed: () {
                          Get.to(Login());
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
