import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pmc/src/Controller/Auth/api_url.dart';
import 'package:pmc/src/Model/subget.dart';
import 'package:pmc/src/Model/subscription_model.dart';
import 'package:http/http.dart' as http;
import 'package:pmc/src/Views/Sharedpreference/user_controller.dart';

class SubscriptionController extends GetxController{
  List<dynamic> countPlans = <dynamic>[].obs;
  UserController currentUser = Get.put(UserController());
   String keyId = 'rzp_test_9G0AuysSgQi4b2';
  String keySecret = '209THtmJVeyiJJXvHE20LfjJ';
  String apiUrl = 'https://api.razorpay.com/v1/orders';
  String country = '';
  double? conversionRate;

Future<List<SubscriptionModel>> subscriptionPlans() async {
 
  try {
    final response = await http.get(Uri.parse(ApiUrl.subscriptionPlan));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true && data['plans'] != null) {
        List<dynamic> plansJson = data['plans'];
        return plansJson.map((plan) => SubscriptionModel.fromJson(plan)).toList();
      } else {
        throw Exception('Failed to fetch subscription plans');
      }
    } else {
      throw Exception('Server error: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('Error fetching subscription plans: $error');
  }
}


Future<Subscriptionget?> getSubscriptionByUserId(String userId) async {
  try {
    final url = Uri.parse('${ApiUrl.getsubscription}?user=$userId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success'] && data['sub'].isNotEmpty) {
       // Fetch the last subscription from the list
        final lastSubscription = data['sub'].last;
        return Subscriptionget.fromJson(lastSubscription);
      } else {
        return null;
      }
    } else {
      throw Exception('Server error: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error fetching subscription plans: $e');
  }
}

Future<List<dynamic>> getCount() async {
  final response = await http.get(
    Uri.parse("${ApiUrl.getupdateCount}?user=${currentUser.user.id.toString()}"),
  );
  if (response.statusCode == 200) {
    final countPlans = jsonDecode(response.body);
    return countPlans; // Return the parsed data
  } else {
    if (kDebugMode) {
      print('Failed to load data :${response.body}');
    }
    throw Exception('Failed to fetch data');
  }
}

// Function to create an order
  Future createOrder(int tax) async {
       double taxRate = tax / 100;
    double taxAmount = conversionRate! * taxRate;
    double totalWithTax = conversionRate! + taxAmount; 
    // print('shfk:$totalWithTax');
      // Round the total amount to the nearest whole number
  int roundedTotal = totalWithTax.round();
  //  print('shfsdgk:$roundedTotal');
    final basicAuth =
        'Basic ${base64Encode(utf8.encode('$keyId:$keySecret'))}'; // Base64 Encoding for Basic Auth

    final Map<String, dynamic> orderData = {
      'amount': (roundedTotal * 100).toInt(),
      'currency': 'INR',
    };
    // print('sdks:$orderData');
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': basicAuth,
        },
        body: jsonEncode(orderData),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData['id']; // Return the response data
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> getUserLocation() async {
    try {
      // Request location permission
      var status = await Permission.location.request();

      if (status.isGranted) {
        // Permission granted, get location
        Position position = await Geolocator.getCurrentPosition(
          // ignore: deprecated_member_use
          desiredAccuracy: LocationAccuracy.medium,
        );

        // Reverse geocode to get the country code
        List<Placemark> placemarks =
            await placemarkFromCoordinates(position.latitude, position.longitude);
        String countryCode = placemarks.first.isoCountryCode ?? "Unknown";

        // setState(() {
          country = countryCode;
        // });
      } else if (status.isDenied) {
        // Permission denied, show message
        Fluttertoast.showToast(msg: 'Please Razorpay Amount');
      } else if (status.isPermanentlyDenied) {
        // Permission permanently denied, guide to app settings
       Fluttertoast.showToast(msg: 'Please Stripe payment');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error getting location: $e");
      }
    }
  }
  
  // convertCurrency code
  Future<void> convertCurrency(String amount, String from, String to) async {
     const String apiKey = "8ae590e70d4cf6c51b57bbae";
    final String url =
        "https://v6.exchangerate-api.com/v6/$apiKey/pair/$from/$to/$amount";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['result'] == "success") {
          // setState(() {
            conversionRate = data['conversion_result'];
          // });
        } else {
          if (kDebugMode) {
            print("Error fetching exchange rates: ${data['error']}");
          }
        }
      } else {
        if (kDebugMode) {
          print("HTTP error: ${response.statusCode}");
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error: $error");
      }
    }
  }

}