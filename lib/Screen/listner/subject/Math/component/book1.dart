import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Book1 extends StatefulWidget {
  Book1({Key? key, this.id,this.type}) : super(key: key);
  String? id;
  String ?type;

  @override
  State<Book1> createState() => _Book1State();
}

class _Book1State extends State<Book1> {
  // final sampleUrl =  snapshot.data!.docs[i]['item'];
  //
  // String? pdfFlePath;
  //
  // Future<String> downloadAndSavePdf() async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final file = File('${directory.path}/sample.pdf');
  //   if (await file.exists()) {
  //     return file.path;
  //   }
  //   final response = await http.get(Uri.parse(sampleUrl));
  //   await file.writeAsBytes(response.bodyBytes);
  //   return file.path;
  // }
  //
  // void loadPdf() async {
  //   pdfFlePath = await downloadAndSavePdf();
  //   setState(() {});
  // }
  // getVi() async {
  //   var da = await FirebaseFirestore.instance
  //       .collection('Subjects')
  //       .doc(widget.id)
  //       .collection('Data')
  //       .doc()
  //       .get()
  //       .then((value) {
  //     print('###################################');
  //     print(value.get('Item'));
  //   });
  //   // print('###################################');
  //   // print(da);
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body:  StreamBuilder<QuerySnapshot>(
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
           if(snapshot.hasError){
             return Center(
               child: CircularProgressIndicator(),
             );
           }
           if(!snapshot.hasData){
             return Center(
               child: CircularProgressIndicator(),
             );
           }
            return ListView.builder(

              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,i){
                final sampleUrl =  snapshot.data!.docs[i]['item'];
                final numb = snapshot.data!.docs[i]['num'];
                //final sampleUrl =  snapshot.data!.docs[i]['item'];

                // String? pdfFlePath;

                //
                // Future<String> downloadAndSavePdf() async {
                //   final directory = await getApplicationDocumentsDirectory();
                //   final file = File('${directory.path}/sample.pdf');
                //   if (await file.exists()) {
                //     return file.path;
                //   }
                //   final response = await http.get(Uri.parse(sampleUrl));
                //   await file.writeAsBytes(response.bodyBytes);
                //   return file.path;
                // }

              /*  void loadPdf() async {
                  pdfFlePath = await downloadAndSavePdf();
                  setState(() {});
                }*/
                return Column(

                  children: <Widget>[
                    ElevatedButton(
                      child: Text("Load pdf"),
                     onPressed: (){},
                     // onPressed: loadPdf,
                    ),
                      Expanded(
                        child: Container(
                          //child:
                          //SfPdfViewer.network('https://www.k5learning.com/worksheets/reading-comprehension/level-d-childrens-story.pdf'),
                          //  child: PdfView(path: sampleUrl!),
                          child: Text(numb),
                        ),
                      )
                  ],
                );
              },
            );
          }
      ),

    );
  }
}
