import 'package:get/get.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';
import 'package:pmc/src/Views/Screens/OnBoard/login_otp.dart';
import 'package:pmc/src/Views/Screens/OnBoard/login_screen.dart';
import 'package:pmc/src/Views/Screens/OnBoard/signup_otp.dart';
import 'package:pmc/src/Views/Screens/OnBoard/signup_screen.dart';
import 'package:pmc/src/Views/Screens/Profile/faq_screen.dart';
import 'package:pmc/src/Views/Screens/Profile/privacy_policy.dart';
import 'package:pmc/src/Views/Screens/Profile/terms_service.dart';
import 'package:pmc/src/Views/Screens/ai_chat_screen.dart';
import 'package:pmc/src/Views/Screens/course.dart';
import 'package:pmc/src/Views/Screens/course_content_type.dart';
import 'package:pmc/src/Views/Screens/generate_course1.dart';
import 'package:pmc/src/Views/Screens/home_screen.dart';
import 'package:pmc/src/Views/Screens/mycourse.dart';
import 'package:pmc/src/Views/Screens/navigator_screen.dart';
import 'package:pmc/src/Views/Screens/onboarding.dart';
import 'package:pmc/src/Views/Screens/profile.dart';
import 'package:pmc/src/Views/Screens/subscription.dart';
import 'package:pmc/src/Views/Screens/subtopic_name.dart';
import 'package:pmc/src/Views/Screens/topic_list.dart';
import 'package:pmc/src/Views/Screens/topic_type.dart';

class AppRoutes {
  static appRoutes() => [
    GetPage(
      name: Appnames.splash, 
      page: () =>const OnboardingScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade
      ),
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
      page: () => const NavigatorScreen(),
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
    page: () => const GenerateSubtopicCourse(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.leftToRightWithFade
    ),
    GetPage(name: Appnames.coursecontent, 
    page: () => const CourseContentType(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.leftToRightWithFade
    ),
    GetPage(name: Appnames.subtopicname, 
    page: () => const SubtopicName(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.leftToRightWithFade
    ),
    GetPage(name: Appnames.topicname, 
    page: () => const TopicType(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.leftToRightWithFade),
    GetPage(name: Appnames.topicList, 
    page: () => const TopicListScreen(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.leftToRightWithFade),
    GetPage(name: Appnames.aichatscreen, 
    page: () => const AiChatScreen(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.leftToRight)
  ];
}