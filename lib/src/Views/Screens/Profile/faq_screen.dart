import 'package:flutter/material.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/back_arrow_widget.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
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
        title: Text('FAQ',style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),),
        elevation: 12,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 66,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.search, color: Colors.black, size: 26),
                    6.hspace,
                    Text(
                      'Search Your Topic',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.grey.shade800),
                    ),
                  ],
                ),
              ),
              16.vspace,
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.grey.withOpacity(0.75),
                    thickness: 2,
                  ),
                 const CommonExpansionWidget(
                      text: 'What is lorem Ipsum used for?',
                      text2: 'Lorem ipsum is a dummy text used for type setting instead of real text only for demonstration purpose. Lorem ipsum is a dummy text used for type setting instead of real text only for demonstration purpose'),
                   Divider(
                    color: Colors.grey.withOpacity(0.75),
                    thickness: 2,
                  ),
                 const CommonExpansionWidget(
                      text: 'What is lorem Ipsum used for?',
                      text2: 'Lorem ipsum is a dummy text used for type setting instead of real text only for demonstration purpose. Lorem ipsum is a dummy text used for type setting instead of real text only for demonstration purpose'),
                    Divider(
                    color: Colors.grey.withOpacity(0.75),
                    thickness: 2,
                  ),
                 const CommonExpansionWidget(
                      text: 'What is lorem Ipsum used for?',
                      text2: ' Lorem ipsum is a dummy text used for type setting instead of real text only for demonstration purpose. Lorem ipsum is a dummy text used for type setting instead of real text only for demonstration purpose'),
                  Divider(
                    color: Colors.grey.withOpacity(0.75),
                    thickness: 2,
                  ),
                const  CommonExpansionWidget(
                      text: 'What is lorem Ipsum used for?',
                      text2: ' Lorem ipsum is a dummy text used for type setting instead of real text only for demonstration purpose. Lorem ipsum is a dummy text used for type setting instead of real text only for demonstration purpose'),
                       Divider(
                    color: Colors.grey.withOpacity(0.75),
                    thickness: 2,
                  ),
                ],
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
        style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.white),
      ),
      trailing: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white),
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
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      children: <Widget>[
        ListTile(
            title: Text(
          widget.text2,
          style:Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.white),
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
