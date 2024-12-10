import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:pmc/src/Controller/Auth/api_url.dart';
import 'package:pmc/src/Controller/stripe_controller.dart';
import 'package:pmc/src/Controller/subscription_controller.dart';
import 'package:pmc/src/Views/Screens/navigator_screen.dart';
import 'package:pmc/src/Views/Sharedpreference/user_controller.dart';
import 'package:pmc/src/Views/Widget/back_arrow_widget.dart';

class PaymentWebView extends StatefulWidget {
  final String url;
  final String plan;
  final String amount;
  final String course;
  final String stripeId;

  const PaymentWebView({
    super.key,
    required this.url,
    required this.plan,
    required this.amount,
    required this.course,
    required this.stripeId,
  });

  @override

  // ignore: library_private_types_in_public_api
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late InAppWebViewController webViewController;
  StripeController stripeController = Get.put(StripeController());
  UserController userController = Get.put(UserController());
  SubscriptionController subscriptionController =
      Get.put(SubscriptionController());
  @override
  void initState() {
    super.initState();
    userController.getUserInfo();
    // Initialize the InAppWebView controller
    InAppWebViewController.setWebContentsDebuggingEnabled(
        true); // For debugging purposes
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ),
        body: InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(widget.url)),
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          onLoadStop: (controller, url) {
            // You can perform actions when the page finishes loading
          },
          onLoadError: (controller, url, code, message) {
            if (kDebugMode) {
              print('Error loading page: $message');
            }
          },
          onLoadHttpError: (controller, url, statusCode, description) {
            if (kDebugMode) {
              print('HTTP error: $description');
            }
          },
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            final uri = navigationAction.request.url;
            if (uri.toString().contains('success')) {
              final datatoSend = {
                "subscriberId": widget.stripeId,
                "plan": widget.plan,
                "uid": userController.user.id.toString(),
              };
              try {
                final response = await http.post(Uri.parse(ApiUrl.stipedetails),
                    headers: {"Content-Type": "application/json"},
                    body: jsonEncode(datatoSend));
                if (response.statusCode == 200) {
                  final stripeData = jsonDecode(response.body);
                  final customerId = stripeData['customer'];
                  // Data for the second POST request
                  final formData = {
                    "subscriberId": customerId,
                    "user": userController.user.id.toString(),
                    "plan": widget.plan,
                    "method": "stripe",
                    "fname": userController.user.fname.toString(),
                    "lname": userController.user.lname.toString(),
                    "email": userController.user.email.toString(),
                    "phone": userController.user.phone.toString(),
                    "amount": widget.amount,
                    "course": widget.course,
                  };
                  // Second POST request
                  final subscriptionResponse = await http.post(
                    Uri.parse(ApiUrl.subscriptionPost),
                    headers: {"Content-Type": "application/json"},
                    body: jsonEncode(formData),
                  );
                  
                  if (subscriptionResponse.statusCode == 200) {
                    final subscriptionData =
                        jsonDecode(subscriptionResponse.body);
                    if (kDebugMode) {
                      print(subscriptionData);
                    }
                    // Data for the third POST request
                    final countPlanData = {
                      "user": userController.user.id.toString(),
                      "count": widget.course,
                    };
                    // Third POST request
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
                }
              } catch (e) {
                if (kDebugMode) {
                  print('Error: $e');
                }
              }
              // Handle successful payment here
              // Get.toNamed(Appnames.navigator);
              return NavigationActionPolicy.CANCEL;
            } else if (uri.toString().contains('cancel')) {
              // Handle canceled payment here
              Navigator.pop(context);
              return NavigationActionPolicy.CANCEL;
            }
            return NavigationActionPolicy.ALLOW;
          },
        ));
  }
}
