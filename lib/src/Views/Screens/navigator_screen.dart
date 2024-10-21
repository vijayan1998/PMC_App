import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';
import 'package:pmc/src/Views/Screens/home_screen.dart';
import 'package:pmc/src/Views/Screens/mycourse.dart';
import 'package:pmc/src/Views/Screens/profile.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/button_widget.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({super.key});

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
         margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 22,left: 4,right: 4,),
            padding:const EdgeInsets.all(8),
            decoration:const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.background1),
                fit: BoxFit.fill,
                ),
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: index == 0 ? const HomeScreen() : index == 1 ? const MyCoursePage() : index == 2 ? const ProfilePage() :const  HomeScreen()),
            8.vspace,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CommonButtonWidget(
                  text: 'Generate Course', 
                  height: 72,
                  width: MediaQuery.of(context).size.width / 2.5, 
                  fillColor: Colors.yellow, 
                  borderColor: Colors.white, 
                  shadowColor: Colors.yellow, 
                  textColor: Colors.black, 
                  onPressed: (){
                    Get.toNamed(Appnames.course1);
                
                  })
              ],
            ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8,right: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                index = 0;
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.home,color: index == 0 ? Colors.pink.withOpacity(0.55):Colors.white,size: 36,),
                                Text('Home',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color:index == 0 ?Colors.pink.withOpacity(0.55) : Colors.white,
                                  fontSize: 16,
                                ),)
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                index = 1;
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Icon(Icons.notes,color:index == 1 ?Colors.pink.withOpacity(0.55) :Colors.white,size: 36,),
                                 Text('My \nCourses',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color:index == 1? Colors.pink.withOpacity(0.55): Colors.white,
                                      fontSize: 16,
                                    ),
                                   textAlign: TextAlign.start,
                              ),
                              ],
                            ),
                          ),
                           InkWell(
                            onTap: (){
                              setState(() {
                                index = 2;
                              });
                            },
                             child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Icon(Icons.person,color: index == 2 ?Colors.pink.withOpacity(0.55):Colors.white,size: 36,),
                                 Text('Profile',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color:index == 2? Colors.pink.withOpacity(0.55): Colors.white,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                    ),
                              ],
                            ),
                           ),                           
                        ],
                      ),
                    ),
                  )
          ],
        ),
        // Stack(
        //   children: [
        //     SingleChildScrollView(
        //       child: Container(
        //         height: MediaQuery.of(context).size.height / 1,
        //         width: MediaQuery.of(context).size.width,
        //         margin:const EdgeInsets.all(8),
        //         padding: const EdgeInsets.all(8),
                // child: index == 0 ? const HomeScreen() : index == 1 ? const MyCoursePage() : index == 2 ? const ProfilePage() :const  HomeScreen(),
        //       ),
        //     ),
        //     56.vspace,
        //     Positioned(
        //       bottom: MediaQuery.of(context).size.height /16,
        //       right: 0,
        //       left: MediaQuery.of(context).size.width / 1.8,
              // child:CommonButtonWidget(
              //   text: 'Generate Course',
              //   height: 76,
              //    width: MediaQuery.of(context).size.width / 12, 
              //   fillColor: Colors.yellow, borderColor: Colors.white, shadowColor: Colors.yellow, textColor: Colors.black, onPressed: (){})),  
            // Positioned(
            //   bottom: 0,
            //   left: MediaQuery.of(context).size.width / 45,
            //   right: MediaQuery.of(context).size.width / 2.4,
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       InkWell(
            //         onTap: (){
            //           setState(() {
            //             index = 0;
            //           });
            //         },
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           children: [
            //             Icon(Icons.home,color: index == 0 ? Colors.pink.withOpacity(0.55):Colors.white,size: 36,),
            //             Text('Home',style: Theme.of(context).textTheme.titleMedium!.copyWith(
            //               color:index == 0 ?Colors.pink.withOpacity(0.55) : Colors.white,
            //               fontSize: 18,
            //             ),)
            //           ],
            //         ),
            //       ),
            //       InkWell(
            //         onTap: (){
            //           setState(() {
            //             index = 1;
            //           });
            //         },
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //              Icon(Icons.notes,color:index == 1 ?Colors.pink.withOpacity(0.55) :Colors.white,size: 36,),
            //              Text('Course',style: Theme.of(context).textTheme.titleSmall!.copyWith(
            //                   color:index == 1? Colors.pink.withOpacity(0.55): Colors.white,
            //                   fontSize: 18,
            //                 ),
            //                textAlign: TextAlign.center,
            //           ),
            //           ],
            //         ),
            //       ),
            //        InkWell(
            //         onTap: (){
            //           setState(() {
            //             index = 2;
            //           });
            //         },
            //          child: Column(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //              Icon(Icons.person,color: index == 2 ?Colors.pink.withOpacity(0.55):Colors.white,size: 36,),
            //              Text('Profile',style: Theme.of(context).textTheme.titleMedium!.copyWith(
            //                   color:index == 2? Colors.pink.withOpacity(0.55): Colors.white,
            //                   fontSize: 18,
            //                 ),
            //                 textAlign: TextAlign.center,
            //                 ),
            //           ],
            //         ),
            //        )
            //     ],
            //   ))
        //   ],
        // ),
      ),
    );
  }
}