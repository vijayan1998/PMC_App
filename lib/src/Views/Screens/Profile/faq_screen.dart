import 'package:flutter/material.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/back_arrow_widget.dart';
import 'package:pmc/src/Views/Widget/custom_drawpage.dart';
import 'package:pmc/src/Views/Widget/onboard_text.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
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
                  16.hspace,
                  const OnBoardText(text: 'FAQ', color: Colors.white),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.menu_rounded,
                        color: Colors.white,
                        size: 36,
                      ))
                ],
              ),
              16.vspace,
              CustomPaint(
                painter: CustomDrawPage(const Color.fromRGBO(139, 175, 76, 1),
                    Colors.white, const Color.fromRGBO(139, 175, 76, 1)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 66,
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.search, color: Colors.black, size: 26),
                      6.hspace,
                      Text(
                        'Search Your Topic',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              16.vspace,
              Container(
                color: Colors.black.withOpacity(0.5),
                height: MediaQuery.of(context).size.height / 1.5,
                width: MediaQuery.of(context).size.width ,
                padding: const EdgeInsets.all(8),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Divider(
                      color: Colors.white,
                      thickness: 3,
                    ),
                    CommonExpansionWidget(
                        text: 'Lorem Ipsum question',
                        text2: 'This is tile number 1'),
                     Divider(
                      color: Colors.white,
                      thickness: 3,
                    ),
                    CommonExpansionWidget(
                        text: 'Lorem Ipsum question',
                        text2: 'This is tile number 1'),
                    Divider(
                      color: Colors.white,
                      thickness: 3,
                    ),
                    CommonExpansionWidget(
                        text: 'Lorem Ipsum question',
                        text2: 'This is tile number 1'),
                  Divider(
                      color: Colors.white,
                      thickness: 3,
                    ),
                    CommonExpansionWidget(
                        text: 'Lorem Ipsum question',
                        text2: 'This is tile number 1'),
                   Divider(
                      color: Colors.white,
                      thickness: 3,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CommonExpansionWidget extends StatefulWidget {
  final String text;
  final String text2;
  const CommonExpansionWidget(
      {super.key, required this.text, required this.text2});

  @override
  State<CommonExpansionWidget> createState() => _CommonExpansionWidgetState();
}

class _CommonExpansionWidgetState extends State<CommonExpansionWidget> {
  bool _customTileExpanded = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        widget.text,
        style: const TextStyle(color: Colors.white),
      ),
      trailing: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white, width: 3)),
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
      children: <Widget>[
        ListTile(
            title: Text(
          widget.text2,
          style: const TextStyle(color: Colors.white),
        )),
      ],
      onExpansionChanged: (bool expanded) {
        setState(() {
          _customTileExpanded = expanded;
        });
      },
    );
  }
}
