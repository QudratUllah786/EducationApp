import 'package:education/Screen/instructor/HomePage/homepage.dart';
import 'package:education/Screen/listner/Homepage/homepage.dart';
import 'package:education/Utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../HomePage/MainPage.dart';
import 'Signup.dart';
import 'forget_password.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text("Teacher Login"),
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Email';
                    } else {
                      return null;
                    }
                  },
                  controller: emailController,
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Passowrd';
                    } else if (value.length < 6) {
                      return 'Please Enter at least 6 digits Password';
                    } else {
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
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
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
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });

                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim())
                          .then(
                            (value) => setState(() {
                              isLoading = false;
                              if (FirebaseAuth
                                  .instance.currentUser!.emailVerified) {
                                Get.to(() => const MainPage());
                              } else {
                                Get.defaultDialog(
                                    title: 'Email Verification',
                                    middleText: 'Email is not verified');
                              }
                            }),
                          )
                          .onError((error, stackTrace) {
                        setState(() {
                          isLoading = false;
                        });
                        Get.defaultDialog(
                          backgroundColor: Colors.grey.shade700,
                            onConfirm: () {
                              Get.back();
                            },
                            title: 'Error',
                            titleStyle: TextStyle(
                              color: Colors.white,
                            ),
                            middleText: error.toString(),
                            middleTextStyle: TextStyle(
                              color: Colors.white
                            ),
                            textConfirm: 'OK');
                      });
                    }
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
                        isLoading == true
                            ? Center(
                                child: CircularProgressIndicator(
                                color: Colors.black,
                              ))
                            : Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                      ],
                    ),
                  ),
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
                          style: TextStyle(color: Colors.black87),
                        )),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                        onPressed: () {
                          Get.to(Signup());
                        },
                        child: Text(
                          'sign up',
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
