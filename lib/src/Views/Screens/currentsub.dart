import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmc/src/Controller/stripe_controller.dart';
import 'package:pmc/src/Controller/subscription_controller.dart';
import 'package:pmc/src/Model/subget.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';
import 'package:pmc/src/Views/Screens/navigator_screen.dart';
import 'package:pmc/src/Views/Sharedpreference/user_controller.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/gradient_button.dart';

class SubGet extends StatefulWidget {
  const SubGet({super.key});

  @override
  State<SubGet> createState() => _SubGetState();
}

class _SubGetState extends State<SubGet> {
  StripeController stripeController = Get.put(StripeController());
  SubscriptionController subscriptionController =
      Get.put(SubscriptionController());
  UserController currentUser = Get.put(UserController());
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
                    padding: const EdgeInsets.only(top: 36),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NavigatorScreen(index: 2)));
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 8),
                        alignment: Alignment.center,
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 18,
                        ),
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      top: 16,
                      left: MediaQuery.of(context).size.width / 14,
                      right: MediaQuery.of(context).size.width / 14),
                  child: Image.asset(
                    AppImages.logo,
                  ),
                ),
                16.vspace,
                FutureBuilder<Subscriptionget?>(
                  future: subscriptionController
                      .getSubscriptionByUserId(currentUser.user.id.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return  Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.only(
                            top: 8, left: 8, right: 8, bottom: 8),
                        width: MediaQuery.of(context).size.width,
                        color: const Color(0xff4C07F4).withOpacity(0.25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Current Plan',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Text(
                               'Free',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Text(
                                  'Amount: ₹0',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                8.vspace,
                                GradientButtonWidget(
                                  text: 'Change/Upgrade Plan',
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  onTap: () {
                                    Get.toNamed(Appnames.subscription);
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      final subscription = snapshot.data!;
                      return Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.only(
                            top: 8, left: 8, right: 8, bottom: 8),
                        width: MediaQuery.of(context).size.width,
                        color: const Color(0xff4C07F4).withOpacity(0.25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Current Plan',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Text(
                               subscription.plan,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Text(
                                  'Amount: ₹${subscription.amount}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                8.vspace,
                                GradientButtonWidget(
                                  text: 'Change/Upgrade Plan',
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  onTap: () {
                                    Get.toNamed(Appnames.subscription);
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
