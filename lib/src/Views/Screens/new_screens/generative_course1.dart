import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmc/src/Controller/generatecourse_contro.dart';
import 'package:pmc/src/Views/Screens/navigator_screen.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/back_arrow_widget.dart';
import 'package:pmc/src/Views/Widget/gradient_button.dart';
import 'package:pmc/src/Views/Widget/new_widgets/common_button.dart';

class GenerateCourse1 extends StatefulWidget {
  final String? topic;
  final String? type;
  final Map<String, dynamic>? data;
  const GenerateCourse1(
      {super.key,  this.topic,  this.type,  this.data});

  @override
  State<GenerateCourse1> createState() => _GenerateCourse1State();
}

class _GenerateCourse1State extends State<GenerateCourse1> {
  GenerateCourseController generateCourseController= Get.put(GenerateCourseController());
  bool isLoading = false;
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dynamicKey =
        widget.data!.keys.first; // Handle if multiple keys exist as needed.
    final topics = widget.data![dynamicKey] as List<dynamic>?;

    if (topics == null || topics.isEmpty) {
      return Center(
        child: Text(
          'No topics available for $dynamicKey',
          style:const TextStyle(color: Colors.white),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4C07F4),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BackArrowWidget(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NavigatorScreen(index: 1)));
            },
          ),
        ),
        title: Text(
          'Generate Course',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ),
        elevation: 12,
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF110038),
                Color(0xFF08006B),
              ],
            ),
          ),
          child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 34),
                  child: Column(children: [
                    Center(
                        child: Text(
                      widget.topic!,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.white,
                          ),
                      //TextStyle(color: Colors.white, fontSize: 20),
                    )),
                    10.vspace,
                    Text(
                      "List of Topics & subtopics this course will cover",
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Colors.white,
                              ),
                      //TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    24.vspace,
                    const Divider(
                      color: Colors.white,
                    ),
                    ListView.builder(
                        itemCount: topics.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final topic = topics[index];
                          final title = topic['title'] as String? ?? 'No Title';
                          final subtopics =
                              topic['subtopics'] as List<dynamic>?;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                    if (subtopics != null)
                                      ...subtopics.map((subtopic) {
                                        final subTitle =
                                            subtopic['title'] as String? ??
                                                'No Subtopic Title';
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16.0, bottom: 4.0),
                                          child: Text(
                                            '- $subTitle',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(color: Colors.white),
                                          ),
                                        );
                                      }),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: Colors.white,
                              ),
                            ],
                          );
                        }),
                    24.vspace,
                    CommonButtonWhite(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: "Go Back",
                      width: 200,
                    ),
                    10.vspace,
                  isLoading ? const CircularProgressIndicator()
                   :GradientButtonWidget(
                        onTap: () {  
                          setState(() {
                            isLoading = true;
                          });
                         generateCourseController.redirectCourse(widget.data!, widget.topic!, widget.type!.toLowerCase(),context);
                        },
                        text: "Generate Course",
                        width: 200)
                  ])))),
    );
  }
}
