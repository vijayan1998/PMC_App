import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmc/src/Controller/signup_controller.dart';
import 'package:pmc/src/Controller/subscription_controller.dart';
import 'package:pmc/src/Controller/userdetails_controller.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';
import 'package:pmc/src/Views/Screens/currentsub.dart';
import 'package:pmc/src/Views/Sharedpreference/user_controller.dart';
import 'package:pmc/src/Views/Sharedpreference/user_preference.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/gradient_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserdetailsController userdetailsController =
      Get.put(UserdetailsController());
  SignupController signupController = Get.put(SignupController());
  UserController currentUser = Get.put(UserController());
  SubscriptionController subscriptionController =
      Get.put(SubscriptionController());
  Uint8List? cachedBytes;
  @override
  void initState() {
    super.initState();
    subscriptionController
        .getSubscriptionByUserId(currentUser.user.id.toString());
    fetchAndDecodeImage();
  }

  Future<Uint8List?> fetchAndDecodeImage() async {
    if (cachedBytes != null) {
      // Use cached image if available
      return cachedBytes;
    }

    try {
      final base64Image = await userdetailsController.getImageById(
        currentUser.user.id.toString(),
      );
      if (base64Image != null) {
        cachedBytes = base64Decode(base64Image);
      }
    } catch (e) {
      // Handle error appropriately
      debugPrint('Error fetching image: $e');
    }
    return cachedBytes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff300080),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(
                  top: 48, left: 16, right: 16, bottom: 12),
              decoration: const BoxDecoration(
                  //  color: Color(0xff200098),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff4C07F4),
                      Color(0xff200098),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(56),
                      bottomRight: Radius.circular(56))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(
                    () => FutureBuilder<Uint8List?>(
                      future: fetchAndDecodeImage(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError || snapshot.data == null) {
                          return Image.asset(
                            AppImages.user,
                            height: 96,
                          );
                        } else {
                          return Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: MemoryImage(snapshot.data!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  // Image.asset(AppImages.user, height: 76, width: 76),
                  8.hspace,
                  FutureBuilder(
                      future: userdetailsController
                          .getUsers(currentUser.user.id.toString()),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error : ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(
                            child: Text(
                              'No user found',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.white),
                            ),
                          );
                        } else {
                          final users = snapshot.data!;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: users.map((user) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '${user.fname} ${user.lname}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: Colors.white),
                                  ),
                                  Text(
                                    'Phone: ${user.phone}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                          color: Colors.white.withOpacity(0.75),
                                        ),
                                  ),
                                  Text(
                                    'Email: ${user.email}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                          color: Colors.white.withOpacity(0.75),
                                        ),
                                  ),
                                  Text(
                                    'DOB: ${user.dob}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                            color:
                                                Colors.white.withOpacity(0.75)),
                                  )
                                ],
                              );
                            }).toList(),
                          );
                        }
                      }),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Appnames.edit);
                    },
                    child: Text(
                      'Edit',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.white.withOpacity(0.75),
                          ),
                    ),
                  ),
                ],
              ),
            ),
            16.vspace,
            InkWell(
                onTap: () {
                  Get.toNamed(Appnames.course);
                },
                child: const ProfileWidget(
                    text: 'My Courses', image: AppImages.learing)),
            8.vspace,
            InkWell(
                onTap: () async {
                  // final subscription = await subscriptionController
                      // .getSubscriptionByUserId(currentUser.user.id.toString());
                  // if (subscription != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SubGet()),
                     );
                  // } else {
                  //   Get.toNamed(Appnames.subscription);
                  // }
                },
                child: const ProfileWidget(
                    text: 'My Subscription', image: AppImages.subscription)),
            8.vspace,
            InkWell(
                onTap: () {
                  Get.toNamed(Appnames.mycertificate);
                },
                child: const ProfileWidget(
                    text: 'My Certificates', image: AppImages.document)),
            8.vspace,
            InkWell(
                onTap: () {
                  Get.toNamed(Appnames.help);
                },
                child: const ProfileWidget(
                    text: 'Help & Support', image: AppImages.help)),
            8.vspace,
            InkWell(
                onTap: () {
                  Get.toNamed(Appnames.notifications);
                },
                child: const ProfileWidget(
                    text: 'Notifications', image: AppImages.notifications)),
            8.vspace,
            InkWell(
                onTap: () {
                  Get.toNamed(Appnames.faq);
                },
                child: const ProfileWidget(text: 'FAQ', image: AppImages.faq)),
            8.vspace,
            InkWell(
                onTap: () {
                  Get.toNamed(Appnames.termsofservice);
                },
                child: const ProfileWidget(
                    text: 'Terms of Service', image: AppImages.terms)),
            8.vspace,
            InkWell(
                onTap: () {
                  Get.toNamed(Appnames.privacypolice);
                },
                child: const ProfileWidget(
                    text: 'Privacy Policy', image: AppImages.privacy)),
            8.vspace,
            InkWell(
                onTap: () {
                  alertBox('Logout', ' Do you want to proceed with logout?',
                      'Cancel', 'Logout');
                },
                child: const ProfileWidget(
                    text: 'Logout', image: AppImages.logout)),
            8.vspace,
            InkWell(
                onTap: () {
                  alertBox2(
                      'Delete Account',
                      ' Are you sure you want to delete your account permanently please note you cannot undo this action and all your data and subscription will be deleted form our systems permanently  ',
                      'Delete',
                      'Cancel');
                },
                child: const ProfileWidget(
                    text: 'Delete Account', image: AppImages.delete)),
            8.vspace,
          ],
        ),
      ),
    );
  }

  alertBox(String text, String text1, String buttoncancel, String buttonokay) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              backgroundColor: const Color(0xff300080),
              contentPadding: const EdgeInsets.all(16),
              title: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.cancel,
                          size: 22,
                          color: Colors.white,
                        )),
                  ),
                  Center(
                    child: Text(text,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.white)),
                  ),
                ],
              ),
              content: Text(
                text1,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 120,
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [
                        0.2,
                        1,
                        2,
                        2,
                      ],
                      colors: [
                        Color(0xffA61CD2),
                        Color(0xff4C07F4),
                        Color(0xff200098),
                        Color(0xff3D03FA),
                      ],
                    )),
                    child: Text(
                      "Cancel",
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: Colors.white,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 120,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // padding:const EdgeInsets.all(14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        RememberUserPrefs.removeUserInfo().then((value) {
                          Get.toNamed(Appnames.login);
                        });
                      },
                      child: Text(
                        buttonokay,
                        style: Theme.of(context).textTheme.labelMedium!
                          ..copyWith(
                            color: Colors.black,
                          ),
                      )),
                )
              ],
            ));
  }

  alertBox2(String text, String text1, String buttoncancel, String buttonokay) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              backgroundColor: const Color(0xff300080),
              contentPadding: const EdgeInsets.all(16),
              title: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.cancel,
                          size: 26,
                          color: Colors.white,
                        )),
                  ),
                  16.vspace,
                  Center(
                    child: Text(text,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.white)),
                  ),
                ],
              ),
              content: Text(
                text1,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    
                    ),
                    textAlign: TextAlign.center,
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                InkWell(
                  onTap: () {
                    RememberUserPrefs.removeUserInfo().then((value) {
                      signupController
                          .deleteUser(currentUser.user.id.toString());
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 120,
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [
                        0.2,
                        1,
                        2,
                        2,
                      ],
                      colors: [
                        Color(0xffA61CD2),
                        Color(0xff4C07F4),
                        Color(0xff200098),
                        Color(0xff3D03FA),
                      ],
                    )),
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: Colors.white,
                          ),
                     textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 120,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        buttonokay,
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: Colors.black,
                            ),
                      )),
                )
              ],
            ));
  }
}

class ProfileWidget extends StatelessWidget {
  final String text;
  final String image;
  const ProfileWidget({super.key, required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      width: MediaQuery.of(context).size.width,
      color: const Color(0xff200098).withOpacity(0.75),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            image,
            height: 28,
            width: 28,
            color: Colors.white,
          ),
          8.hspace,
          Text(
            text,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Colors.white.withOpacity(0.75),
                fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          const GradientButtonWidget(text: 'Select', width: 100)
        ],
      ),
    );
  }
}
