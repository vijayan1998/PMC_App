import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pmc/src/Controller/course_controller.dart';
import 'package:pmc/src/Model/course_model.dart';
import 'package:pmc/src/Views/Screens/Profile/certificate_view.dart';
import 'package:pmc/src/Views/Screens/new_screens/topic_type.dart';
import 'package:pmc/src/Views/Sharedpreference/user_controller.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/back_arrow_widget.dart';
import 'package:pmc/src/Views/Widget/gradient_button.dart';

class MyCoursePage extends StatefulWidget {
  const MyCoursePage({super.key});

  @override
  State<MyCoursePage> createState() => _MyCoursePageState();
}

class _MyCoursePageState extends State<MyCoursePage> {
  int selectIndex = 0;
  CourseController courseController = Get.put(CourseController());
  UserController currentUser = Get.put(UserController());
  TextEditingController allCourse = TextEditingController();
  TextEditingController completedCourse = TextEditingController();
  TextEditingController activeCourse = TextEditingController();
  String selectCourse = '';
  String selectCompleted = '';
  String selectActive = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff300080),
      appBar: AppBar(
        backgroundColor: const Color(0xff4C07F4),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BackArrowWidget(
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          'My Courses',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ),
        elevation: 12,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectIndex = 0;
                      });
                    },
                    child: ClipPath(
                      clipper: TabClipper(),
                      child: Container(
                        height: 36,
                        width: MediaQuery.of(context).size.width / 3.5,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: selectIndex == 0 ? null : Colors.white,
                            gradient: selectIndex == 0
                                ? const LinearGradient(
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
                                  )
                                : null),
                        child: Text(
                          'All Courses',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: selectIndex == 0
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectIndex = 1;
                      });
                    },
                    child: ClipPath(
                      clipper: TabClipper(),
                      child: Container(
                        height: 36,
                        width: MediaQuery.of(context).size.width / 3.5,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: selectIndex == 1 ? null : Colors.white,
                            gradient: selectIndex == 1
                                ? const LinearGradient(
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
                                  )
                                : null),
                        child: Text(
                          'Completed',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: selectIndex == 1
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectIndex = 2;
                      });
                    },
                    child: ClipPath(
                      clipper: TabClipper(),
                      child: Container(
                        height: 36,
                        width: MediaQuery.of(context).size.width / 3.5,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: selectIndex == 2 ? null : Colors.white,
                            gradient: selectIndex == 2
                                ? const LinearGradient(
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
                                  )
                                : null),
                        child: Text(
                          'Active',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: selectIndex == 2
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                thickness: 2,
                color: Colors.white,
              ),
              16.vspace,
              selectIndex == 0
                  ? allCourses()
                  : selectIndex == 1
                      ? completed()
                      : selectIndex == 2
                          ? active()
                          : allCourses(),
            ],
          ),
        ),
      ),
    );
  }

  active() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          16.vspace,
          TextFormField(
            controller: activeCourse,
            onChanged: (value) {
              setState(() {
                selectActive = value.toLowerCase();
              });
            },
            decoration: InputDecoration(
              hintText: 'Search By Course Name',
              hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.grey.shade800,
                  ),
              filled: true,
              fillColor: Colors.white,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(16),
              )),
              prefixIcon: const Icon(Icons.search),
            ),
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Colors.grey.shade800,
                ),
          ),
          24.vspace,
          FutureBuilder(
            future: courseController.getCourse(currentUser.user.id.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No courses found'));
              } else {
                List<CourseModel> courses = snapshot.data!;
                List<CourseModel> courseList = courses
                    .where((course) =>
                        course.completed == false &&
                        course.mainTopic!.toLowerCase().contains(selectActive))
                    .toList();
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: courseList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    // Parsing the string into a DateTime object
                    DateTime parsedDate =
                        DateTime.parse(courseList[index].end.toString());
                    // Formatting the DateTime into the desired format
                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(parsedDate);
                    return CourseWidget(
                      image: Image.network(
                        courseList[index].photo.toString(),
                        height: 86,
                        width: MediaQuery.of(context).size.width / 7.5,
                        fit: BoxFit.cover,
                      ),
                      text1: courseList[index].mainTopic.toString(),
                      text2: courseList[index].type.toString(),
                      date: formattedDate,
                      button: GradientButtonWidget(
                        text: 'View',
                        width: MediaQuery.of(context).size.width / 3,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TopicType(
                                      topic: courseList[index].mainTopic,
                                      type: courseList[index].type,
                                      courseid: courseList[index].id,
                                      data: courseList[index].content != null
                                          ? jsonDecode(
                                              courseList[index].content!)
                                          : null)));
                        },
                      ),
                      button1: const SizedBox(),
                    );
                  },
                );
              }
            },
          ),
          12.vspace,
        ],
      ),
    );
  }

  completed() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          24.hspace,
          TextField(
            controller: completedCourse,
            onChanged: (value) {
              setState(() {
                selectCompleted = value.toLowerCase();
              });
            },
            decoration: InputDecoration(
              hintText: 'Search By Course Name',
              hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.grey.shade800,
                  ),
              filled: true,
              fillColor: Colors.white,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(16),
              )),
              prefixIcon: const Icon(Icons.search),
            ),
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Colors.grey.shade800,
                ),
          ),
          24.vspace,
          FutureBuilder(
            future: courseController.getCourse(currentUser.user.id.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No courses found'));
              } else {
                List<CourseModel> courses = snapshot.data!;
                List<CourseModel> courseList = courses
                    .where((course) =>
                        course.completed == true &&
                        course.mainTopic!
                            .toLowerCase()
                            .contains(selectCompleted))
                    .toList();
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: courseList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    // Parsing the string into a DateTime object
                    DateTime parsedDate =
                        DateTime.parse(courseList[index].end.toString());
                    // Formatting the DateTime into the desired format
                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(parsedDate);
                    return CourseWidget(
                      image: Image.network(
                        courseList[index].photo.toString(),
                        height: 86,
                        width: MediaQuery.of(context).size.width / 7.5,
                        fit: BoxFit.cover,
                      ),
                      text1: courseList[index].mainTopic.toString(),
                      text2: courseList[index].type.toString(),
                      date: formattedDate,
                      button: GradientButtonWidget(
                        text: 'View',
                        width: MediaQuery.of(context).size.width / 3,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TopicType(
                                      topic: courseList[index].mainTopic,
                                      type: courseList[index].type,
                                      courseid: courseList[index].id,
                                      completed: courseList[index].completed,
                                      data: courseList[index].content != null
                                          ? jsonDecode(
                                              courseList[index].content!)
                                          : null)));
                        },
                      ),
                      button1: GradientButtonWidget(
                        text: 'Certificate',
                        width: MediaQuery.of(context).size.width / 3,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CertificateViewScreen(
                                        mainTopic: courseList[index].mainTopic,
                                        formattedDate: formattedDate,
                                      )));
                        },
                      ),
                    );
                  },
                );
              }
            },
          ),
          12.vspace,
        ],
      ),
    );
  }

  allCourses() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          24.hspace,
          TextField(
            controller: allCourse,
            onChanged: (value) {
              setState(() {
                selectCourse = value.toLowerCase();
              });
            },
            decoration: InputDecoration(
              hintText: 'Search By Course Name',
              hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.grey.shade800,
                  ),
              filled: true,
              fillColor: Colors.white,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(16),
              )),
              prefixIcon: const Icon(Icons.search),
            ),
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Colors.grey.shade800,
                ),
          ),
          24.vspace,
          FutureBuilder<List<CourseModel>>(
            future: courseController.getCourse(currentUser.user.id.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No courses found'));
              } else {
                List<CourseModel> courses = snapshot.data!;
                List<CourseModel> courseList = courses
                    .where((course) =>
                        course.mainTopic!.toLowerCase().contains(selectCourse))
                    .toList();
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: courseList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    // Parsing the string into a DateTime object
                    DateTime parsedDate =
                        DateTime.parse(courseList[index].end.toString());
                    // Formatting the DateTime into the desired format
                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(parsedDate);
                    return CourseWidget(
                      image: Image.network(
                        courseList[index].photo.toString(),
                        height: 86,
                        width: MediaQuery.of(context).size.width / 7,
                        fit: BoxFit.cover,
                      ),
                      text1: courseList[index].mainTopic.toString(),
                      text2: courseList[index].type.toString(),
                      date: formattedDate,
                      button: GradientButtonWidget(
                        text: 'View',
                        width: 120,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TopicType(
                                      topic: courseList[index].mainTopic,
                                      type: courseList[index].type,
                                      courseid: courseList[index].id,
                                      completed: courseList[index].completed,
                                      data: courseList[index].content != null
                                          ? jsonDecode(
                                              courseList[index].content!)
                                          : null)));
                        },
                      ),
                      button1: GradientButtonWidget(
                        text: 'Certificate',
                        width: 120,
                        onTap: () {
                          courseList[index].completed == true
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CertificateViewScreen(
                                            mainTopic:
                                                courseList[index].mainTopic,
                                            formattedDate: formattedDate,
                                          )))
                              : ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Course not complete")),
                                );
                        },
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class CourseWidget extends StatelessWidget {
  final String text1;
  final String text2;
  final String date;
  final Widget button;
  final Widget? button1;
  final Widget image;
  const CourseWidget(
      {super.key,
      required this.text1,
      required this.text2,
      required this.date,
      required this.button,
      this.button1,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: const Color(0xff200098),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          image,
          4.hspace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 160,
                child: Text(
                  text1,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                ),
              ),
              Text(
                text2,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white),
              ),
              Text(
                date,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              button,
              8.vspace,
              button1!,
            ],
          )
        ],
      ),
    );
  }
}

class TabClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0); // Top-left
    path.lineTo(size.width - 10, 0); // Top-right
    path.lineTo(size.width, size.height / 3); // Right diagonal cut
    path.lineTo(size.width, size.height); // Bottom-right
    path.lineTo(0, size.height); // Bottom-left
    path.close(); // Connect to starting point
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
