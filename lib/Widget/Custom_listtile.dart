import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomListTile extends StatelessWidget {
  String ? text;

   CustomListTile({Key? key,required this.text, this.press}) : super(key: key);
  final VoidCallback ? press;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 40,right: 40,top: 10),
      child: Container(

        decoration: BoxDecoration(

          shape:BoxShape.rectangle,
          color: Color(0xFFF5F6F7),
          border: Border.all(color: Colors.grey.shade400,width: 0.5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          title: Text(text!,style: TextStyle(fontSize: 19.r,fontWeight: FontWeight.w500,color: Colors.grey.shade600),textAlign: TextAlign.center),
          onTap: press,

        ),
      ),
    );
  }
}
