import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGrid extends StatelessWidget {
  String ? image;
  String ? text;
   CustomGrid({Key? key, required this.image,required this.text ,required this.press}) : super(key: key);
   final VoidCallback ? press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        height: 150.h,
        width: 80.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                // Colors.black12,
                Color(0xFFF5F6F9),
                Colors.grey.shade200,

              ],
            ),
            border: Border.all(color: Colors.grey,width: 0.1)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ImageIcon(
              AssetImage(image!),
              color: Colors.black,
              size: 54,
            ),
            Text(text!,style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),)
          ],
        ),

      ),
    );
  }
}
