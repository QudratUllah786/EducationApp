import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class ResultScreen extends StatefulWidget {
  final int correct,incorrect,total;
  const ResultScreen({required this.total,required this.correct,required this.incorrect});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black54),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        leading: IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.navigate_before)),
        title: RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: 'Quiz',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  )),
              TextSpan(
                  text: 'Maker',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  )),
            ])),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Score: ${widget.correct}/${widget.total}',style: TextStyle(
                fontSize: 18,fontWeight: FontWeight.w800
              ),),
              SizedBox(height: 5,),
              Text('Correct Answer: ${widget.correct} ',
                style: TextStyle(
                    fontSize: 16,fontWeight: FontWeight.w400
                ),

              ),
              SizedBox(height: 5,),
          Text('Incorrect Answer: ${widget.incorrect} ',
            style: TextStyle(
                fontSize: 16,fontWeight: FontWeight.w400
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }
}
