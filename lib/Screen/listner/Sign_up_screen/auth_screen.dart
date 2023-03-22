import 'package:education/Widget/custom_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../instructor/Auth_Screen/Login.dart';
import 'Sign_up_screen.dart';
import 'login_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                //Color(0xff141835),
                Colors.purple.shade800.withOpacity(1),
                Colors.black,Colors.black]),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Let's Start!",
                    style: TextStyle(
                        fontSize: 28,
                        letterSpacing: 0.7,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "Select one below given",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ),
                ],
              ),
              Image(image: AssetImage('assets/onbording/saly-4.png')),
              Column(
                children: [
                  CustomButton(
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    color: Colors.white,
                    text: "Student Login",
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomButton(
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Login()));
                    },
                    color: Colors.white,
                    text: "Teacher Login",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
