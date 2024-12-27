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
                '1. Introduction',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              7.vspace,
              Text(
                'At Pick My Course, we value your privacy and are committed to protecting your personal information. This Privacy Policy outlines how we collect, use, and safeguard your data.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              16.vspace,
              Text(
                '2. Information We Collect',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              8.vspace,
              Text(
                '. Account Information: Name, email address, and password during registration.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              Text(
                '. Usage Data: Details of your interactions with the app, such as courses generated and subscription status',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
               Text(
                '. Payment Information: When subscribing to a plan, payment details are processed securely by third-party payment gateways.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              16.vspace,
              Text(
                '3. How We Use Your Information',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              8.vspace,
              Text(
                '. To create and manage your account.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              Text(
                '. To generate courses based on your inputs.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
               Text(
                '. To provide customer support and respond to inquiries.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
               Text(
                '. To process subscription payments securely.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
               Text(
                '. To send notifications about account updates, offers, and platform changes.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              16.vspace,
              Text(
                '4. Data Sharing',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              8.vspace,
              Text(
                'Pick My Course does not sell or share your personal information with third parties, except as required by law or for platform functionality (e.g., payment gateways).',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              16.vspace,
              Text(
                '5. Data Security',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              8.vspace,
               Text(
                '. We use encryption and secure servers to protect your personal data.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              Text(
                '. Despite best efforts, no system is completely secure. Users are responsible for maintaining their account credentials.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
               16.vspace,
              Text(
                '6. Cookies and Tracking',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              8.vspace,
              Text(
                '. Pick My Course uses cookies to enhance user experience and analyze platform usage.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              Text(
                '. Users can manage cookie preferences through their browser settings.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
               16.vspace,
              Text(
                '7. User Rights',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              8.vspace,
              Text(
                '. Access, update, or delete your personal information by contacting support@pickmycourse.ai.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              Text(
                '. Opt out of marketing communications at any time.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
               16.vspace,
              Text(
                '8. Changes to Privacy Policy',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              8.vspace,
              Text(
                'Pick My Course reserves the right to update this Privacy Policy. Changes will be communicated through the app or email.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              16.vspace,
                 Text(
                '9. Contact Us',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              8.vspace,
              Text(
                ' If you have questions or concerns about your data, please contact us at support@pickmycourse.ai.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
            8.vspace,
              Text(
                'This Privacy Policy is effective as of the date of use.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
