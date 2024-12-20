import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pmc/src/Controller/Auth/api_url.dart';
import 'package:pmc/src/Model/subget.dart';
import 'package:pmc/src/Model/subscription_model.dart';
import 'package:http/http.dart' as http;
import 'package:pmc/src/Views/Sharedpreference/user_controller.dart';

class SubscriptionController extends GetxController{
  List<dynamic> countPlans = <dynamic>[].obs;
  UserController currentUser = Get.put(UserController());

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


}