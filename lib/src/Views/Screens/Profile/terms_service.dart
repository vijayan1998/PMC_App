import 'package:flutter/material.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/back_arrow_widget.dart';

class TermsServiceScreen extends StatefulWidget {
  const TermsServiceScreen({super.key});

  @override
  State<TermsServiceScreen> createState() => _TermsServiceScreenState();
}

class _TermsServiceScreenState extends State<TermsServiceScreen> {
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
        title: Text(
          'Terms of Service',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ),
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
                'Welcome to Pick My Course! By using our platform, you agree to abide by these Terms and Conditions. These terms govern your use of our app and services, including course generation and subscription plans.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              16.vspace,
              Text(
                '2. Account Creation',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              8.vspace,
              Text(
                '. Users must create an account to access the services offered by Pick My Course',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              Text(
                '. Each account is personal and non-transferable. Sharing account credentials is strictly prohibited.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              16.vspace,
              Text(
                '3. Free Course Generation',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              8.vspace,
              Text(
                '. Upon registration, users can generate up to 3 courses for free.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              Text(
                '. Access to additional course generations requires a subscription to one of our paid plans.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              16.vspace,
              Text(
                '4. Subscription Plans',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              8.vspace,
              Text(
                '. Subscription details, pricing, and features are available within the app and on our website (pickmycourse.ai).',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              Text(
                '. Subscription payments are non-refundable.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              Text(
                '. Failure to renew your subscription will result in limited access to additional course generation features.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              16.vspace,
              Text(
                '5. User Responsibilities',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              8.vspace,
              Text(
                '. Users must provide accurate information during account registration.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              Text(
                '. Content generated through Pick My Course is for personal and educational purposes only.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              Text(
                '. Misuse of the platform for illegal or unethical activities is strictly prohibited.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
               16.vspace,
              Text(
                '6. Intellectual Property',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              8.vspace,
              Text(
                '. All AI-generated content remains the intellectual property of Pick My Course.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              Text(
                '. Users may use the generated courses for personal or professional learning purposes but cannot resell or redistribute them without written consent.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
               16.vspace,
              Text(
                '7. Termination of Services',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              8.vspace,
              Text(
                '. Pick My Course reserves the right to terminate accounts that violate these terms or misuse the platform.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              Text(
                '. Users can cancel their accounts at any time by contacting support@pickmycourse.ai.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              16.vspace,
                 Text(
                '8. Modifications to Terms',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              8.vspace,
              Text(
                '. Pick My Course may update these terms at any time. Users will be notified of significant changes through the app or email.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              16.vspace,
                 Text(
                '9. Governing Law',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              8.vspace,
              Text(
                '. These terms are governed by the laws of the jurisdiction where Pick My Course operates.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              16.vspace,
              Text(
                'For inquiries or support, contact us at support@pickmycourse.ai.',
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
