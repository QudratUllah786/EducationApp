import 'package:education/Model/onbording.dart';
//import 'package:education/Screen/Sign_up_screen/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Sign_up_screen/auth_screen.dart';

class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({Key? key}) : super(key: key);

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  bool isChange = false;
  bool isLastPage=false;
  @override
  Widget build(BuildContext context) {

    final controller = PageController();
    @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }

    return Scaffold(
      //backgroundColor: Color(0xff141835),
      //Colors.blueGrey.shade800.withOpacity(0.7),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              //Color(0xff141835),

              Colors.black,
              Colors.purple.shade800,
              Colors.black,
              Colors.black,


            ]
          ),

        ),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  controller: controller,
                  onPageChanged: (index){
                    setState(() => isLastPage = index == 2);
                  },
                  itemCount: bording.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                              height: 300.h,
                              fit: BoxFit.cover,
                              image: AssetImage(bording[index].image.toString())),
                          SizedBox(
                            height: 30.h,
                          ),
                          Text(
                            bording[index].title.toString(),
                            style: TextStyle(
                                fontSize: 24.sp,
                                letterSpacing: 0.1,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            bording[index].subtitle.toString(),
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 150),
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: ExpandingDotsEffect(
                  strokeWidth: 8,
                  dotColor: Colors.grey,
                  activeDotColor: Colors.white,
                  radius: 8,
                  spacing: 10,
                  dotHeight: 10,
                  dotWidth: 10,
                ),
              ),
            ),

          ],
        ),
      ),

      bottomSheet:
      isLastPage?
      InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthScreen()));
        },
        child: Container(
          alignment: Alignment.center,

          height: 50,
          width: MediaQuery.of(context).size.width*1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
            shape: BoxShape.rectangle,
            color: Colors.white,
          ),
          child: Center(
            child: Text("Get Started",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w600),),
          ),
        ),
      )
          :
      Container(

        //margin: EdgeInsets.all(10),
       // padding: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.bottomLeft,
              colors: [
                //Color(0xff141835),

                Colors.black,
                Colors.black,


              ]
          ),
         // border: Border(top: BorderSide.none),
        ),

        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: (){
                  isChange = false;
                  controller.jumpToPage(2);
                  setState(() {

                  });

                },
                child: Container(
                  margin: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                      shape: BoxShape.rectangle,
                      color: isChange ==false ? Colors.white :Colors.transparent

                  ),
                  child: Text("Skip",style: TextStyle(fontSize: 16,color: isChange==false ?Colors.black: Colors.grey.shade100,fontWeight: FontWeight.w400),),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: (){
                  isChange = true;
                  controller.nextPage(duration: Duration(milliseconds: 3), curve: Curves.easeInOut);
                  setState(() {


                  });


                },
                child: Container(
                  margin: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      shape: BoxShape.rectangle,
                      color: isChange ==true ? Colors.white:Colors.transparent

                  ),
                  child: Text("Next",style: TextStyle(fontSize: 16,color:isChange==true?Colors.black: Colors.grey.shade100,fontWeight: FontWeight.w400),),
                ),
              ),
            ),
          ],
        ),

      ),

    );
  }
}
