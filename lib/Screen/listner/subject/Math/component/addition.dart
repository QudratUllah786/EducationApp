import 'package:education/Screen/instructor/Subject/video.dart';
import 'package:education/Screen/instructor/Subject/worksheet.dart';
import 'package:education/Screen/listner/subject/Math/component/book1.dart';
import 'package:education/Screen/listner/subject/Math/component/video1.dart';
import 'package:education/Screen/listner/subject/Math/component/worksheet1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Addition extends StatefulWidget {
   Addition({Key? key,this.id}) : super(key: key);
  String ?id;

  @override
  State<Addition> createState() => _AdditionState();
}

class _AdditionState extends State<Addition> with TickerProviderStateMixin {

  @override

  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3 , vsync: this);
    return Scaffold(

      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   title: Text("Addition"),
      //   leading: IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back_ios)),
      //     shape: Border(
      //         bottom: BorderSide(color: Colors.grey.shade300, width: 0.5)),
      //
      // ),
      body: Column(

        children: [
          SizedBox(height: 40,),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300,width: 1)
              )
            ),
            child:    TabBar(
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 2.0),
                    insets: EdgeInsets.symmetric(horizontal:20.0)
                ),
                controller:tabController,
                isScrollable: true,
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                labelStyle: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),
                physics: NeverScrollableScrollPhysics(),

                unselectedLabelStyle: TextStyle(color: Colors.grey.shade300),
                padding: EdgeInsets.symmetric(horizontal: 60),

                tabs: [
                  Tab(child: Text('Video',style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('Worksheet',style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('Book',style: TextStyle(color: Colors.black),),),

                ]),
          ),
          Expanded(child: TabBarView(

            controller: tabController,
            children: [
             Video1(id: widget.id,type:'Video'),
             WorkSheet1(id: widget.id,type:'Photo'),
              Book1(id: widget.id,type: "PdfFileUrl",)

            ],

          ))
        ],
      ),

    );
  }
}
