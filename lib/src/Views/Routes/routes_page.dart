import 'package:get/get.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';
import 'package:pmc/src/Views/Screens/OnBoard/login_otp.dart';
import 'package:pmc/src/Views/Screens/OnBoard/login_screen.dart';
import 'package:pmc/src/Views/Screens/OnBoard/onboarding2.dart';
import 'package:pmc/src/Views/Screens/OnBoard/onboarding3.dart';
import 'package:pmc/src/Views/Screens/OnBoard/signup_otp.dart';
import 'package:pmc/src/Views/Screens/OnBoard/signup_screen.dart';
import 'package:pmc/src/Views/Screens/Profile/certificate_view.dart';
import 'package:pmc/src/Views/Screens/Profile/edit_profile.dart';
import 'package:pmc/src/Views/Screens/Profile/faq_screen.dart';
import 'package:pmc/src/Views/Screens/Profile/help.dart';
import 'package:pmc/src/Views/Screens/Profile/helpview.dart';
import 'package:pmc/src/Views/Screens/Profile/myceritificate.dart';
import 'package:pmc/src/Views/Screens/Profile/notifications.dart';
import 'package:pmc/src/Views/Screens/Profile/privacy_policy.dart';
import 'package:pmc/src/Views/Screens/Profile/raise_ticket.dart';
import 'package:pmc/src/Views/Screens/Profile/terms_service.dart';
import 'package:pmc/src/Views/Screens/home_screen.dart';
import 'package:pmc/src/Views/Screens/Profile/mycourse.dart';
import 'package:pmc/src/Views/Screens/navigator_screen.dart';
import 'package:pmc/src/Views/Screens/OnBoard/onboarding.dart';
import 'package:pmc/src/Views/Screens/new_screens/ai_chat_screen.dart';
import 'package:pmc/src/Views/Screens/new_screens/generative_course.dart';
import 'package:pmc/src/Views/Screens/new_screens/generative_course1.dart';
import 'package:pmc/src/Views/Screens/new_screens/topic_type.dart';
import 'package:pmc/src/Views/Screens/profile.dart';
import 'package:pmc/src/Views/Screens/subscription.dart';
import 'package:pmc/src/Views/Screens/subtopic_name.dart';


class AppRoutes {
  static appRoutes() => [
    GetPage(
      name: Appnames.splash, 
      page: () =>const OnboardingScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade
      ),
    GetPage(
      name: Appnames.splash2, 
      page: () => const OnboardingScreen2(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),
    GetPage(
      name: Appnames.splash3, 
      page: () => const OnboardingScreen3(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 250)),
    GetPage(name: Appnames.login, 
    page: () => const LoginScreen(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.leftToRightWithFade
    ),
    GetPage(name: Appnames.loginotp, 
    page: () => const LoginOtpScreen(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: Appnames.register, 
      page: () => const SignupScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade
      ),
    GetPage(
      name: Appnames.registerotp, 
      page: () =>  const SignupOtpScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),
    GetPage(
      name: Appnames.subscription, 
      page: () => const SubscriptionScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),
    GetPage(
      name: Appnames.navigator, 
      page: () =>  NavigatorScreen(index: 0,),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),
    GetPage(name: Appnames.home, 
    page: () => const HomeScreen(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.leftToRightWithFade),
    GetPage(name: Appnames.course, 
    page: () => const MyCoursePage(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.leftToRightWithFade),
    GetPage(name: Appnames.profile, 
    page: () => const ProfilePage(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.leftToRightWithFade),
    GetPage(name: Appnames.faq, 
    page: () => const FaqScreen(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.leftToRightWithFade),
    GetPage(name: Appnames.termsofservice, 
    page: () =>const  TermsServiceScreen(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.leftToRightWithFade,
    ),
    GetPage(name: Appnames.privacypolice, 
    page: () => const PrivacyPolicyScreen(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.leftToRightWithFade),
    GetPage(name: Appnames.course1, 
    page: () => const GenerateCourse(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.leftToRightWithFade),
    GetPage(name: Appnames.course2, 
    page: () => const GenerateCourse1(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.leftToRightWithFade
    ),
    GetPage(name: Appnames.subtopicname, 
    page: () => const SubtopicName(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.leftToRightWithFade
    ),
    GetPage(name: Appnames.topicname, 
  //  page: () => const TopicType(),
    page: () => const TopicType(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.leftToRightWithFade),
    GetPage(name: Appnames.aichatscreen, 
    page: () => const AiChatScreen(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.leftToRight),
    GetPage(name: Appnames.notifications, 
    page: () => const NotificationsScreen(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.leftToRight),
    GetPage(name: Appnames.help, 
    page: () => const HelpandSupport(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.leftToRight),
    GetPage(name: Appnames.helpview, 
    page: () => const HelpViewScreen(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.leftToRight),
    GetPage(name: Appnames.mycertificate, 
    page: () => const Myceritificate(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.leftToRight),
    GetPage(name: Appnames.certificateView, 
    page: () => const CertificateViewScreen(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.leftToRight),
    GetPage(name: Appnames.edit, 
    page: () => const EditScreen(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.leftToRight),
    GetPage(name: Appnames.raise, 
    page: () => const RaiseTicketScreen(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.leftToRight),
  ];
}