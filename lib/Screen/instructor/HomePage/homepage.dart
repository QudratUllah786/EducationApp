import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Widget/Custom_grid.dart';

import '../../listner/subject/Math/math.dart';

import '../Subject/subject_topic_screen.dart';
import 'component/add_subject.dart';

class HomePageTeacher extends StatefulWidget {
  HomePageTeacher({Key? key, this.id, this.title,this.user}) : super(key: key);
  String? title;
  String? id;
  String? user;

  @override
  State<HomePageTeacher> createState() => _HomePageTeacherState();
}

class _HomePageTeacherState extends State<HomePageTeacher> {
  @override
  void initState() {
    print('%%%%%%%%%%%%%%%%%%%');
    print(FirebaseAuth.instance.currentUser!.uid);
    super.initState();
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(AddSubject());
        },
        label: Text("Add Subject"),
        icon: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("HomePage"),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Categories').where('CurrentId',isEqualTo:FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {

                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return GridView.builder(

                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.9,
                          crossAxisSpacing: 10),
                      itemBuilder: (context, i) {
                        print('############');
                        print(snapshot.data!.docs[i]['CurrentId']);
                        return InkWell(

                            onTap: () {
                              Get.to(() =>
                                  Math1(
                                    id: snapshot.data!.docs[i].id,
                                    title: snapshot.data!.docs[i]['CategoryType'],
                                  ));
                            },
                            child: Container(
                              height: 150.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      // Colors.black12,
                                      Color(0xFFF5F6F9),
                                      Colors.grey.shade200,
                                    ],
                                  ),
                                  border:
                                  Border.all(color: Colors.grey, width: 0.1)),
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom:0,
                                    right: 0,
                                    child: IconButton(onPressed: () async{
                                      final id = snapshot.data!.docs[i].id;
                                      await FirebaseFirestore.instance.collection(
                                          "Categories").doc(id).delete();
                                    },
                                        icon: Icon(Icons.delete,
                                          color: Colors.red.shade600,)),
                                  ),
                                  Positioned(
                                    bottom:0,
                                    left: 0,
                                    child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                                      stream: FirebaseFirestore
                                          .instance
                                          .collection('Teacher')
                                          .doc(FirebaseAuth.instance.currentUser!.uid) // 👈 Your document id which is equal to currentuser
                                          .snapshots(),
                                      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                                        return Text('Created By: ${data['Name']}',style: TextStyle(
                                          fontSize: 10,
                                          overflow: TextOverflow.ellipsis
                                        ),);
                                      }
                                    ),
                                  ),

                                  Center(
                                    child: Text(
                                      snapshot.data!.docs[i]['CategoryType'],
                                      style:
                                      TextStyle(fontSize: 20,
                                          color: Colors.grey.shade700),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      },
                    );
                  }),
            ),
          ),

        ],
      ),
    );
  }
}
