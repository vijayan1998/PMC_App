import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:pmc/src/Model/subscription.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Remembersubscription{
  static Future<void> saveRememberUser(SubscriptionPlan userInfo) async
  {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userJsonDate = jsonEncode(userInfo.toJson());
    await preferences.setString("currentUser", userJsonDate);
  }

  static Future<SubscriptionPlan?> readUser() async {
  SubscriptionPlan? currentUserInfo;
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? userInfo = preferences.getString("currentUser");

  if (userInfo != null) {
    try {
      Map<String, dynamic> userDataMap = jsonDecode(userInfo);
      currentUserInfo = SubscriptionPlan.fromJson(userDataMap);
    } catch (e) {
      if (kDebugMode) {
        print('Error decoding user data: $e');
      }
    }
  }
  return currentUserInfo;
}


  static Future<void> removeUserInfo() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("currentUser");
    
  }
}