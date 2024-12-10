import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/back_arrow_widget.dart';
import 'package:pmc/src/Views/Widget/button_widget.dart';
import 'package:pmc/src/Views/Widget/custom_drawpage.dart';
import 'package:pmc/src/Views/Widget/onboard_text.dart';

class SubtopicName extends StatefulWidget {
  const SubtopicName({super.key});

  @override
  State<SubtopicName> createState() => _SubtopicNameState();
}

class _SubtopicNameState extends State<SubtopicName> {
   bool _isBottomContainerVisible = false;
  bool _isBottomContainerVisible2 = false;
  void toggleBottomContainer2() {
    setState(() {
      _isBottomContainerVisible2 = !_isBottomContainerVisible2;
    });
  }
  
  void toggleBottomContainer() {
    setState(() {
      _isBottomContainerVisible = !_isBottomContainerVisible;
    });
  }
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
            child: Padding(padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BackArrowWidget(onTap: (){Navigator.pop(context);},),
                      16.hspace,
                      const OnBoardText(text: 'Generate Course', color: Colors.white),
                    ],
                  ),
                  8.vspace,
                  Center(
                    child: Text(
                      'Topic Name',
                      style:Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white,fontWeight: FontWeight.bold)
                    ),
                  ),
                  4.vspace,
                    Center(
                    child: Text(
                      'List of Topics & subtopics this course will cover',
                      style:Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white,fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                16.vspace,
                GestureDetector(
                  onTap: toggleBottomContainer,
                  child: CustomPaint(
                    painter: CustomDrawPage( const Color.fromRGBO(139, 175, 76, 1), 
                    Colors.white, 
                    const Color.fromRGBO(139, 175, 76, 1)),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding:const EdgeInsets.all(8),
                      child:  Text('Subtopic name',style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.black)),
                    ),
                  ),
                ),
                if (_isBottomContainerVisible)
                           ListView.builder(
                            shrinkWrap: true,
                            padding:const EdgeInsets.all(0),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 3,
                                 itemBuilder: (BuildContext context, int index) {
                                   return CustomPaint(
                                    painter: CustomDrawPage(Colors.transparent, 
                                    Colors.white, 
                                   Colors.transparent),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding:const EdgeInsets.all(8),
                                      child: Text('Lesson name',style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white),),
                                    ),
                                   );
                                 }
                               ),
                      16.vspace,
                  GestureDetector(
                  onTap: toggleBottomContainer2,
                  child: CustomPaint(
                    painter: CustomDrawPage( const Color.fromRGBO(139, 175, 76, 1), 
                    Colors.white, 
                    const Color.fromRGBO(139, 175, 76, 1)),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding:const EdgeInsets.all(8),
                      child:  Text('Subtopic name',style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.black)),
                    ),
                  ),
                ),
                 if (_isBottomContainerVisible2)
                           ListView.builder(
                            shrinkWrap: true,
                            padding:const EdgeInsets.all(0),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 3,
                                 itemBuilder: (BuildContext context, int index) {
                                   return CustomPaint(
                                    painter: CustomDrawPage(Colors.transparent, 
                                    Colors.white, 
                                   Colors.transparent),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding:const EdgeInsets.all(8),
                                      child: Text('Lesson name',style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white),),
                                    ),
                                   );
                                 }
                               ),
                               16.vspace,
                               Padding(
                                 padding: const EdgeInsets.all(16.0),
                                 child: CommonButtonWidget(
                                  text: 'Generate Course', 
                                  width: MediaQuery.of(context).size.width, 
                                  fillColor: Colors.yellow,
                                  borderColor: Colors.white, 
                                  shadowColor: Colors.yellow, 
                                  textColor: Colors.black, 
                                  onPressed: (){
                                    Get.toNamed(Appnames.topicname);
                                  }),
                               ),
                               Padding(
                                 padding: const EdgeInsets.all(16.0),
                                 child: CommonButtonWidget(
                                  text: 'Go Back', 
                                  width: MediaQuery.of(context).size.width, 
                                  fillColor: Colors.lightGreenAccent,
                                  borderColor: Colors.white, 
                                  shadowColor: Colors.lightGreenAccent, 
                                  textColor: Colors.black, 
                                  onPressed: (){
                                    Navigator.pop(context);
                                  }),
                               ),
                               8.vspace,

                ],
              ),
            ),),
      ),
    );
  }
}