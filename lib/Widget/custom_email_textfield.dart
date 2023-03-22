import 'package:flutter/material.dart';

class CustomEmailTextfield extends StatelessWidget {
  String? hinttext;
  final icon;


  CustomEmailTextfield({Key? key, this.icon, required this.hinttext,required this.emailcontroller})
      : super(key: key);
  TextEditingController emailcontroller;

  @override

  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value){
        if(value!.isEmpty){
          return 'Please Enter Email';
        }
        else{
          return null;
        }
      },
      controller: emailcontroller,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
        ),
        prefixIconColor: Colors.white10,
        hintText: hinttext,
        hintStyle: TextStyle(color: Colors.white10),
        fillColor: Colors.white10,
        //Color(0xff141626).withOpacity(0.5),

        filled: true,
        border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black, width: 1, style: BorderStyle.solid)),
      ),
    );
  }
}
