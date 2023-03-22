
import 'package:flutter/material.dart';

import 'component/components/body.dart';



class ProfileInstructor extends StatelessWidget {
  //static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(""),
        centerTitle: true,
      ),
      body: Body1(),
    );
  }
}
