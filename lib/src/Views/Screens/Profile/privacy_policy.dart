import 'package:flutter/material.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/back_arrow_widget.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
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
        title: Text('Privacy Policy',style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),),
        elevation: 12,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
              Text(
                'Last Updated on 23-05-2024',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
              16.vspace,
              Text(
                'Privacy Policy:',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
              Text(
                'Lorem ipsum is a dummy text used for type setting instead of real text only for demonstration purpose. Lorem ipsum is a dummy text used for type setting instead of real text only for demonstration purpose ',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
              Text(
                '.  Lorem Ipsum is dummy text',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
              Text(
                '.  Lorem Ipsum is dummy text',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
              16.vspace,
               Text(
                'Privacy Policy:',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
               Text(
                'Lorem ipsum is a dummy text used for type setting instead of real text only for demonstration purpose. Lorem ipsum is a dummy text used for type setting instead of real text only for demonstrtion purpose. Lorem ipsum is a dummy text used for type setting instead of real text only for demonstration purpose. Lorem ipsum is a dummy text used for type setting instead of real text only for demonstration purpose. Lorem ipsum is a dummy text used for type setting instead of real text only for demonstration purpose. Lorem ipsum is a dummy text used for type setting instead of real text only for demonstration purpose .',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
              16.vspace,
               Text(
                'Lorem ipsum is a dummy text used for type setting instead of real text only for demonstration purpose. Lorem ipsum is a dummy text used for type setting instead of real text only for demonstrtion purpose. Lorem ipsum is a dummy text used for type setting instead of real text only for demonstration purpose. Lorem ipsum is a dummy text used for type setting instead of real text only for demonstration purpose. Lorem ipsum is a dummy text used for type setting instead of real text only for demonstration purpose. Lorem ipsum is a dummy text used for type setting instead of real text only for demonstration purpose .',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
