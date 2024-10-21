import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/button_widget.dart';
import 'package:pmc/src/Views/Widget/custom_drawpage.dart';
import 'package:pmc/src/Views/Widget/onboard_text.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
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
                   const OnBoardText(text: 'Profile', color: Colors.white),
                ],
              ),
              16.vspace,
              CustomPaint(
                painter: CustomDrawPage(const Color.fromRGBO(139, 175, 76, 1),
                  Colors.white, const Color.fromRGBO(139, 175, 76, 1)),
                  child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(8),
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 76,
                            width: 76,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(AppImages.course1),
                                fit: BoxFit.cover)
                            ),
                          ),
                          12.hspace,
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('John Doe',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),),
                                Text('test1@gmail.com',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),),
                                Text('+91 9178945612',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),),
                              ],
                            ),
                        ],
                      ),
                       Positioned(
                              bottom: 0,
                              right: 0,
                               child: CommonButtonWidget(
                                 text: 'Edit', 
                                 height: 42,
                                 width: 66, 
                                 fillColor: Colors.yellow,
                                  borderColor: Colors.white, 
                                  shadowColor: Colors.red.withOpacity(0.55),
                                  textColor: Colors.black, onPressed: (){}),
                      ),
                    ],
                  ),
                  ),
              ),
              16.vspace,
               ProfileWidget(text: 'Your Courses', icon: Icons.notes,onchanged: (){
                Get.toNamed(Appnames.course);
              },),
              8.vspace,
              const ProfileWidget(text: 'Help & Support', icon: Icons.notes),
              8.vspace,
               ProfileWidget(text: 'FAQ', icon: Icons.notes,
              onchanged: (){
                Get.toNamed(Appnames.faq);
              },),
              8.vspace,
              ProfileWidget(text: 'Terms of Service', icon: Icons.notes,
              onchanged: (){
                 Get.toNamed(Appnames.termsofservice);
              },),
              8.vspace,
               ProfileWidget(text: 'Privacy Policy', icon: Icons.notes,
               onchanged: (){
                  Get.toNamed(Appnames.privacypolice);
               },),
              8.vspace,
                ProfileWidget(text: 'My Subscription', icon: Icons.notes,
               onchanged: (){
                Get.toNamed(Appnames.subscription);
               },),
              8.vspace,
               const ProfileWidget(text: 'Delete Account', icon: Icons.notes),
              8.vspace,
               const ProfileWidget(text: 'Logout', icon: Icons.notes),
              8.vspace,
              
            ],
          ),
        ),
      ),
    );
  }
}



class ProfileWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onchanged;
  const ProfileWidget({super.key, required this.text, required this.icon, this.onchanged});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CustomDrawPage(const Color.fromRGBO(139, 175, 76, 1),
                Colors.white, const Color.fromRGBO(139, 175, 76, 1)),
      child: Container(
        height: 66,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon,size: 26,color: Colors.black,),
            8.hspace,
            Text(text,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),),
          const Spacer(),
            CommonButtonWidget(
              text: 'Select', 
              width: MediaQuery.of(context).size.width / 4, 
              fillColor: Colors.yellow, 
              borderColor: Colors.white, 
              shadowColor: Colors.red.withOpacity(0.55), 
              textColor: Colors.black, 
              onPressed: onchanged)
          ],
        ),
      ),
    );
  }
}