import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String ? text;
  final color;
  final icon;
  final ontap;
   CustomButton({Key? key, this.color,this.text ,this.icon,required this.ontap }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: color,

          border: Border.all(
            color: Colors.black12,
            width: 1,
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text(text!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black),),
            Icon(icon),
          ],
        ),
      ),
    );
  }
}
