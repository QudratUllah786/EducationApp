import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/Screen/instructor/Subject/Component/add_video.dart';
import 'package:education/Screen/instructor/Subject/Component/add_worksheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:photo_view/photo_view.dart';

class WorkSheet1 extends StatefulWidget {
  WorkSheet1({Key? key, this.id,this.type}) : super(key: key);
  String? id;
  String? type;

  @override
  State<WorkSheet1> createState() => _WorkSheet1State();
}

class _WorkSheet1State extends State<WorkSheet1> {
  getVi() async {
    var da = await FirebaseFirestore.instance
        .collection('Subjects')
        .doc(widget.id)
        .collection('Data')
        .doc()
        .get()
        .then((value) {
      print('###################################');
      print(value.get('Item'));
    });
    // print('###################################');
    // print(da);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(


        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Subjects')
                .doc(widget.id)
                .collection('Data').where('type', isEqualTo: widget.type)
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
                  itemBuilder: (context,i){

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 300,
                        width: double.infinity,
                        color: Colors.transparent,
                        child: PhotoView(
                          //customSize: Size.fromHeight(300),

                            imageProvider: NetworkImage(

                                snapshot.data!.docs[i]['item']
                            )),
                      ),
                    );
                  });
            }));
  }
}
