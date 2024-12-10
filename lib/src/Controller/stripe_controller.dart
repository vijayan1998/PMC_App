import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pmc/src/Controller/Auth/api_url.dart';

class StripeController extends GetxController{

String stripePlanIdOne ='price_1Pd8mq01PbsRdqnLHOa9bhU1';
String stripePlanIdTwo = 'price_1PfbZK01PbsRdqnLRiN4vScM';
String stripeId = '';
String customerId ='';


// Future<void> startStripePayment(BuildContext context, String plan,) async {
//   String planId = stripePlanIdOne;
//   if (plan == 'Monthly Plan') {
//     planId = stripePlanIdTwo;
//   }

//   final dataToSend = {
//     'planId': planId,
//   };

//   try {
//     final response = await http.post(
//       Uri.parse('https://pickmycourse.onrender.com/api/stripepayment'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(dataToSend),
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//      final stripeUrl = data['url'];
//        stripeId = data['id'];
//       // Open WebView to display Stripe Checkout
//       // Navigator.push(
//       //   // ignore: use_build_context_synchronously
//       //   context,
//       //   MaterialPageRoute(
//       //     builder: (context) => PaymentWebView(url: stripeUrl),
//       //   ),
//       // );
//     } else {
//       throw 'Failed to create a payment session.';
//     }
//   } catch (e) {
//     if (kDebugMode) {
//       print('Error: $e');
//     }
//   }
// }

Future<void> getStripedetails(String userid,String fname,String lname,String email,String phone,String amount,
String course,String plan) async{
  final datatoSend ={
    "subscriberId": stripeId,
    "plan":plan,
    "uid":userid
  };
  try {
    final response = await http.post(Uri.parse(ApiUrl.stipedetails),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(datatoSend));
     if (response.statusCode == 200) {
        final stripeData = jsonDecode(response.body);
        customerId = stripeData['customer'];
         // Data for the second POST request
      final formData = {
        "subscriberId":customerId,
        "uid": userid,
        "plan": plan,
        "method": "stripe",
        "fname":fname,
        "lname": lname,
        "email": email,
        "phone":phone,
        "amount": amount,
        "course": course,
      };
            // Second POST request
      final subscriptionResponse = await http.post(
        Uri.parse(ApiUrl.subscriptionPost),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(formData),
      );

      if (subscriptionResponse.statusCode == 200) {
        final subscriptionData = jsonDecode(subscriptionResponse.body);
        if (kDebugMode) {
          print(subscriptionData);
        }

          // Data for the third POST request
        final countPlanData = {
          "user": userid,
          "count": '10',
        };
         // Third POST request
        final countPlanResponse = await http.post(
          Uri.parse(ApiUrl.subscriptionPlan),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(countPlanData),
        );

        if (countPlanResponse.statusCode == 200) {
          final countPlanResult = jsonDecode(countPlanResponse.body);
          if (kDebugMode) {
            print(countPlanResult);
          }
        }
      } 
      }
  } catch (e) {
       if (kDebugMode) {
      print('Error: $e');
    }
  }
} 

}