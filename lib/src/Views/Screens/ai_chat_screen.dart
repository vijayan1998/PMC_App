import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/back_arrow_widget.dart';
import 'package:pmc/src/Views/Widget/button_widget.dart';
import 'package:pmc/src/Views/Widget/container_leftcut_shape.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
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
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.background1),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding:const EdgeInsets.symmetric(
                vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Padding(
                padding: const EdgeInsets.only(left: 8,top: 16),
                child: BackArrowWidget(
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
              ),
                Column(
                  children: [
                    ContainerLeftCutShape(
                        containerHeight:
                            MediaQuery.of(context).size.height /1.2,
                        containerWidth:
                            MediaQuery.of(context).size.width /1.2,
                        containerColor: Colors.black,
                        shadowBlurRadius: 8,
                        shadowSpreadRadius: 4,
                        shadowOffset: const Offset(0, 0),
                        shadowColor: Colors.yellowAccent,
                        widget: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 70,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Text(
                                  "Hey there! I'm your AI teacher. If you have any questions about your course, whether it's about videos, images, or theory, just ask me. I'm here to clear your doubts.",
                                  style: TextStyle(
                                      color: Colors.blue[100], fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                height: 250,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 8,
                                          spreadRadius: 4,
                                          color: Colors.purple,
                                        )
                                      ],
                                      border: Border.all(
                                          color: Colors.white, width: 3)),
                                  child: const TextField(
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                    decoration: InputDecoration(
                                        hintText: "Ask Something",
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 70.0, vertical: 40),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                              24.vspace,
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: CommonButtonWidget(
                                    text: 'Submit',
                                    width: MediaQuery.of(context).size.width,
                                    fillColor: Colors.yellow,
                                    borderColor: Colors.white,
                                    shadowColor: Colors.yellow,
                                    textColor: Colors.black,
                                    onPressed: () {
                                      Get.toNamed(Appnames.navigator);
                                    }),
                              )
                            ],
                          ),
                        )),
                        16.vspace,
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
