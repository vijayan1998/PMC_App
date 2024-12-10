import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmc/src/Controller/generatecourse_contro.dart';
import 'package:pmc/src/Views/Widget/new_widgets/listtile.dart';

class SubtopicDrawer extends StatefulWidget {
  final Map<String, dynamic>? data;
  final String? maintopic;
  final String? type;
  final String? courseid;
  const SubtopicDrawer(
      {super.key, this.data, this.type, this.maintopic, this.courseid});

  @override
  State<SubtopicDrawer> createState() => _SubtopicDrawerState();
}

class _SubtopicDrawerState extends State<SubtopicDrawer> {
  GenerateCourseController generateCourseController =
      Get.put(GenerateCourseController());
bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    // Check if widget.data is null
    if (widget.data == null || widget.data!.isEmpty) {
      return const Drawer(
        backgroundColor: Color(0xFF300080),
        child: Center(
          child: Text(
            'No data available',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    // Safely get the first key and topics
    final dynamicKey = widget.data!.keys.first;
    final topics = widget.data![dynamicKey] as List<dynamic>?;

    // Handle empty or null topics
    if (topics == null || topics.isEmpty) {
      return Drawer(
        backgroundColor: const Color(0xFF300080),
        child: Center(
          child: Text(
            'No topics available for $dynamicKey',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Drawer(
      width: MediaQuery.of(context).size.width /1.15,
        backgroundColor: const Color(0xFF300080),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24,left: 16),
                  child:InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 8),
                      alignment: Alignment.center,
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white
                      ),
                      child:const Icon(Icons.arrow_back_ios,color: Colors.black,size: 18,),
                    ),
                  )
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: topics.length,
                    itemBuilder: (context, index) {
                      final topic = topics[index];
                      final title = topic['title'] as String? ?? 'No Title';
                      final subtopics = topic['subtopics'] as List<dynamic>?;
                      return Column(
                        children: [
                          const Divider(
                            color: Colors.white,
                            thickness: 1,
                          ),
                          Expandedtile(
                            title: title,
                            widgetcustom: [
                              if (subtopics != null)
                                ...subtopics.map((subtopic) {
                                  final subTitle =
                                      subtopic['title'] as String? ??
                                          'No Subtopic Title';
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            generateCourseController
                                                .handleSelect(
                                                    topic['title'],
                                                    subtopic['title'],
                                                    widget.data!,
                                                    widget.maintopic!,
                                                    widget.type!,
                                                    widget.courseid!,
                                                    context);
                                          
                                          },
                                          child: SizedBox(
                                            width: 220,
                                            child: Text(
                                              subTitle,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(color: Colors.white),
                                                  softWrap: true,
                                            ),
                                            
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        if(subtopic['done'] == true)
                                        const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 10,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                            ],
                          ),
                        ],
                      );
                    }),
                const Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
              ],
            ),
          ),
        ));
  }
}

