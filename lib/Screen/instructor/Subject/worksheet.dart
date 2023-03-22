import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/Screen/instructor/Subject/Component/add_video.dart';
import 'package:education/Screen/instructor/Subject/Component/add_worksheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:photo_view/photo_view.dart';

class WorkSheet extends StatefulWidget {
  WorkSheet({Key? key, this.id, this.type}) : super(key: key);
  String? id;
  String? type;

  @override
  State<WorkSheet> createState() => _WorkSheetState();
}

class _WorkSheetState extends State<WorkSheet> {
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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(AddWorksheet(
              id: widget.id,
            ));
          },
          label: Text('Add worksheet'),
          icon: Icon(Icons.add),
          heroTag: 2,
        ),
        appBar: AppBar(
          centerTitle: true,
          elevation: 1,
          backgroundColor: Colors.grey.shade300,
          automaticallyImplyLeading: true,
          title: Text("WorkSheet"),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Subjects')
                .doc(widget.id)
                .collection('Data')
                .where('type', isEqualTo: widget.type)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.grey.shade300,
                        child: Column(
                          children: [
                            Container(
                              height: 350,
                              width: double.infinity,
                              color: Colors.transparent,
                              child: PhotoView(
                                  //customSize: Size.fromHeight(300),

                                  imageProvider: NetworkImage(
                                      snapshot.data!.docs[i]['item'])),
                            ),
                            TextButton(onPressed: ()async{
                              final id = snapshot.data!.docs[i].id;
                              await FirebaseFirestore.instance.collection(
                                  "Subjects").doc(widget.id).collection("Data").doc(id).delete();
                            }, child: Text("Delete",style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.w600),)),
                          ],
                        ),
                      ),
                    );
                  });
            }));
  }
}
