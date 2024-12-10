import 'package:flutter/material.dart';
import 'package:pmc/src/Views/Screens/home_screen.dart';
import 'package:pmc/src/Views/Screens/new_screens/generative_course.dart';
import 'package:pmc/src/Views/Screens/profile.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';

// ignore: must_be_immutable
class NavigatorScreen extends StatefulWidget {
   int index;
   NavigatorScreen({super.key, required this.index});

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
            // padding:const EdgeInsets.all(8),
            decoration:const BoxDecoration(
              color: Color(0xff300080),
            ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child:widget.index == 0 ? const HomeScreen() : widget.index == 1 ? const GenerateCourse() :widget.index == 2 ? const ProfilePage() :const  HomeScreen()),
              8.vspace,
                    Divider(
                      thickness: 2,
                      color: Colors.grey.withOpacity(0.55),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24,right: 24),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                               widget.index = 0;
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                               const Center(child: Icon(Icons.home,
                                color: Colors.white,
                                //color: index == 0 ? Colors.pink.withOpacity(0.55):Colors.white,
                                size:45,)),//36
                                Text('Home',style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                //  color:index == 0 ?Colors.pink.withOpacity(0.55) : Colors.white,
                                  fontSize: 18,
                                ),)
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                               widget.index = 1;
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                 Image.asset(AppImages.learing,
                                 color: Colors.white,
                                // color:index == 1 ?Colors.pink.withOpacity(0.55) :Colors.white,
                                 height: 45,//36
                                 width: 45,),//36
                                 Text('Generate Course',style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                  color:Colors.white,
                                     // color:index == 1? Colors.pink.withOpacity(0.55): Colors.white,
                                      fontSize: 18,
                                    ),
                                  
                              ),
                              ],
                            ),
                          ),
                           InkWell(
                            onTap: (){
                              setState(() {
                               widget.index = 2;
                              });
                            },
                             child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.person,
                                 color: Colors.white,
                                 //color: index == 2 ?Colors.pink.withOpacity(0.55):Colors.white,
                                 size: 45,),//36
                                 Text('Profile',style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                   //   color:index == 2? Colors.pink.withOpacity(0.55): Colors.white,
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.center,
                                    ),
                              ],
                            ),
                           ),                           
                        ],
                      ),
                    )
            ],
          ),
        ),
    );
  }
}