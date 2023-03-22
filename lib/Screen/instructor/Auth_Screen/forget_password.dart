import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Utils/utils.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text("Forget Password"),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 10,
            top: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                  ),
                  prefixIconColor: Colors.black,
                  hintText: "Enter Email",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  fillColor: Colors.white10,
                  //Color(0xff141626).withOpacity(0.5),

                  filled: true,
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                          style: BorderStyle.solid)),
                ),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: () {
                 FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text).then((value) {
                   Utils().toastMessage('We have sent you email to recover Password');

                 }).onError((error, stackTrace) {
                   Utils().toastMessage(error.toString());
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
                      Text(
                        "Get Password",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
