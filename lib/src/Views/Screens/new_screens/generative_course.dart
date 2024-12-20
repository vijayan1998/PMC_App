import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pmc/src/Controller/course_controller.dart';
import 'package:pmc/src/Controller/generatecourse_contro.dart';
import 'package:pmc/src/Controller/subscription_controller.dart';
import 'package:pmc/src/Controller/userdetails_controller.dart';
import 'package:pmc/src/Model/course_model.dart';
import 'package:pmc/src/Model/getusermodel.dart';
import 'package:pmc/src/Views/Sharedpreference/user_controller.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/gradient_button.dart';
import 'package:pmc/src/Views/Widget/new_widgets/checkbox_widget.dart';
import 'package:pmc/src/Views/Widget/textformfield_widget.dart';

class GenerateCourse extends StatefulWidget {
  const GenerateCourse({super.key});

  @override
  State<GenerateCourse> createState() => _GenerateCourseState();
}

class _GenerateCourseState extends State<GenerateCourse> {
  final List<TextEditingController> _controllers = [
    TextEditingController(),
  ];
  final int _maxFields = 5;

  GenerateCourseController generateCourseController = Get.put(GenerateCourseController());
  CourseController courseController = Get.put(CourseController());
  UserdetailsController userdetailsController = Get.put(UserdetailsController());
  SubscriptionController subscriptionController = Get.put(SubscriptionController());
  bool isLoading = false;
  UserController  currentUser = Get.put(UserController());
  List<GetUserModel>? types;
  List<CourseModel>? courses;
  int? countlength;

  @override
  void initState(){
    super.initState();
    currentUser.getUserInfo();
    fetchCourses();
  }

  @override
  void dispose() {
    // Dispose of controllers when the widget is removed from the tree
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addTextField() {
    // Check if all current text fields are filled
    bool allFieldsFilled =
        _controllers.every((controller) => controller.text.trim().isNotEmpty);

    if (allFieldsFilled && _controllers.length < _maxFields) {
      setState(() {
        _controllers.add(TextEditingController());
      });
    } else {
      // Show a message if a field is empty
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(
            content: Text("Please fill all fields before adding a new one.")),
      );
    }
  }

  void _removeTextField() {
    if (_controllers.length > 1) {
      setState(() {
        _controllers.last.dispose(); // Dispose of the last controller
        _controllers.removeLast(); // Remove the last controller from the list
      });
    }
  }

  bool ischeck = false;
  bool ischecked = false;
  bool isimage = false;
  bool isvideo = false;
  TextEditingController entertopic = TextEditingController();

  Future<void> fetchCourses() async {
    try {
      final fetchedCourses = await courseController.getCourse(currentUser.user.id.toString());
      final fetchsubscription = await userdetailsController.getUsers(currentUser.user.id.toString());
      List<dynamic> counts = await subscriptionController.getCount();
      setState(() {
        courses = fetchedCourses;
        types = fetchsubscription;
        countlength = counts.first['count'];
      });
    } catch (error) {
      // Handle the error appropriately
      Fluttertoast.showToast(msg: 'Error: $error');
    }
  }

  void handleSubmit() {
    String mainTopic2 = entertopic.text.trim().toLowerCase();
    List<String> subtopics = _controllers
        .map((controller) => controller.text.trim().toLowerCase())
        .where((text) => text.isNotEmpty)
        .toList();

    // Create the string
    String result = '''
Generate a list of Strict $selectedValue topics and any number subtopic for each topic for main title $mainTopic2, everything in single line. Those $selectedValue topics should Strictly include these topics :- ${subtopics.join(", ")}. Strictly Keep theory, youtube, image field empty. 
Generate in the form of JSON in this format {
  "$mainTopic2": [
    {
      "title": "Topic Title",
      "subtopics": [
        {
          "title": "Sub Topic Title",
          "theory": "",
          "youtube": "",
          "image": "",
          "done": false
        },
        {
          "title": "Sub Topic Title",
          "theory": "",
          "youtube": "",
          "image": "",
          "done": false
        }
      ]
    },
    {
      "title": "Topic Title",
      "subtopics": [
        {
          "title": "Sub Topic Title",
          "theory": "",
          "youtube": "",
          "image": "",
          "done": false
        },
        {
          "title": "Sub Topic Title",
          "theory": "",
          "youtube": "",
          "image": "",
          "done": false
        }
      ]
    }
  ]
}''';

    generateCourseController.postPrompt(
        result, mainTopic2, selectedCourse, context);
  }

  String selectedValue = "5";
  String selectedCourse = "Text & Image Course";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4C07F4),
        automaticallyImplyLeading: false,
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Center(
                          child: Text(
                        "Generate New Course",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Colors.white,
                            ),
                      )),
                      10.vspace,
                      Text(
                        "Type the topic on which you want to Generate course.",
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                      10.vspace,
                      Row(
                        children: [
                          Text(
                            "Course Topic",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                          Text(
                            "*",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.red,
                                    ),
                          )
                        ],
                      ),
                      5.vspace,
                      TextFormWidget(
                          hintText: 'Enter Topic',
                          color: Colors.grey.shade800,
                          fillColor: Colors.transparent,
                          textEditingController: entertopic),
                      24.vspace,
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.white,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                  child: Column(
                    children: [
                      Text(
                        "Select the number of Subtopics you want this course to be spread across.",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      10.vspace,
                      Row(
                        children: [
                          Text(
                            "No of Subtopic",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                          Text(
                            "*",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.red,
                                    ),
                          )
                        ],
                      ),
                      5.vspace,
                      RadioButtonWidget(
                        text: "05",
                        value: "5",
                        groupValue: selectedValue,
                        onChanged: (newValue) {
                          setState(() {
                            selectedValue = newValue!;
                          });
                        },
                      ),

                      RadioButtonWidget(
                        text: "10",
                        value: "10",
                        groupValue: selectedValue,
                        onChanged: (newValue) {
                          setState(() {
                            selectedValue = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.white,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "You can enter a list of subtopics, which are the specifics you want to learn. You can leave this blank if you want our AI to generate the Sub Topics.",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      10.vspace,
                      Text(
                        "Subtopic",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      5.vspace,
                      ListView.builder(
                        itemCount: _controllers.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              TextFormWidget(
                                  hintText: 'Enter Subtopic',
                                  color: Colors.grey.shade800,
                                  fillColor: Colors.transparent,
                                  textEditingController: _controllers[index]),
                              20.vspace
                            ],
                          );
                        },
                      ),
                      20.vspace,
                      Center(
                          child: GradientButtonWidget(
                        text: "Add Subtopic",
                        width: 200,
                        onTap: _controllers.length < _maxFields
                            ? _addTextField
                            : null,
                      )),
                      10.vspace,
                      if (_controllers.length.isEven)
                        Center(
                            child: GradientButtonWidget(
                          text: "Remove Subtopic",
                          width: 200,
                          onTap:
                              _controllers.length > 1 ? _removeTextField : null,
                        ))
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.white,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Choose your course content type",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      10.vspace,
                      Row(
                        children: [
                          Text(
                            "Course Type",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                          Text(
                            "*",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.red,
                                    ),
                          )
                        ],
                      ),
                      5.vspace,
                      RadioButtonWidget(
                        text: "Theory & Image Course",
                        groupValue: selectedCourse,
                        value: "Text & Image Course",
                        onChanged: (newValue) {
                          setState(() {
                            selectedCourse = newValue!;
                          });
                        },
                      ),
                      RadioButtonWidget(
                        text: "Theory & Video Course",
                        value: "Video & Text Course",
                        groupValue: selectedCourse,
                        onChanged: (newValue) {
                          setState(() {
                            selectedCourse = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.white,
                ),
                20.vspace,
               isLoading ? const CircularProgressIndicator() : 
               GradientButtonWidget(
                        onTap: () {
                          setState(() {
                            isLoading = true;
                          });
                        var type = types![0].type;
                        if( type == "free" && courses!.length == 1){
                          Fluttertoast.showToast(msg: 'Please subscribe to access more courses.');
                        } else if(type != 'free'){
                          if(countlength! > 0){
                             handleSubmit();
                          }else {
                            Fluttertoast.showToast(msg: 'Your monthly plan has reached the limit. Please upgrade the Monthly plan for further access');
                          }   
                        }
                        else {
                           handleSubmit();
                         
                        }
                          
                        },
                      text: "Generate Course",
                        width: 200),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
