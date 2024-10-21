import 'package:flutter/material.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/button_widget.dart';
import 'package:pmc/src/Views/Widget/custom_drawpage.dart';
import 'package:pmc/src/Views/Widget/onboard_text.dart';

class MyCoursePage extends StatefulWidget {
  const MyCoursePage({super.key});

  @override
  State<MyCoursePage> createState() => _MyCoursePageState();
}

class _MyCoursePageState extends State<MyCoursePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.transparent,
      body:SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.symmetric(vertical: 24,horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // BackArrowWidget(onTap: (){
                  //   Navigator.pop(context);
                  // },),
                  16.hspace,
                 const OnBoardText(text: 'My Courses', color: Colors.white),
                ],
              ),
               16.vspace,
                 CustomPaint(
                   painter: CustomDrawPage(const Color.fromRGBO(139, 175, 76, 1),
                  Colors.white, const Color.fromRGBO(139, 175, 76, 1)),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 66,
                    padding:const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                       const Icon(Icons.search,color: Colors.black,size: 26),
                        6.hspace,
                        Text('Search by course name',style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.black),)
                      ],  
                    ),
                  ),
                 ),
                 16.vspace,
                const CourseWidget(
                  image: AppImages.course,
                  text1: 'Topic Name', 
                  text2: 'Video & Text',
                  date: '01/10/2024'),
                16.vspace,
                const CourseWidget(
                  image: AppImages.course1,
                  text1: 'Topic Name', 
                  text2: 'Image & Text',
                  date: '01/10/2024'),
                  16.vspace,
                  const CourseWidget(
                image: AppImages.course,
                text1: 'Topic Name', 
                text2: 'Video & Text',
                date: '01/10/2024'), 
                24.vspace, 
            ],
        
          ),
          ),
      ),
    );
  }
}

class CourseWidget extends StatelessWidget {
  final String text1;
  final String text2;
  final String date;
  final String image;
  const CourseWidget({super.key, required this.text1, required this.text2, required this.date,required this.image});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CustomDrawPage(const Color.fromRGBO(160, 175, 76, 0.907),
                Colors.white,const Color.fromRGBO(160, 175, 76, 0.907)),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
               height: 150,
              width: MediaQuery.of(context).size.width / 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image:  DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover)
              ),
            ),
            12.hspace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(text1,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),),
                Text(text2,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),),
                Text(date,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),),
                4.vspace,
                CommonButtonWidget(
                  text: 'Continue',
                  width: MediaQuery.of(context).size.width / 3,
                  fillColor: Colors.yellow, 
                  borderColor: Colors.white, 
                  shadowColor: Colors.red.withOpacity(0.55), 
                  textColor: Colors.black, 
                  onPressed: (){}),

              ],
            )
          ],
        ),
      ),
    );
  }
}