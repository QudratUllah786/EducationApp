import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/Widget/Custom_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../instructor/Subject/subject_topic_screen.dart';
import '../subject/Math/math.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  backgroundColor: Colors.grey.shade100,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: Stack(
            children: [
              Container(
                height: 120.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(5)),
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xff141835), Colors.purple.shade500,Colors.lightBlueAccent.shade200]),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // IconButton(
                    //     onPressed: () {},
                    //     icon: Icon(
                    //       Icons.menu,
                    //       size: 30,
                    //       color: Colors.white,
                    //     )),
                    Center(
                      child: Text(
                        "E-Learning",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ),
                    // IconButton(
                    //     onPressed: () {},
                    //     icon: Icon(
                    //       Icons.search,
                    //       size: 30,
                    //       color: Colors.white,
                    //     )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 110, left: 20, right: 20),
                child: Image(
                    height: 150, image: AssetImage('assets/education.jpeg')),
              ),
            ],
          )),

          Padding(
            padding: EdgeInsets.only(left: 20,top: 10),
              child: Text("Categories",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 18),)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Categories')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if(!snapshot.hasData){
                      return Center(
                        child:CircularProgressIndicator(),
                      );
                    }
                    return GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.9,
                          mainAxisExtent: 150,
                          crossAxisSpacing: 10),
                      itemBuilder: (context, i) {
                        return InkWell(

                            onTap: () {
                              Get.to(() => Math(
                                id: snapshot.data!.docs[i].id,
                                title: snapshot.data!.docs[i]['CategoryType'],
                              ));
                            },
                            child: Container(

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Center(
                                    child: Text(
                                      snapshot.data!.docs[i]['CategoryType'],

                                      style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),
                                    ),

                                  ),
                                  Text('Created by ${snapshot.data!.docs[i]['Instructor']}',style: TextStyle(fontSize: 10),)
                                ],
                              ),
                            ));
                      },
                    );
                  }),
            ),
          ),



          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 20,right: 20),
          //     child: GridView(
          //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //           crossAxisCount: 2,
          //           crossAxisSpacing: 10,
          //           mainAxisExtent: 150,
          //           childAspectRatio: 0.5,
          //           mainAxisSpacing: 10,
          //         ),
          //         children: [
          //           CustomGrid(image: "assets/grid/math.png", text: "Math",press: (){Get.to(const Math());},),
          //           CustomGrid(image: "assets/grid/english.png", text: "English",press: (){Get.to(const English());}),
          //           CustomGrid(image: "assets/grid/computer.png", text: "Computer",press: (){Get.to(const Computer());}),
          //           CustomGrid(image: "assets/grid/science.png", text: "Science",press: (){Get.to(const Science());}),
          //           CustomGrid(image: "assets/grid/art.png", text: "Drawing",press: (){Get.to(const Drawing());}),
          //           CustomGrid(image: "assets/grid/iq.png", text: "IQ",press: (){Get.to(const Iq());}),
          //
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

// GridView.builder(
// shrinkWrap: true,
// scrollDirection: Axis.vertical,
// physics: BouncingScrollPhysics(),
// // itemCount: laps.length,
// itemCount: 6,
// gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 2,
// crossAxisSpacing: 1,
// mainAxisExtent: 150,
// childAspectRatio: 0.2,
// ),
// itemBuilder: (context, index) {
// return Padding(
// padding: const EdgeInsets.all(10.0),
// child: Container(
// height: 150.h,
// width: 80.w,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(10),
// gradient: LinearGradient(
// begin: Alignment.topCenter,
// end: Alignment.bottomCenter,
// colors: [
// // Colors.black12,
// Color(0xFFF5F6F9),
// Colors.grey.shade200,
//
// ],
// ),
// border: Border.all(color: Colors.grey,width: 0.1)
// ),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// ImageIcon(
// AssetImage(grid[index].image.toString()),
// color: Colors.black,
// size: 54,
// ),
// Text(grid[index].text.toString(),style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),)
// ],
// ),
//
// ),
// );
// }),