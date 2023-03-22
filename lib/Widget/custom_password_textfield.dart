import 'package:flutter/material.dart';

class CustomPasswordTextfield extends StatefulWidget {
  String? hinttext;
  final icon;


  CustomPasswordTextfield({Key? key, this.icon, required this.hinttext,required this.passwordcontroller})
      : super(key: key);
  TextEditingController passwordcontroller;

  @override
  State<CustomPasswordTextfield> createState() => _CustomPasswordTextfieldState();

}

class _CustomPasswordTextfieldState extends State<CustomPasswordTextfield> {
  bool passwordVisible= false;





  @override
  Widget build(BuildContext context) {


    return TextFormField(
      validator: (value){
        if(value!.isEmpty){
          return 'Please Enter Passowrd';
        }
        else if(value.length<6){
          return 'Please Enter at least 6 digits Password';
        }
        else{
          return null;
        }
      },
      controller: widget.passwordcontroller,
      obscureText: !passwordVisible,
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.icon,
        ),
        prefixIconColor: Colors.white,
        hintText: widget.hinttext,
        hintStyle: TextStyle(color: Colors.white10),
        fillColor: Colors.white10,
        //Color(0xff141626).withOpacity(0.5),
        filled: true,
        border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black, width: 1, style: BorderStyle.solid)),
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            passwordVisible
                ? Icons.visibility
                : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              passwordVisible = !passwordVisible;
            });
          },
        ),
      ),

    );
  }
}
