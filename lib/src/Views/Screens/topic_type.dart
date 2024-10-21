import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/back_arrow_widget.dart';
import 'package:pmc/src/Views/Widget/container_cut_shape.dart';
import 'package:pmc/src/Views/Widget/onboard_text.dart';
import 'package:video_player/video_player.dart';

class TopicType extends StatefulWidget {
  const TopicType({super.key});

  @override
  State<TopicType> createState() => _TopicTypeState();
}

class _TopicTypeState extends State<TopicType> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(
            "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 22,
          left: 4,
          right: 4,
        ),
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.background1),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BackArrowWidget(
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    8.hspace,
                    CircularPercentIndicator(
                      radius: 20.0,
                      lineWidth: 7.0,
                      animation: true,
                      percent: 0.7,
                      center: const Text(
                        "50%",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0,
                            color: Colors.white),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.lightGreenAccent,
                    ),
                    8.hspace,
                    const OnBoardText(text: 'Topic Name', color: Colors.white),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.pinkAccent.withOpacity(0.25),
                      ),
                      child: const Icon(
                        Icons.menu_rounded,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ],
                ),
                16.vspace,
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context)
                      .size
                      .width, // Reduced width for the p
                  child: ClipRect(
                    // Clip the edges to create a "zoom-out" effect
                    child: Transform.scale(
                      scale:
                          0.9, // Reduce the overall scale to show more of the video
                      child: AspectRatio(
                        aspectRatio: 16 / 9, // Maintain the aspect ratio
                        child: FlickVideoPlayer(
                          flickManager: flickManager,
                          flickVideoWithControls: const FlickVideoWithControls(
                            controls: FlickPortraitControls(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                8.vspace,
                Container(
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: MediaQuery.of(context).size.height / 2.8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            "Eisenhower Matrix: A Simple Guide to Prioritizing Tasks \nIntroduction: \nDo you ever feel overwhelmed by the amount of tasks on your to-do list? The Eisenhower Matrix is a tool that can help you prioritize tasks based on their importance and urgency. \nQuadrants: \nThe matrix divides tasks into four quadrants: Do First (Urgent and Important): Tasks that are essential for your success and need immediate attention. Schedule (Important but Not",
                            style: TextStyle(
                                color: Colors.blue[100], fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              16.vspace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: () {
                          Get.toNamed(Appnames.topicList);
                        },
                        child: ContainerCutShape(
                            containerHeight:
                                MediaQuery.of(context).size.height / 17,
                            containerWidth:
                                MediaQuery.of(context).size.width / 2,
                            containerColor: Colors.yellow,
                            shadowBlurRadius: 8,
                            shadowSpreadRadius: 4,
                            shadowOffset: const Offset(0, 0),
                            shadowColor: Colors.purple,
                            widget: const Padding(
                              padding: EdgeInsets.all(13.0),
                              child: Text(
                                "AI Teacher",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            )))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
