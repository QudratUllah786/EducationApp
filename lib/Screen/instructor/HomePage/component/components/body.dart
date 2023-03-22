//import 'package:education/Screen/profile/components/settingpageview/setting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/Screen/instructor/Auth_Screen/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body1 extends StatefulWidget {
  @override
  State<Body1> createState() => _Body1State();
}

class _Body1State extends State<Body1> {
  @override
  Widget build(BuildContext context) {

    return  StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream:  FirebaseFirestore
          .instance
          .collection('Teacher')
          .doc(FirebaseAuth.instance.currentUser!.uid) // 👈 Your document id which is equal to currentuser
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        if(!snapshot.hasData){
          print(snapshot.data!.id);
          return CircularProgressIndicator();
        }
        Map<String, dynamic> data =
        snapshot.data!.data() as Map<String, dynamic>;
         return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  CircleAvatar(radius: 50,),
                  // ProfilePic(),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        padding: EdgeInsets.all(20),
                        shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        backgroundColor: Color(0xFFF5F6F9),
                      ),
                      onPressed: (){},
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.person),
                          SizedBox(width: 20),
                          Expanded(child: Text("Teacher ${data['Name']}")),
                          //Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        padding: EdgeInsets.all(20),
                        shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        backgroundColor: Color(0xFFF5F6F9),
                      ),
                      onPressed: (){},
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.mail),
                          SizedBox(width: 20),
                          Expanded(child: Text(data['Email'])),
                          //Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        padding: EdgeInsets.all(20),
                        shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        backgroundColor: Color(0xFFF5F6F9),
                      ),
                      onPressed: (){},
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.phone),
                          SizedBox(width: 20),
                          Expanded(child: Text(data['Phone'])),
                          //Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                  // ProfileMenu(
                  //   text: "Student",
                  //
                  // )



                  ProfileMenu(
                    text: "Log Out",
                    icon: "assets/icons/Log out.svg",
                    press: () {
                      FirebaseAuth.instance.signOut();
                      Get.offAll(Login());


                    },
                  ),

                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('student').snapshots(),
                    builder: (context, snapshot) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context,i){
                        return Text(snapshot.data!.docs[i]['Name']);
                      });
                    }
                  )
                ],
              ),
            ); // 👈 your valid data here
      },
    );
  }
}
