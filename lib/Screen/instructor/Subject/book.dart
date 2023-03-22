import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/Screen/instructor/Subject/Component/add_book.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Book extends StatefulWidget {
  Book({Key? key, this.id,this.type}) : super(key: key);
  String? id;
  String ?type;

  @override
  State<Book> createState() => _BookState();
}

class _BookState extends State<Book> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(AddBook(
            id: widget.id,
          ));
        },
        label: Text('Add book'),
        icon: Icon(Icons.add),
        heroTag: 3,
      ),
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.grey.shade300,
        automaticallyImplyLeading: true,
        title: Text("Book"),
      ),
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
          return ListView.builder(

            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,i){
              final sampleUrl =  snapshot.data!.docs[i]['item'];
              final numb = snapshot.data!.docs[i]['num'];
              print('nnnnnnnnnnnnnn');
              print(numb);

              String? pdfFlePath;

              Future<String> downloadAndSavePdf() async {
                final directory = await getApplicationDocumentsDirectory();
                final file = File('${directory.path}/sample.pdf');
                if (await file.exists()) {
                  return file.path;
                }
                final response = await http.get(Uri.parse(sampleUrl));
                await file.writeAsBytes(response.bodyBytes);
                return file.path;
              }

              void loadPdf() async {
                pdfFlePath = await downloadAndSavePdf();
                setState(() {});
              }
              return Column(

                children: <Widget>[
                  InkWell(
                    onTap: (){
                      Get.to(ViewBook(url: sampleUrl));
                    },
                      child: Text(numb,style: TextStyle(color: Colors.red),)),
                  // ElevatedButton(
                  //   child: Text("Load pdf"),
                  //   onPressed: loadPdf,
                  // ),
                  // if (pdfFlePath != null)
                  //   Expanded(
                  //     child: Container(
                  //       // child: PdfView(path: pdfFlePath!),
                  //     ),
                  //   )
                  // else
                  //   Text("Pdf is not Loaded"),
                ],
              );
            },
          );
        }
      ),

    );
  }

}
class ViewBook extends StatelessWidget {
  final url;
  ViewBook({required this.url});

  @override
  Widget build(BuildContext context) {
    PdfViewerController pdfViewerController = PdfViewerController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('PDF View'),
      ),
   body:SfPdfViewer.network(url,
   controller: pdfViewerController,) ,
    );
  }
}

