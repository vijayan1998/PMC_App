import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pmc/src/Controller/Auth/api_url.dart';
import 'package:pmc/src/Model/usermodel.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';
import 'package:pmc/src/Views/Sharedpreference/user_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignupController extends GetxController{
String countryCode = "+91";
FirebaseAuth auth = FirebaseAuth.instance;
String verificationIdReceived = '';

Future<void> signup(
    String fname, String lname, String email, String phone, String dob) async {
  try {
    final response = await http.post(
      Uri.parse(ApiUrl.signup),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "fname": fname,
        "lname": lname,
        "email": email,
        "phone": phone,
        "dob": dob,
        "type": 'free',
        "company": 'test',
      }),
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      // Ensure `userId` exists in response
      if (json.containsKey('userId') && json['userId'] != null) {
        Usermodel parentInfo = Usermodel.fromJson(json);
        await RememberUserPrefs.saveRememberUser(parentInfo);
        Fluttertoast.showToast(msg: 'Register Successful');
        Get.toNamed(Appnames.subscription);
      } else {
        Fluttertoast.showToast(msg: 'User data missing in response');
      }
    } else {
      Fluttertoast.showToast(msg: 'Failed Registration');
    }
  } catch (e) {
    Fluttertoast.showToast(msg: 'An error occurred during registration');
  }
}


Future<void> signIn(String phone) async {
  final response = await http.post(Uri.parse(ApiUrl.signIn),
  headers: {'Content-Type' : 'application/json'},
  body: jsonEncode({
    'phone':phone,
  }));
  if(response.statusCode == 200){
    var data = json.decode(response.body);
    if(data['success']){
       // Parse user info
        Usermodel parentInfo = Usermodel.fromJson(data);
        // Save user info to shared preferences
        await RememberUserPrefs.saveRememberUser(parentInfo);
      Fluttertoast.showToast(msg: 'Login Successful');
    Get.toNamed(Appnames.navigator);
    }else{
      Fluttertoast.showToast(msg: 'Invalid Number');
    }
    
  }
}

Future userVerifyPhone(String phone) async { 
   auth.verifyPhoneNumber(
    phoneNumber: '$countryCode$phone',
    verificationCompleted: (PhoneAuthCredential credential) async {
      // await auth.signInWithCredential(credential).then((value) {});
    },
   
    verificationFailed: (FirebaseAuthException exception) {
    
    },
    codeSent: (String verifiactionId, int? resentToken) {
      verificationIdReceived = verifiactionId;
    },
    codeAutoRetrievalTimeout: (String verificationId) {},
  );
}

Future<bool> verifyCode(String pin) async {
  PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationIdReceived, smsCode: pin);

  try {
    await auth.signInWithCredential(credential);
    return true;
  } catch (e) {
    return false;
  }
}

Future<void> deleteUser(String id) async{
  final response = await http.delete(Uri.parse("${ApiUrl.accountDelete}?id=$id"));
  if(response.statusCode == 200){
    Fluttertoast.showToast(msg: 'Deleted Successfully');
    Get.toNamed(Appnames.login);
  }else{
    debugPrint('Failed to delete account status code: ${response.body}');
  }
}
}