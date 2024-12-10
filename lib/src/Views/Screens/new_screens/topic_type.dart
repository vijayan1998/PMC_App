import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pmc/src/Controller/course_controller.dart';
import 'package:pmc/src/Controller/generatecourse_contro.dart';
import 'package:pmc/src/Model/course_model.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';
import 'package:pmc/src/Views/Screens/Profile/certificate_view.dart';
import 'package:pmc/src/Views/Screens/new_screens/ai_chat_screen.dart';
import 'package:pmc/src/Views/Screens/new_screens/generative_course1.dart';
import 'package:pmc/src/Views/Screens/new_screens/subtopic_drawer.dart';
import 'package:pmc/src/Views/Sharedpreference/user_controller.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/back_arrow_widget.dart';
import 'package:pmc/src/Views/Widget/gradient_button.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TopicType extends StatefulWidget {
  final String? topic;
  final String? type;
  final String? drawertitle;
  final String? drawersubtopic;
  final Map<String, dynamic>? data;
  final String? courseid;
  final bool? completed;
  const TopicType({
    super.key,
    this.topic,
    this.type,
    this.data,
    this.courseid,
    this.drawertitle,
    this.drawersubtopic,
    this.completed,
  });

  @override
  State<TopicType> createState() => _TopicTypeState();
}

class _TopicTypeState extends State<TopicType> {
  GenerateCourseController generateCourseController =
      Get.put(GenerateCourseController());
  CourseController courseController = Get.put(CourseController());
  UserController currentUser = Get.put(UserController());

  bool isLoggedIn = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      generateCourseController.calculateCourseProgress(
          widget.courseid!, widget.data!, widget.topic!);
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<void> _toggleDrawerContent(bool loginState) async {
    // Close the drawer if it’s already open
    if (_scaffoldKey.currentState?.isEndDrawerOpen ?? false) {
      Navigator.of(context).pop();
    }

    setState(() {
      isLoggedIn = loginState; // Set the isLoggedIn state
    });

    // Open the drawer with the new content
    _scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> mainTopics = widget.data![widget.topic] ?? [];

    if (mainTopics.isEmpty) {
      return const Center(child: Text("No topics available."));
    }

    // Extract the first topic and its subtopics
    Map<String, dynamic> firstTopic = mainTopics.first;
    //String title = firstTopic["title"] ?? "No Title";
    List<dynamic> subtopics = firstTopic["subtopics"] ?? [];
    final subtopic = subtopics[0];
    String? youtubeOrImage = subtopic.containsKey("youtube")
        ? subtopic["youtube"]
        : subtopic.containsKey("image")
            ? subtopic["image"]
            : null;

    // Check if the current data matches the topic and type conditions
    // Extract the first topic and its subtopics
    Map<String, dynamic> secondTopic = mainTopics.firstWhere(
        (topic) => topic["title"] == widget.drawertitle,
        orElse: () => mainTopics.first);
    List<dynamic> subtopics2 = secondTopic["subtopics"] ?? [];
    final subtopic2 = subtopics2.firstWhere(
        (topic) => topic["title"] == widget.drawersubtopic,
        orElse: () => mainTopics.first);
    String? youtubeOrImagesubtopic = subtopic2.containsKey("youtube")
        ? subtopic2["youtube"]
        : subtopic2.containsKey("image")
            ? subtopic2["image"]
            : null;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BackArrowWidget(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GenerateCourse1(
                            topic: widget.topic,
                            type: widget.type,
                            data: widget.data,
                          )));
            },
          ),
        ),
        actions: [
          Builder(builder: (context) {
            return IconButton(
                onPressed: () {
                  _toggleDrawerContent(true);
                },
                icon: const Icon(
                  Icons.menu_rounded,
                  color: Colors.white,
                  size: 30,
                ));
          })
        ],
        backgroundColor: const Color(0xFF200098),
      ),
      endDrawer: isLoggedIn
          ? SubtopicDrawer(
              data: widget.data,
              maintopic: widget.topic,
              type: widget.type,
              courseid: widget.courseid,
            )
          : AiChatScreen(
              mainTopic: widget.topic,
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
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Obx(() {
                bool isComplete = generateCourseController.isComplete.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                        child: Text(
                      widget.topic.toString(),
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.white,
                          ),
                      //TextStyle(color: Colors.white, fontSize: 20),
                    )),

                    if (isComplete == true || widget.completed == true) ...[
                      FutureBuilder(
                        future:courseController.getCourse(currentUser.user.id.toString()) ,
                        builder: (context,snapshot){
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return  const Center(child: CircularProgressIndicator());
                          }else if(snapshot.hasError){
                            return Center(child: Text('Error:${snapshot.hasError}')); 
                          }else {
                            List<CourseModel> courses = snapshot.data!;
                            var enddate = courses.firstWhere((course) => course.mainTopic == widget.topic);
                            var end = enddate.end;
                              DateTime parsedDate =
                        DateTime.parse(end.toString());
                    // Formatting the DateTime into the desired format
                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(parsedDate);
                          return Center(
                              child: GradientButtonWidget(
                                height: 40,
                            text: "Download Certificate",
                            width: MediaQuery.of(context).size.width,
                            onTap: () {
                              generateCourseController.finishcourse(
                                  widget.courseid!, context);
                              Get.toNamed(Appnames.navigator);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CertificateViewScreen(
                                            mainTopic: widget.topic.toString(),
                                            formattedDate: formattedDate,
                                          )));
                            },
                          ));
                          }
                        }
                      ),
                      16.vspace,
                    ] else ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Obx(() {
                              int percentage = generateCourseController
                                  .getCourseProgress(widget.courseid!);
                              return Text(
                                // "${generateCourseController.percentage.value}%",
                                "$percentage%",
                                style: const TextStyle(color: Colors.white),
                              );
                            }),
                          ),
                        ],
                      ),
                      Obx(() {
                        int percentage = generateCourseController
                            .getCourseProgress(widget.courseid!);
                        return LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 40,
                          animation: true,
                          lineHeight: 20.0,
                          animationDuration: 2000,
                          percent: (percentage / 100).clamp(0.0, 1.0),
                          // percent: (generateCourseController.percentage.value / 100)
                          //     .clamp(0.0, 1.0),
                          linearGradient: const LinearGradient(
                            transform: GradientRotation(1),
                            colors: [
                              Color(0xFF3D03FA),
                              Color(0xFFA71CD2),
                            ],
                          ),
                          barRadius: const Radius.circular(10),
                          // progressColor:  Color(0xFF300080),
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, top: 4),
                        child: Text(
                          "Completion Status",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.white,
                                  ),
                          // TextStyle(color: Colors.white),
                        ),
                      ),
                      16.vspace,
                    ],

                    if (widget.data != null &&
                        widget.drawersubtopic != null) ...[
                      youtubeOrImage != null
                          ? youtubeOrImage.length ==
                                  11 // Check if it's a YouTube ID
                              ? _buildYouTubePlayer(youtubeOrImagesubtopic!)
                              : youtubeOrImagesubtopic!.startsWith(
                                      "http") // Check for a valid image URL
                                  ? _buildImage(youtubeOrImagesubtopic)
                                  : const Text("Invalid media content")
                          : const Text("No media available"),
                      8.vspace,
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  subtopic2["theory"] ?? "No Theory",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ] else ...[
                      youtubeOrImage != null
                          ? youtubeOrImage.length ==
                                  11 // Check if it's a YouTube ID
                              ? _buildYouTubePlayer(youtubeOrImage)
                              : youtubeOrImage.startsWith(
                                      "http") // Check for a valid image URL
                                  ? _buildImage(youtubeOrImage)
                                  : const Text("Invalid media content")
                          : const Text("No media available"),
                      8.vspace,
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  subtopic["theory"] ?? "No Theory",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                    16.vspace,
                  ],
                );
              })),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          _toggleDrawerContent(false);
        },
        child: Image.asset(
          "assets/images/ai_icon.png",
          height: 60,
          width: 60,
        ),
      ),
    );
  }

  Widget _buildYouTubePlayer(String youtubeId) {
    return YoutubePlayer(
      controller: YoutubePlayerController(
        initialVideoId: youtubeId, // Use the video ID directly
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      ),
      showVideoProgressIndicator: true,
    );
  }

  // Build Image Viewer
  Widget _buildImage(String imageUrl) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Text("Failed to load image");
      },
    );
  }
}
