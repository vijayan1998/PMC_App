import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pmc/src/Controller/course_controller.dart';
import 'package:pmc/src/Controller/subscription_controller.dart';
import 'package:pmc/src/Controller/userdetails_controller.dart';
import 'package:pmc/src/Model/course_model.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';
import 'package:pmc/src/Views/Screens/new_screens/topic_type.dart';
import 'package:pmc/src/Views/Sharedpreference/user_controller.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/gradient_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserdetailsController userdetailsController =
      Get.put(UserdetailsController());
  UserController currentUser = Get.put(UserController());
  CourseController courseController = Get.put(CourseController());
  SubscriptionController subscriptionController =
      Get.put(SubscriptionController());
  Uint8List? cachedBytes;
  @override
  void initState() {
    super.initState();
    currentUser.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppImages.background2), fit: BoxFit.fill),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
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
                          bottomLeft: Radius.circular(36),
                          bottomRight: Radius.circular(36))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                            onTap: () {
                              Get.toNamed(Appnames.notifications);
                            },
                            child: const Icon(
                              Icons.notification_add,
                              size: 30,
                              color: Colors.white,
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(AppImages.user, height: 76, width: 76),
                          8.hspace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Obx(
                                () => FutureBuilder(
                                    future: userdetailsController.getUsers(
                                        currentUser.user.id.toString()),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Center(
                                            child: Text(
                                                'Error :${snapshot.hasError}'));
                                      } else if (!snapshot.hasData ||
                                          snapshot.data!.isEmpty) {
                                        return const Center(
                                            child: Text('No users found'));
                                      } else {
                                        final users = snapshot.data!;
                                        return Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: users.map((user) {
                                            return Text(
                                              '${user.fname} ${user.lname}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                      color: Colors.white),
                                            );
                                          }).toList(),
                                        );
                                      }
                                    }),
                              ),
                              Obx(
                                () => FutureBuilder(
                                    future: subscriptionController
                                        .getSubscriptionByUserId(
                                            currentUser.user.id.toString()),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Center(
                                            child: Text(
                                                'Error : ${snapshot.error}'));
                                      } else if(!snapshot.hasData || snapshot.data == null){
                                        return  Text(
                                             'Subscription : Free',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                    color: Colors.white
                                                        .withOpacity(0.75),
                                                  ),
                                            );
                                      }
                                      else {
                                        final subscription = snapshot.data!;
                                        DateTime parsedDate = DateTime.parse(
                                            subscription.date.toString());
                                        String formattedDate =
                                            DateFormat('dd-MM-yyyy')
                                                .format(parsedDate);
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                             'Subscription : ${subscription.plan}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                    color: Colors.white
                                                        .withOpacity(0.75),
                                                  ),
                                            ),
                                            Text(
                                              'Subscription Expiry : $formattedDate',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                      color: Colors.white
                                                          .withOpacity(0.75)),
                                            )
                                          ],
                                        );
                                      }
                                    }),
                              ),
                              Obx(
                                () => FutureBuilder(
                                    future: subscriptionController.getCount(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Center(
                                            child: Text(
                                                'Error : ${snapshot.error}'));
                                      } else if (!snapshot.hasData ||
                                          snapshot.data!.isEmpty) {
                                        return Text(
                                          'Count : 0',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                  color: Colors.white
                                                      .withOpacity(0.75)),
                                        );
                                      } else {
                                        final countplan = snapshot.data;
                                        return Text(
                                          'Count : ${countplan?.first["count"] ?? "0"}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                  color: Colors.white
                                                      .withOpacity(0.75)),
                                        );
                                      }
                                    }),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                8.vspace,
                Padding(
                    padding: const EdgeInsets.all(6),
                    child: Obx(
                      () => FutureBuilder<List<CourseModel>>(
                        future: courseController
                            .getCourse(currentUser.user.id.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else {
                            List<CourseModel> courses = snapshot.data!;
                            int totalCourses = courses.length;
                            // videocourses count
                            var videoCourses = courses
                                .where((video) =>
                                    video.type == 'video & text course')
                                .toList();
                            int videoCount = videoCourses.length;
                            // imagecourse count
                            var imagescourses = courses
                                .where((image) =>
                                    image.type == 'text & image course')
                                .toList();
                            int imageCount = imagescourses.length;
                            // return Column(
                            //   children: courses.map((course){
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                commonContainer(
                                    'Total \nCourses \nGenerated',
                                    totalCourses.toString().isEmpty
                                        ? "0"
                                        : totalCourses.toString(),
                                    GradientButtonWidget(
                                      text: 'View',
                                      width: 120,
                                      onTap: () {
                                        //        Navigator.push(context, MaterialPageRoute(builder: (context) =>TopicType(
                                        //   topic: course.mainTopic,
                                        //   type: course.type,
                                        //   courseid: course.id,
                                        //   data: course.content != null ?
                                        //   jsonDecode(course.content!)
                                        //   : null
                                        // )));
                                      },
                                    )),
                                4.hspace,
                                commonContainer(
                                    'Video \nCourses \nGenerat',
                                    videoCount.toString().isEmpty
                                        ? "0"
                                        : videoCount.toString(),
                                    GradientButtonWidget(
                                      text: 'View',
                                      width: 120,
                                      onTap: () {
                                        //        Navigator.push(context, MaterialPageRoute(builder: (context) =>TopicType(
                                        //   topic: course.mainTopic,
                                        //   type: course.type,
                                        //   courseid: course.id,
                                        //   data: course.content != null ?
                                        //   jsonDecode(course.content!)
                                        //   : null
                                        // )));
                                      },
                                    )),
                                4.hspace,
                                commonContainer(
                                    'Theory \nCourses \nGenerated',
                                    imageCount.toString().isEmpty
                                        ? "0"
                                        : imageCount.toString(),
                                    GradientButtonWidget(
                                      text: 'View',
                                      width: 120,
                                      onTap: () {
                                        //     Navigator.push(context, MaterialPageRoute(builder: (context) =>TopicType(
                                        //   topic: course.mainTopic,
                                        //   type: course.type,
                                        //   courseid: course.id,
                                        //   data: course.content != null ?
                                        //   jsonDecode(course.content!)
                                        //   : null
                                        // )));
                                      },
                                    )),
                              ],
                            );
                            //     }).toList(),
                            //   );
                          }
                        },
                      ),
                    )),
                8.vspace,
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: Obx(
                    () => FutureBuilder<List<CourseModel>>(
                      future: courseController
                          .getCourse(currentUser.user.id.toString()),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          List<CourseModel> courses = snapshot.data!;
                          // activeCourses count
                          var activeCourses = courses
                              .where((active) => active.completed == false)
                              .toList();
                          int activeCount = activeCourses.length;
                          // completedcourse count
                          var completedCourse = courses
                              .where((complete) => complete.completed == true)
                              .toList();
                          int completecount = completedCourse.length;
                          // return Column(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: courses.map((course){
                          return Row(
                            children: [
                              commonContainer(
                                  'Active             \nCourses',
                                  activeCount.toString(),
                                  GradientButtonWidget(
                                    text: 'View',
                                    width: 120,
                                    onTap: () {
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) =>TopicType(
                                      //     topic: course.mainTopic,
                                      //     type: course.type,
                                      //     courseid: course.id,
                                      //     data: course.content != null ?
                                      //     jsonDecode(course.content!)
                                      //     : null
                                      //   )));
                                    },
                                  )),
                              24.hspace,
                              commonContainer(
                                  'Completed     \nCourses',
                                  completecount.toString(),
                                  GradientButtonWidget(
                                    text: 'View',
                                    width: 120,
                                    onTap: () {
                                      //  Navigator.push(context, MaterialPageRoute(builder: (context) =>TopicType(
                                      //     topic: course.mainTopic,
                                      //     type: course.type,
                                      //     courseid: course.id,
                                      //     data: course.content != null ?
                                      //     jsonDecode(course.content!)
                                      //     : null
                                      //   )));
                                    },
                                  )),
                            ],
                          );
                        }
                        //).toList()

                        // );
                        //}
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Monthly Activity Progress',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.white.withOpacity(0.75)),
                      ),
                      const Spacer(),
                      Text(
                        'This Month',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.white.withOpacity(0.75)),
                      ),
                      4.hspace,
                      InkWell(
                          onTap: () {
                            showMenu(
                              context: context,
                              position: const RelativeRect.fromLTRB(100, 490, 0,
                                  0), // Adjust the position as needed
                              items: [
                                const PopupMenuItem(
                                  value: 'option1',
                                  child: Text('Last Month'),
                                ),
                                const PopupMenuItem(
                                  value: 'option1',
                                  child: Text('Last 3 Month'),
                                ),
                                const PopupMenuItem(
                                  value: 'option2',
                                  child: Text('Last 6 Months'),
                                ),
                              ],
                            );
                          },
                          child: const Icon(
                            Icons.list,
                            size: 26,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
                Obx(
                  () => FutureBuilder<List<CourseModel>>(
                    future: courseController
                        .getCourse(currentUser.user.id.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        List<CourseModel> courses = snapshot.data!;
                        // Get the current month
                        int currentMonth = DateTime.now().month;
                        // Filter courses with end month equal to the current month
                        List<CourseModel> currentMonthCourses = courses
                            .where((course) =>
                                DateTime.parse(course.end.toString()).month ==
                                currentMonth)
                            .toList();
                        int totalCourses = courses.length;
                        int currentMonthCount = currentMonthCourses.length;
                        double currentMonthPercentage = totalCourses > 0
                            ? (currentMonthCount / totalCourses)
                            : 0.0; // Avoid division by zero
                        // Active Month Courses
                        var activeMonth = courses
                            .where((active) =>
                                active.completed == false &&
                                DateTime.parse(active.end.toString()).month ==
                                    currentMonth)
                            .toList();
                        int activemonth = activeMonth.length;
                        double activeMonthPercentage = totalCourses > 0
                            ? (activemonth / totalCourses)
                            : 0.0;
                        //  completed Courses
                        var completeMonth = courses
                            .where((complete) =>
                                complete.completed == true &&
                                DateTime.parse(complete.end.toString()).month ==
                                    currentMonth)
                            .toList();
                        int completedValue = completeMonth.length;
                        int completeMonthPercentage = totalCourses > 0
                            ? ((completedValue / totalCourses) * 10).toInt()
                            : 0;
                        //  Video Courses
                        var videoCourse = courses
                            .where((video) =>
                                video.type == 'video & text course' &&
                                DateTime.parse(video.end.toString()).month ==
                                    currentMonth)
                            .toList();
                        int videoMonth = videoCourse.length;
                        num videoPercentage = totalCourses > 0
                            ? ((videoMonth / totalCourses) * 10).toInt()
                            : 0;
                        //  Image Courses
                        var imagecourse = courses
                            .where((image) =>
                                image.type == 'text & image course' &&
                                DateTime.parse(image.end.toString()).month ==
                                    currentMonth)
                            .toList();
                        int imageMonth = imagecourse.length;
                        int imagePercentage = totalCourses > 0
                            ? ((imageMonth / totalCourses) * 10).toInt()
                            : 0;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CommonProgress(
                              text: '  Courses Generated this month',
                              text1: '$currentMonthCount/$totalCourses',
                              value: currentMonthPercentage,
                            ),
                            CommonProgress(
                              text: '   Active Courses this month',
                              text1: '$activemonth/$totalCourses',
                              value: activeMonthPercentage,
                            ),
                            CommonProgress(
                              text: '  Completed Courses this month',
                              text1: '$completeMonthPercentage/$totalCourses',
                              value: completeMonthPercentage / 10,
                            ),
                            CommonProgress(
                              text: '  Video Courses Generated this month',
                              text1: '$videoPercentage/$totalCourses',
                              value: videoPercentage / 10,
                            ),
                            CommonProgress(
                              text: '  Image Courses Generated this month',
                              text1: '$imagePercentage/$totalCourses',
                              value: imagePercentage / 10,
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Recent Courses',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.white.withOpacity(0.75)),
                  ),
                ),
                4.vspace,
                Obx(
                  () => FutureBuilder(
                    future: courseController
                        .getCourse(currentUser.user.id.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No courses found'));
                      } else {
                        List<CourseModel> courses = snapshot.data!;
                        // Sort courses by 'end' date in descending order
                        courses.sort((a, b) => DateTime.parse(b.end.toString())
                            .compareTo(DateTime.parse(a.end.toString())));

                        // Take the recent three courses
                        List<CourseModel> recentCourses =
                            courses.take(3).toList();
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: recentCourses.length,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(0),
                          itemBuilder: (context, index) {
                            // Parsing the string into a DateTime object
                            DateTime parsedDate =
                                DateTime.parse(courses[index].end.toString());
                            // Formatting the DateTime into the desired format
                            String formattedDate =
                                DateFormat('dd-MM-yyyy').format(parsedDate);
                            return CommonHomeWidget(
                                image: Image.network(
                                  courses[index].photo.toString(),
                                  height: 86,
                                  fit: BoxFit.cover,
                                  width:
                                      MediaQuery.of(context).size.width / 6.5,
                                ),
                                width: MediaQuery.of(context).size.width,
                                text: courses[index].mainTopic.toString(),
                                text1: courses[index].type.toString(),
                                text2: formattedDate,
                                widget: GradientButtonWidget(
                                  text: 'View',
                                  width: 80,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => TopicType(
                                                topic: courses[index].mainTopic,
                                                type: courses[index].type,
                                                courseid: courses[index].id,
                                                completed:
                                                    courses[index].completed,
                                                data: courses[index].content !=
                                                        null
                                                    ? jsonDecode(
                                                        courses[index].content!)
                                                    : null)));
                                  },
                                ));
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }

  commonContainer(String text, String text1, Widget widget) {
    return Container(
      width: MediaQuery.of(context).size.width / 3.5,
      color: Colors.black.withOpacity(0.75),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: Colors.white.withOpacity(0.75)),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            text1,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white),
          ),
          widget,
        ],
      ),
    );
  }
}

class CommonProgress extends StatelessWidget {
  final String text;
  final String text1;
  final double value;
  const CommonProgress(
      {super.key,
      required this.text,
      required this.text1,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Text(
              text1,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: Colors.white),
            ),
          ),
          LinearPercentIndicator(
            lineHeight: 12,
            backgroundColor: Colors.white,
            barRadius: const Radius.circular(8),
            percent: value,
            linearGradient: const LinearGradient(
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
                ]),
          ),
          4.vspace,
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white.withOpacity(0.75)),
          ),
        ],
      ),
    );
  }
}

class CommonHomeWidget extends StatelessWidget {
  final double width;
  final double? height;
  final String text;
  final String text1;
  final String text2;
  final Widget widget;
  final Widget image;
  const CommonHomeWidget(
      {super.key,
      required this.width,
      this.height,
      required this.text,
      required this.text1,
      required this.text2,
      required this.image,
      required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(16),
      height: height,
      width: width,
      color: const Color(0xff200098),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          image,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                text,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
              Text(
                text1,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white),
              ),
              Text(
                text2,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
          widget,
        ],
      ),
    );
  }
}
