import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pmc/src/Controller/stripe_controller.dart';
import 'package:pmc/src/Controller/subscription_controller.dart';
import 'package:pmc/src/Model/subget.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';
import 'package:pmc/src/Views/Screens/Profile/invoice.dart';
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
  void initState(){
    super.initState();
    subscriptionController.getUserLocation();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
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
                                 subscriptionController.country == 'IN' ? 'Amount: ₹ 0' : 'Amount: \$ 0',
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
                        child: Column(
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
                            subscriptionController.country == 'IN' ?'Amount:  ₹ ${subscription.amount}' :'Amount: \$ ${subscription.amount}',
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
                      );
                    }
                  },
                ),
                8.vspace,
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('Subscription History',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),),
                ),
                8.vspace,
                FutureBuilder<List<Subscriptionget>>(
                  future: subscriptionController.getSubscriptionList(currentUser.user.id.toString()), 
                  builder: (context,snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator());
                    }else if(snapshot.hasError){
                      return Center(child: Text('Error : ${snapshot.hasError}'),);
                    }else {
                    List<Subscriptionget> subscriptionlist = snapshot.data!;
                    return ListView.builder(
                      itemCount:subscriptionlist.length,
                      padding:const EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemBuilder: (context,index){
                          DateTime parsedDate = DateTime.parse(subscriptionlist[index].date.toString());
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(parsedDate);
                        return Container(
                           margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.only(
                            top: 8, left: 8, right: 8, bottom: 8),
                        width: MediaQuery.of(context).size.width,
                        color: const Color(0xff4C07F4).withOpacity(0.25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                 Text(
                              'Subscription : ${subscriptionlist[index].plan}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            Text(
                              'Subscription Expiry : $formattedDate',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                            Text(
                              'No of Courses : ${subscriptionlist[index].course}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                            8.vspace,
                            GradientButtonWidget(
                              text: 'View',
                              width:140,
                              onTap: () {   
                                Navigator.push(context, MaterialPageRoute(builder: (context) => InvoiceScreen(
                                  tax: subscriptionlist[index].tax.toString(), 
                                  amount: subscriptionlist[index].amount,
                                  plan: subscriptionlist[index].plan,
                                  method: subscriptionlist[index].method,
                                  date: formattedDate,
                                  subscription: subscriptionlist[index].subscription,
                                  subscriptionId: subscriptionlist[index].subscriberId,
                                  course: subscriptionlist[index].course.toString(),
                                  receiptId: subscriptionlist[index].recieptId,
                                  )));         
                              },
                            )
                              ],
                            ) 
                          ],
                        ),
                        );
                      });
                    }
                  })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
