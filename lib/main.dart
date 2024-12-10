import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:pmc/src/Views/Routes/routes_page.dart';
import 'package:pmc/src/Views/Screens/OnBoard/onboarding.dart';
import 'package:pmc/src/Views/Screens/navigator_screen.dart';
import 'package:pmc/src/Views/Sharedpreference/user_preference.dart';
import 'package:pmc/src/Views/Utilies/theme.dart';
import 'package:pmc/src/Views/const.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Set publishable key
  Stripe.publishableKey = stripePublishableKey;
  await Firebase.initializeApp(
  );
  
   SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]
  );
  SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PickMyCourse',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme:AppTheme.lightTheme,  
       getPages: AppRoutes.appRoutes(),
        defaultTransition: Transition.leftToRightWithFade,
      home: FutureBuilder(
        future: RememberUserPrefs.readUser(), 
        builder: (BuildContext context,AsyncSnapshot<dynamic> snapshot){
          if(snapshot.data == null){
            return const OnboardingScreen();
          }else {
            return NavigatorScreen(index:0);
          }
        }),
    );
  }
}






