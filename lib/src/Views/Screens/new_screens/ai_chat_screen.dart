import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pmc/src/Controller/aichat_controller.dart';
import 'package:pmc/src/Controller/generatecourse_contro.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/gradient_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AiChatScreen extends StatefulWidget {
  final String? mainTopic;
  const AiChatScreen({super.key, this.mainTopic});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final AiChatController _aiChatController = Get.put(AiChatController());
  GenerateCourseController generateCourseController =
      Get.put(GenerateCourseController());
  @override
  void initState() {
    super.initState();
    if (widget.mainTopic != null) {
      _aiChatController.loadMessages(widget.mainTopic!);
    }
  }

  @override
  void dispose() {
    // Clear SharedPreferences when the screen is disposed
    _clearMessagesLocally();
    super.dispose();
  }

  Future<void> _clearMessagesLocally() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(widget.mainTopic!);
    } catch (error) {
      debugPrint("Error clearing messages locally: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width / 1.15,
      backgroundColor: const Color(0xFF300080),
      child: Scaffold(
        backgroundColor: const Color(0xFF300080),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 8),
                            alignment: Alignment.center,
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                              size: 18,
                            ),
                          ),
                        )),
                    Obx(
                      () => ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _aiChatController.messages.length,
                        itemBuilder: (context, index) {
                          final message = _aiChatController.messages[index];
                          final isBot = message['sender'] == 'bot';
                          return Align(
                            alignment: isBot
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: isBot
                                        ? Colors.grey.shade200
                                        : Colors.blue,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    message['text'] ?? '',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color:
                                          isBot ? Colors.black : Colors.white,
                                    ),
                                  ),
                                ),
                                isBot
                                    ? IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                backgroundColor:const Color(0xFF200098),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8)
                                                ),
                                                    content: SizedBox(
                                                      height: 180,
                                                      width: MediaQuery.of(context).size.width,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              Fluttertoast.showToast(
                                                                  msg:
                                                                      'Your report is update successfully');
                                                              Navigator.pop(context);
                                                            },
                                                            child: Text(
                                                              'Child exploitation',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                            ),
                                                          ),
                                                          12.vspace,
                                                          InkWell(
                                                            onTap: () {
                                                              Fluttertoast.showToast(
                                                                  msg:
                                                                      'Your report is update successfully');
                                                              Navigator.pop(context);
                                                            },
                                                            child: Text(
                                                              'Violence and self-harm',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                            ),
                                                          ),
                                                          12.vspace,
                                                          InkWell(
                                                            onTap: () {
                                                              Fluttertoast.showToast(
                                                                  msg:
                                                                      'Your report is update successfully');
                                                              Navigator.pop(context);
                                                            },
                                                            child: Text(
                                                              'Nudity and sexual content',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                            ),
                                                          ),
                                                          12.vspace,
                                                          InkWell(
                                                            onTap: () {
                                                              Fluttertoast.showToast(
                                                                  msg:
                                                                      'Your report is update successfully');
                                                                Navigator.pop(context);
                                                            },
                                                            child: Text(
                                                              'Other inappropriate or illegal content',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                            ),
                                                          ),
                                                          12.vspace,
                                                          InkWell(
                                                            onTap: () {
                                                              Fluttertoast.showToast(
                                                                  msg:
                                                                      'Your report is update successfully');
                                                              Navigator.pop(context);
                                                            },
                                                            child: Text(
                                                              'Unwanted content',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ));
                                        },
                                        icon: const Icon(Icons.report,
                                            color: Colors.white, size: 26))
                                    : const SizedBox(),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ])),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: TextFormField(
                  controller: _aiChatController.messageController,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  maxLines: null,
                  minLines: 1,
                  decoration: InputDecoration(
                      hintText: "Ask Something",
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 40),
                      border: InputBorder.none),
                ),
              ),
              16.vspace,
              Center(
                  child: GradientButtonWidget(
                text: "Submit",
                width: 100,
                onTap: _aiChatController.sendMessage,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
