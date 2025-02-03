
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmc/src/Controller/signup_controller.dart';
import 'package:pmc/src/Controller/stripe_controller.dart';
import 'package:pmc/src/Controller/subscription_controller.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';
import 'package:pmc/src/Views/Screens/Profile/payment_method.dart';
import 'package:pmc/src/Views/Sharedpreference/user_controller.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/gradient_button.dart';
import 'package:pmc/src/Views/Widget/subscription_widget.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  StripeController stripeController = Get.put(StripeController());
  SignupController signupController = Get.put(SignupController());
  SubscriptionController subscriptionController =
      Get.put(SubscriptionController());
  UserController currentUser = Get.put(UserController());
  String stripePlanIdOne = 'price_1Pd8mq01PbsRdqnLHOa9bhU1';
  String stripePlanIdTwo = 'price_1PfbZK01PbsRdqnLRiN4vScM';
  @override
  void initState(){
    super.initState();
    subscriptionController.getUserLocation();    
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // color: Color(0xff300080),
        image: DecorationImage(
          image: AssetImage(AppImages.background2),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 36,
                      left: MediaQuery.of(context).size.width / 14,
                      right: MediaQuery.of(context).size.width / 14),
                  child: Image.asset(
                    AppImages.logo,
                  ),
                ),
                16.vspace,
                FutureBuilder(
                    future: subscriptionController.subscriptionPlans(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error : ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                            child: Text(
                          'No Subscription Plans',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: Colors.white,
                                  ),
                        ));
                      } else {
                        final plans = snapshot.data!;
                        return ListView.builder(
                            shrinkWrap: true,
                            physics:const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(0),
                            itemCount: plans.length,
                            itemBuilder: (context, index) {
                              return SubscriptionWidget(
                                  width: MediaQuery.of(context).size.width,
                                  text1: plans[index].packagename,
                                  text2: subscriptionController.country == 'IN' ? '₹ ${plans[index].price}' :'\$ ${plans[index].price}' ,
                                  text3: plans[index].course.toString(),
                                  text4: plans[index].subtopic,
                                  text5: 'AI Teacher',
                                  text7: plans[index].coursetype,
                                  text6: 'Video & Image Course',
                                  buttonwidget: GradientButtonWidget(
                                    text: 'Select',
                                    width: 100,
                                    onTap: () async {
                                    plans[index].price == '0'?  
                                    Get.toNamed(Appnames.navigator) 
                                  : Navigator.push(context, MaterialPageRoute(builder: (context) =>  PaymentScreen(
                                        plan: plans[index].packagename,
                                        amount: plans[index].price.toString(),
                                        course: plans[index].course.toString(),
                                        tax: plans[index].tax,
                                        inr: plans[index].inr,
                                      )
                                      )
                                      );
                                      
                                     
                                    },
                                  ));
                            });
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
