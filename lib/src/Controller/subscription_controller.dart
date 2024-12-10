import 'dart:convert';
import 'package:get/get.dart';
import 'package:pmc/src/Controller/Auth/api_url.dart';
import 'package:pmc/src/Model/subget.dart';
import 'package:pmc/src/Model/subscription_model.dart';
import 'package:http/http.dart' as http;

class SubscriptionController extends GetxController{

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
        return Subscriptionget.fromJson(data['sub'][0]);
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

}