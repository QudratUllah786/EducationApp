import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/Screen/instructor/Subject/Component/add_video.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Video extends StatefulWidget {
  Video({Key? key, this.id,this.type}) : super(key: key);
  String? id;
  String? type;

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  // final videoURL = snapshot.data!.docs[i]['item'];
  late YoutubePlayerController _controller;

  @override
  void initState() {
    // final videoID = YoutubePlayer.convertUrlToId(snapshot.data!.docs[i]['item'])
    super.initState();
  }

  getVi() async {
    var da = await FirebaseFirestore.instance
        .collection('Subjects')
        .doc(widget.id)
        .collection('Data')
        .doc()
        .get()
        .then((value) {
      print('###################################');
      print(value.get('item'));
    });
    // print('###################################');
    // print(da);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(AddVideo(
              id: widget.id,
            ));
          },
          label: Text('Add Video'),
          icon: Icon(Icons.add),
          heroTag: 1,
        ),
        appBar: AppBar(
          centerTitle: true,
          elevation: 1,
          backgroundColor: Colors.grey.shade300,
          automaticallyImplyLeading: true,
          title: Text("Video"),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Subjects')
                .doc(widget.id)
                .collection('Data').where('type',isEqualTo: widget.type)
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
                    final VideoURL = snapshot.data!.docs[i]['item'];
                    final videoID = YoutubePlayer.convertUrlToId(VideoURL);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.grey.shade300,
                        child: Column(
                          children: [

                            YoutubePlayer(
                              controller: YoutubePlayerController(
                                initialVideoId: videoID.toString(),
                                flags: YoutubePlayerFlags(
                                  autoPlay: false,
                                  mute: false,
                                ),
                              ),
                              showVideoProgressIndicator: true,
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
                    //  Text(snapshot.data!.docs[i]['type']);
                  });
            }));
  }
}
