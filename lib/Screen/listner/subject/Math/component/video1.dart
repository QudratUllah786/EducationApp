import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/Screen/instructor/Subject/Component/add_video.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Video1 extends StatefulWidget {
  Video1({Key? key, this.id,this.type}) : super(key: key);
  String? id;
  String? type;

  @override
  State<Video1> createState() => _Video1State();
}

class _Video1State extends State<Video1> {
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
                      child: YoutubePlayer(
                        controller: YoutubePlayerController(
                          initialVideoId: videoID.toString(),
                          flags: YoutubePlayerFlags(
                            autoPlay: false,
                            mute: false,
                          ),
                        ),
                        showVideoProgressIndicator: true,
                      ),
                    );
                    //  Text(snapshot.data!.docs[i]['type']);
                  });
            }));
  }
}
