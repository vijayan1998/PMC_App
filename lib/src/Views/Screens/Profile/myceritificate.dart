import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pmc/src/Controller/course_controller.dart';
import 'package:pmc/src/Model/course_model.dart';
import 'package:pmc/src/Views/Screens/Profile/certificate_view.dart';
import 'package:pmc/src/Views/Screens/home_screen.dart';
import 'package:pmc/src/Views/Sharedpreference/user_controller.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/back_arrow_widget.dart';
import 'package:pmc/src/Views/Widget/gradient_button.dart';

class Myceritificate extends StatefulWidget {
  const Myceritificate({super.key});

  @override
  State<Myceritificate> createState() => _MyceritificateState();
}

class _MyceritificateState extends State<Myceritificate> {
  UserController currentUser = Get.put(UserController());
  CourseController courseController = Get.put(CourseController());
  TextEditingController certificate = TextEditingController();
  String selectCertificate ='';
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
          'My Certificates',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ),
        elevation: 12,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            24.vspace,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: certificate,
              onChanged: (value) {
                setState(() {
                  selectCertificate = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search By Course Name',
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.grey.shade800, fontSize: 18),
                filled: true,
                fillColor: Colors.white,
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(16),
                )),
                prefixIcon: const Icon(Icons.search),
              ),
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Colors.grey.shade800, fontSize: 18),
            ),
          ),
            36.vspace,
            FutureBuilder(
              future:
                  courseController.getCourse(currentUser.user.id.toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No courses found'));
                } else {
                  List<CourseModel> courses = snapshot.data!;
                  List<CourseModel> courseList =
                      courses.where((course) => course.completed == true && course.mainTopic!.toLowerCase().contains(selectCertificate)).toList();
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: courseList.length,
                    physics:const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      // Parsing the string into a DateTime object
                      DateTime parsedDate = DateTime.parse(courseList[index].end.toString());
                      // Formatting the DateTime into the desired format
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(parsedDate);
                      return CommonHomeWidget(
                          image: Image.network(
                            courseList[index].photo.toString(),
                            height: 86,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width / 7.5,
                          ),
                          width: MediaQuery.of(context).size.width,
                          text: courseList[index].mainTopic.toString(),
                          text1: courseList[index].type.toString(),
                          text2: formattedDate,
                          widget: GradientButtonWidget(
                            text: 'Certificate',
                            width: MediaQuery.of(context).size.width / 3.5,
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  CertificateViewScreen(
                                mainTopic: courseList[index].mainTopic,
                                formattedDate: formattedDate,
                              )));
                            },
                          ));
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
