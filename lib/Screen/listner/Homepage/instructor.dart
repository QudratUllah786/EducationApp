

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class Instructor extends StatefulWidget {
  const Instructor({Key? key}) : super(key: key);

  @override
  State<Instructor> createState() => _InstructorState();
}

class _InstructorState extends State<Instructor> {
  makingPhoneCall(String phone)async{
    var url = Uri.parse('tel:$phone');
    if(await canLaunchUrl(url)){
      await launchUrl(url);
    }
    else{
      throw 'Could not launch $url';
    }
  }
  launchWhatsapp() async {
    var whatsapp = "+923484322251";
    var url =  Uri.parse('whatsapp://send?phone=$whatsapp&text=Hi Sir');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40.h,),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Teacher').snapshots(),
            builder: (context, snapshot) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,index){
                  if(snapshot.hasError){
                    return Center(child: CircularProgressIndicator());
                  }
                   if(!snapshot.hasData){
                     return Center(child: CircularProgressIndicator());
                  }
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                    decoration: BoxDecoration(

                      shape:BoxShape.rectangle,
                      color: Color(0xFFF5F6F9),
                      border: Border.all(color: Colors.grey,width: 0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      // leading: CircleAvatar(
                      //   radius: 30,
                      //   backgroundImage: AssetImage("assets/profile/profile.png"),
                      // ),
                      title: Text(
                           'Teacher ${snapshot.data!.docs[index]['Name']}',style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500),),
                      trailing:
                      IconButton(onPressed: (){makingPhoneCall(snapshot.data!.docs[index]['Phone']);}, icon: Icon(Icons.call)),
                      //  IconButton(onPressed: (){launchWhatsapp();}, icon: Icon(Icons.whatsapp)),

                    ),
                  );
                }

              );
            }
          ),
          SizedBox(height: 5,),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Container(
          //     decoration: BoxDecoration(
          //
          //       shape:BoxShape.rectangle,
          //       color: Color(0xFFF5F6F9),
          //       border: Border.all(color: Colors.grey,width: 0.1),
          //       borderRadius: BorderRadius.circular(15),
          //     ),
          //     child: ListTile(
          //       leading: CircleAvatar(
          //         radius: 30,
          //         backgroundImage: AssetImage("assets/profile/profile.png"),
          //       ),
          //       title: Text("Qudrat Ullah",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500),),
          //       subtitle: Text("English Teacher",style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w300),),
          //       trailing: IconButton(onPressed: (){
          //         launchWhatsapp();
          //
          //       }, icon: Icon(Icons.whatsapp,color: Colors.green,)),
          //     ),
          //   ),
          // ),

        ],
      ),
    );
  }
}
