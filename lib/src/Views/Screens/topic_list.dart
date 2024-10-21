import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Widget/back_arrow_widget.dart';
import 'package:pmc/src/Views/Widget/container_leftcut_shape.dart';
import 'package:pmc/src/Views/Widget/listttile_sutopic.dart';

class TopicListScreen extends StatefulWidget {
  const TopicListScreen({super.key});

  @override
  State<TopicListScreen> createState() => _TopicListScreenState();
}

class _TopicListScreenState extends State<TopicListScreen> {
  bool _customTileExpanded = false;
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ContainerLeftCutShape(
                      containerHeight:
                          MediaQuery.of(context).size.height / 1.2,
                      containerWidth: MediaQuery.of(context).size.width/ 1.2,
                      containerColor: Colors.black,
                      shadowBlurRadius: 8,
                      shadowSpreadRadius: 4,
                      shadowOffset: const Offset(0, 0),
                      shadowColor: Colors.yellowAccent,
                      widget: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.toNamed(Appnames.aichatscreen);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Image.asset(
                                    AppImages.logo1,
                                    fit: BoxFit.cover,
                                    height: 100,
                                    width: 100,
                                  )),
                            ),
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 5,
                          ),
                          Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              title: const Text(
                                "Subtopic Name",
                                style: TextStyle(color: Colors.white),
                              ),
                              trailing: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.white, width: 3)),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      top: 0,
                                      bottom: 0,
                                      child: Icon(
                                        _customTileExpanded
                                            ? Icons.arrow_drop_up_sharp
                                            : Icons.arrow_drop_down_sharp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              children: const <Widget>[
                                ListttileSutopic(lessonname: "Lesson name"),
                                ListttileSutopic(lessonname: "Lesson name"),
                                ListTile(
                                    title: Text(
                                  'Lesson name',
                                  style: TextStyle(color: Colors.white),
                                )),
                                ListTile(
                                    title: Text(
                                  'Lesson name',
                                  style: TextStyle(color: Colors.white),
                                )),
                                ListTile(
                                    title: Text(
                                  'Lesson name',
                                  style: TextStyle(color: Colors.white),
                                )),
                              ],
                              onExpansionChanged: (bool expanded) {
                                setState(() {
                                  _customTileExpanded = expanded;
                                });
                              },
                            ),
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 5,
                          ),
                          Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              title: const Text(
                                "Subtopic Name",
                                style: TextStyle(color: Colors.white),
                              ),
                              trailing: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.white, width: 3)),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      top: 0,
                                      bottom: 0,
                                      child: Icon(
                                        _customTileExpanded
                                            ? Icons.arrow_drop_up_sharp
                                            : Icons.arrow_drop_down_sharp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              children: const <Widget>[
                                ListttileSutopic(lessonname: "Lesson name"),
                                ListttileSutopic(lessonname: "Lesson name"),
                                ListTile(
                                    title: Text(
                                  'Lesson name',
                                  style: TextStyle(color: Colors.white),
                                )),
                                ListTile(
                                    title: Text(
                                  'Lesson name',
                                  style: TextStyle(color: Colors.white),
                                )),
                                ListTile(
                                    title: Text(
                                  'Lesson name',
                                  style: TextStyle(color: Colors.white),
                                )),
                              ],
                              onExpansionChanged: (bool expanded) {
                                setState(() {
                                  _customTileExpanded = expanded;
                                });
                              },
                            ),
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 5,
                          ),
                          Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              title: const Text(
                                "Subtopic Name",
                                style: TextStyle(color: Colors.white),
                              ),
                              trailing: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.white, width: 3)),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      top: 0,
                                      bottom: 0,
                                      child: Icon(
                                        _customTileExpanded
                                            ? Icons.arrow_drop_up_sharp
                                            : Icons.arrow_drop_down_sharp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              children: const <Widget>[
                                ListttileSutopic(lessonname: "Lesson name"),
                                ListttileSutopic(lessonname: "Lesson name"),
                                ListTile(
                                    title: Text(
                                  'Lesson name',
                                  style: TextStyle(color: Colors.white),
                                )),
                                ListTile(
                                    title: Text(
                                  'Lesson name',
                                  style: TextStyle(color: Colors.white),
                                )),
                                ListTile(
                                    title: Text(
                                  'Lesson name',
                                  style: TextStyle(color: Colors.white),
                                )),
                              ],
                              onExpansionChanged: (bool expanded) {
                                setState(() {
                                  _customTileExpanded = expanded;
                                });
                              },
                            ),
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 5,
                          ),
                          Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              title: const Text(
                                "Subtopic Name",
                                style: TextStyle(color: Colors.white),
                              ),
                              trailing: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.white, width: 3)),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      top: 0,
                                      bottom: 0,
                                      child: Icon(
                                        _customTileExpanded
                                            ? Icons.arrow_drop_up_sharp
                                            : Icons.arrow_drop_down_sharp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              children: const <Widget>[
                                ListttileSutopic(lessonname: "Lesson name"),
                                ListttileSutopic(lessonname: "Lesson name"),
                                ListTile(
                                    title: Text(
                                  'Lesson name',
                                  style: TextStyle(color: Colors.white),
                                )),
                                ListTile(
                                    title: Text(
                                  'Lesson name',
                                  style: TextStyle(color: Colors.white),
                                )),
                                ListTile(
                                    title: Text(
                                  'Lesson name',
                                  style: TextStyle(color: Colors.white),
                                )),
                              ],
                              onExpansionChanged: (bool expanded) {
                                setState(() {
                                  _customTileExpanded = expanded;
                                });
                              },
                            ),
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 5,
                          ),
                          Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              title: const Text(
                                "Subtopic Name",
                                style: TextStyle(color: Colors.white),
                              ),
                              trailing: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.white, width: 3)),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      top: 0,
                                      bottom: 0,
                                      child: Icon(
                                        _customTileExpanded
                                            ? Icons.arrow_drop_up_sharp
                                            : Icons.arrow_drop_down_sharp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              children: const <Widget>[
                                ListttileSutopic(lessonname: "Lesson name"),
                                ListttileSutopic(lessonname: "Lesson name"),
                                ListTile(
                                    title: Text(
                                  'Lesson name',
                                  style: TextStyle(color: Colors.white),
                                )),
                                ListTile(
                                    title: Text(
                                  'Lesson name',
                                  style: TextStyle(color: Colors.white),
                                )),
                                ListTile(
                                    title: Text(
                                  'Lesson name',
                                  style: TextStyle(color: Colors.white),
                                )),
                              ],
                              onExpansionChanged: (bool expanded) {
                                setState(() {
                                  _customTileExpanded = expanded;
                                });
                              },
                            ),
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 5,
                          ),
                        ],
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
