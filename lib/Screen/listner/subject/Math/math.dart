import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/Screen/instructor/Subject/add_topic.dart';
import 'package:education/Screen/instructor/Subject/topic_detail.dart';
import 'package:education/Screen/listner/subject/Math/component/addition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';



class Math extends StatefulWidget {
  Math({Key? key,this.title,this.id}) : super(key: key);
  String? title;
  String? id;

  @override
  State<Math> createState() => _MathState();
}

class _MathState extends State<Math> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text(widget.title!),
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),

          Expanded(
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Subjects').where('SubjectType',isEqualTo: widget.title)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData){
                        return Center(
                          child:CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, i) {
                          return Container(
                              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                              child: InkWell(
                                onTap: (){
                                  Get.to(Addition(id: snapshot.data!.docs[i].id,));
                                //  Get.to(()=>TopicDetail(id: snapshot.data!.docs[i].id,));
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(

                                    shape:BoxShape.rectangle,
                                    color: Color(0xFFF5F6F7),
                                    border: Border.all(color: Colors.grey.shade400,width: 0.8),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text(
                                      snapshot.data!.docs[i]['Category'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20, color: Colors.grey.shade800),
                                    ),
                                  ),
                                ),
                              )
                          );
                        },
                      );
                    }),
              ],
            ),
          ),

        ],
      ),
    );
  }

}
