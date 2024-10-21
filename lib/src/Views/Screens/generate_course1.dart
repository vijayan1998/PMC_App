import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/back_arrow_widget.dart';
import 'package:pmc/src/Views/Widget/button_widget.dart';
import 'package:pmc/src/Views/Widget/onboard_text.dart';
import 'package:pmc/src/Views/Widget/textformfield_widget.dart';

class GenerateSubtopicCourse extends StatefulWidget {
  const GenerateSubtopicCourse({super.key});

  @override
  State<GenerateSubtopicCourse> createState() => _GenerateSubtopicCourseState();
}

class _GenerateSubtopicCourseState extends State<GenerateSubtopicCourse> {
   TextEditingController topic = TextEditingController();
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
            child: Padding(
              padding:const EdgeInsets.symmetric(vertical: 24,horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BackArrowWidget(
                        onTap: (){
                          Navigator.pop(context);
                        },
                      ),
                      16.hspace,
                     const OnBoardText(text: 'Generate Course', color: Colors.white),
                    ],
                  ),
                  24.vspace,
                 const OnBoardText(text: 'You can enter a list of subtopics,which are the specifics you want to learn.you can leave this blank if you want our AI to generate the Sub Topics for you', 
                  color: Colors.white),
                24.vspace,
                  TextFormWidget(
                        hintText: 'Enter Subtopic', 
                        height: 56, 
                        width: MediaQuery.of(context).size.width, 
                        topsize: 10, 
                        textEditingController: topic, 
                        color: Colors.white,
                        fillColor: const Color.fromRGBO(139, 175, 76, 1)),
                24.vspace,
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: CommonButtonWidget(
                    text: 'Add More Subtopics',
                     width: MediaQuery.of(context).size.width, 
                     fillColor: Colors.lightGreenAccent, 
                     borderColor: Colors.white, 
                     shadowColor: Colors.lightGreenAccent, 
                     textColor: Colors.black, 
                     onPressed: (){}),
                ),
                  SizedBox(height: MediaQuery.of(context).size.height / 6),
                CommonButtonWidget(
                  text: 'Next',
                   width: MediaQuery.of(context).size.width, 
                   fillColor: Colors.yellow, 
                   borderColor: Colors.white, 
                   shadowColor: Colors.yellow, 
                   textColor: Colors.black, 
                   onPressed: (){
                    Get.toNamed(Appnames.coursecontent);
                   }),  
                ],
              ),
            ),),
      ),
    );
  }
}