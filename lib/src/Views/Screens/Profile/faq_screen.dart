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
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   height: 66,
              //   padding: const EdgeInsets.all(8),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(12)
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       const Icon(Icons.search, color: Colors.black, size: 26),
              //       6.hspace,
              //       Text(
              //         'Search Your Topic',
              //         style: Theme.of(context)
              //             .textTheme
              //             .bodySmall!
              //             .copyWith(color: Colors.grey.shade800),
              //       ),
              //     ],
              //   ),
              // ),
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
                      text: '1. What is Pick My Course?',
                      text2: 'Pick My Course is an AI-powered course generator that allows users to create personalized courses by simply entering topics and subtopics. It uses advanced AI algorithms to provide structured course content, including text, images, and multimedia, for effective learning.'),
                   Divider(
                    color: Colors.grey.withOpacity(0.75),
                    thickness: 2,
                  ),
                 const CommonExpansionWidget(
                      text: '2. How does the free plan work?',
                      text2: 'With the free plan, you can create up to 3 courses without any charges. To generate additional courses, you will need to subscribe to one of our premium plans.'),
                    Divider(
                    color: Colors.grey.withOpacity(0.75),
                    thickness: 2,
                  ),
                 const CommonExpansionWidget(
                      text: '3. What features are included in the premium plans?',
                      text2: 'Premium plans provide unlimited course creation, access to advanced multimedia resources, customizable course templates, and priority customer support. Details of the subscription plans are available in the app.'),
                  Divider(
                    color: Colors.grey.withOpacity(0.75),
                    thickness: 2,
                  ),
                const CommonExpansionWidget(
                      text: '4. How do I subscribe to a premium plan?',
                      text2: 'You can subscribe to a premium plan by navigating to the subscription section in the app. Select the desired plan and follow the instructions to complete the payment.'),
                       Divider(
                    color: Colors.grey.withOpacity(0.75),
                    thickness: 2,
                  ),
                const CommonExpansionWidget(
                      text: '5. Can I use the courses for commercial purposes?',
                      text2: 'Courses generated through Pick My Course are intended for personal or professional educational purposes. Redistribution or resale of the content without prior consent is prohibited.'),
                       Divider(
                    color: Colors.grey.withOpacity(0.75),
                    thickness: 2,
                  ),
                const CommonExpansionWidget(
                      text: '6. Is the app available on both Android and iOS?',
                      text2: 'Yes, Pick My Course is available on both Android and iOS platforms. You can download it from the Google Play Store or Apple App Store.'),
                       Divider(
                    color: Colors.grey.withOpacity(0.75),
                    thickness: 2,
                  ),
                const CommonExpansionWidget(
                      text: '7. What payment methods are accepted for subscriptions?',
                      text2: 'We accept all major credit cards, debit cards, and digital wallets through secure payment gateways.'),
                       Divider(
                    color: Colors.grey.withOpacity(0.75),
                    thickness: 2,
                  ),
                const CommonExpansionWidget(
                      text: '8. Can I cancel my subscription?',
                      text2: 'Yes, you can cancel your subscription at any time through the app. Note that cancellations will take effect at the end of the current billing cycle, and no refunds are issued for partial periods.'),
                       Divider(
                    color: Colors.grey.withOpacity(0.75),
                    thickness: 2,
                  ),
                 const CommonExpansionWidget(
                      text: '9. What should I do if I face an issue with the app?',
                      text2: 'If you encounter any issues or need assistance, please contact our support team at support@pickmycourse.ai. We are here to help!'),
                       Divider(
                    color: Colors.grey.withOpacity(0.75),
                    thickness: 2,
                  ),
                   const CommonExpansionWidget(
                      text: '10. Can I share my account with others?',
                      text2: 'No, account sharing is not allowed. Each account is personal and tied to the registered user\'s email..'),
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
          style:Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
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
