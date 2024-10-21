import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/back_arrow_widget.dart';
import 'package:pmc/src/Views/Widget/button_widget.dart';
import 'package:pmc/src/Views/Widget/checkbox_widget.dart';
import 'package:pmc/src/Views/Widget/onboard_text.dart';

class CourseContentType extends StatefulWidget {
  const CourseContentType({super.key});

  @override
  State<CourseContentType> createState() => _CourseContentTypeState();
}

class _CourseContentTypeState extends State<CourseContentType> {
   bool ischeck = false;
   bool ischecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
         margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 22,left: 4,right: 4,),
            padding:const EdgeInsets.all(8),
            decoration:const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.background1),
                fit: BoxFit.fill,
                ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding:const EdgeInsets.symmetric(vertical: 24,horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        BackArrowWidget(onTap: (){
                          Navigator.pop(context);
                        }),
                        16.hspace,
                      const OnBoardText(text: 'Generate Course', color: Colors.white),
                      ],
                    ),
                    24.vspace,
                    const OnBoardText(text: 'Choose your course content type', 
                    color: Colors.white),
                    24.vspace,
                    CheckBoxWidget(
                      text: 'Theory & Image Course', 
                      width: MediaQuery.of(context).size.width, 
                      fillColor: const Color.fromRGBO(139, 175, 76, 1), 
                      borderColor: Colors.white, 
                      shadowColor: const Color.fromRGBO(139, 175, 76, 1), 
                      isvalue: ischeck,
                      onTap: (newBool){
                        setState(() {
                                     ischeck = newBool!;
                                  });
                      },),
                      16.vspace,
                      CheckBoxWidget(
                      text: 'Theory & Video Course', 
                      width: MediaQuery.of(context).size.width, 
                      fillColor: const Color.fromRGBO(139, 175, 76, 1), 
                      borderColor: Colors.white, 
                      shadowColor: const Color.fromRGBO(139, 175, 76, 1), 
                      isvalue: ischecked,
                      onTap: (newBool){
                        setState(() {
                                     ischecked = newBool!;
                                  });
                      },),
                    SizedBox(height: MediaQuery.of(context).size.height / 2.5),
                    CommonButtonWidget(text: 'Submit', 
                    width: MediaQuery.of(context).size.width, 
                    fillColor: Colors.yellow, 
                    borderColor: Colors.white, 
                    shadowColor: Colors.yellow, 
                    textColor: Colors.black, 
                    onPressed: (){
                      Get.toNamed(Appnames.subtopicname);
                    }),
                  ],
                ),),
            ),
      ),
    );
  }
}