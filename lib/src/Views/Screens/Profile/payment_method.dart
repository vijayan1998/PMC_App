import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pmc/src/Controller/Auth/api_url.dart';
import 'package:pmc/src/Views/Screens/Profile/paymentwebview.dart';
import 'package:pmc/src/Views/Screens/navigator_screen.dart';
import 'package:pmc/src/Views/Sharedpreference/user_controller.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/back_arrow_widget.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final String? plan;
  final String? course;
  final String? amount;
  const PaymentScreen({super.key, this.plan, this.course, this.amount});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String stripePlanIdOne = 'price_1Pd8mq01PbsRdqnLHOa9bhU1';
  String stripePlanIdTwo = 'price_1PfbZK01PbsRdqnLRiN4vScM';
  UserController currentUser = Get.put(UserController());
  Razorpay razorpay = Razorpay();
  void handlePaymentError(PaymentFailureResponse response) {
    AwesomeDialog(
      context: context,
      animType: AnimType.leftSlide,
      headerAnimationLoop: false,
      dialogType: DialogType.error,
      showCloseIcon: true,
      title: 'Error',
      desc: 'Payment not sending',
      btnOkOnPress: () {
        Navigator.pop(context);
      },
    ).show();
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    AwesomeDialog(
      context: context,
      animType: AnimType.leftSlide,
      headerAnimationLoop: false,
      dialogType: DialogType.success,
      showCloseIcon: true,
      title: 'Success',
      desc: 'External Wallet',
      btnOkOnPress: () {
        // Navigator.pushNamedAndRemoveUntil(context, Appnames.subscribePlanDetails, (route) => false);
      },
    ).show();
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    // String todayDate = DateFormat('yMd').format(DateTime.now());
    AwesomeDialog(
      context: context,
      animType: AnimType.leftSlide,
      headerAnimationLoop: false,
      dialogType: DialogType.success,
      showCloseIcon: true,
      title: 'Success',
      desc: 'Success Payment.',
      btnOkOnPress: () async {
        print('resdjs:${response.paymentId.toString()}');
       final formData = {
                    "subscriberId": response.paymentId.toString(),
                    "user": currentUser.user.id.toString(),
                    "plan": widget.plan,
                    "method": "Razorpay",
                    "fname": currentUser.user.fname.toString(),
                    "lname": currentUser.user.lname.toString(),
                    "email": currentUser.user.email.toString(),
                    "phone": currentUser.user.phone.toString(),
                    "amount": widget.amount,
                    "course": widget.course,
                  };
            final subscriptionResponse = await http.post(Uri.parse(ApiUrl.subscriptionPost),
             headers: {"Content-Type": "application/json"},
             body: jsonEncode(formData));
             if(subscriptionResponse.statusCode == 200){
              final subscriptionData =
                        jsonDecode(subscriptionResponse.body);
                    if (kDebugMode) {
                      print(subscriptionData);
                    }
                  // Data for the third POST request
                    final countPlanData = {
                      "user": currentUser.user.id.toString(),
                      "count": widget.course.toString(),
                    };
                    final countPlanResponse = await http.post(
                      Uri.parse(ApiUrl.subscriptionCount),
                      headers: {"Content-Type": "application/json"},
                      body: jsonEncode(countPlanData),
                    );
                    if (countPlanResponse.statusCode == 200) {
                      final countPlanResult =
                          jsonDecode(countPlanResponse.body);
                      if (kDebugMode) {
                        print(countPlanResult);
                      }
                    // ignore: use_build_context_synchronously
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NavigatorScreen(index: 0)));
                    }
             }
        
      },
    ).show();
  }
  @override
  void initState(){
    super.initState();
  }

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
          'Subscription',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ),
        elevation: 12,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                var cost = int.parse(widget.amount.toString());
                var options = {
                  'key': 'rzp_test_1NSzT7RcAdDnzD',
                  'amount': cost * 100,
                  'name': 'Pickmycourse.',
                  "currency":"INR",
                  'description': 'PickMyCourse Subscription',
                  "image":"https://hackwittechnologies.com/assets/imgs/pmclogo.png",
                  'retry': {'enabled': true, 'max_count': 1},
                  'send_sms_hash': true,
                  'prefill': {
                    'contact': currentUser.user.phone.toString(),
                    'email': currentUser.user.email.toString()
                  },
                  'external': {
                    'wallets': ['paytm']
                  }
                };
                razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
                razorpay.on(
                    Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
                razorpay.on(
                    Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
                razorpay.open(options);
              },
              child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    image: const DecorationImage(
                      image: AssetImage(AppImages.razorpay),
                      scale: 20.0,
                    )),
              ),
            ),
            24.vspace,
            InkWell(
              onTap: () async {
                String planId = stripePlanIdOne;
                if (widget.amount == 'Monthly Plan') {
                  planId = stripePlanIdTwo;
                }

                final dataToSend = {
                  'planId': planId,
                };

                try {
                  final response = await http.post(
                    Uri.parse(
                        'https://pickmycourse.onrender.com/api/stripepayment'),
                    headers: {'Content-Type': 'application/json'},
                    body: jsonEncode(dataToSend),
                  );

                  if (response.statusCode == 200) {
                    final data = jsonDecode(response.body);
                    final stripeUrl = data['url'];
                    final stripeId = data['id'];
                    // Open WebView to display Stripe Checkout
                    Navigator.push(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentWebView(
                            stripeId: stripeId,
                            plan: widget.plan.toString(),
                            amount: widget.amount.toString(),
                            course: widget.course.toString(),
                            url: stripeUrl),
                      ),
                    );
                  } else {
                    throw 'Failed to create a payment session.';
                  }
                } catch (e) {
                  if (kDebugMode) {
                    print('Error: $e');
                  }
                }
              },
              child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    image: const DecorationImage(
                      image: AssetImage(AppImages.stripe),
                      scale: 20.0,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
