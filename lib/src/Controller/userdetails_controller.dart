import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pmc/src/Controller/Auth/api_url.dart';
import 'package:pmc/src/Model/getusermodel.dart';
import 'package:http/http.dart' as http;
import 'package:pmc/src/Model/usermodel.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';
import 'package:pmc/src/Views/Sharedpreference/user_preference.dart';

class UserdetailsController extends GetxController{
 
 String userImageUrl ='';
 Future<List<GetUserModel>> getUsers(String id) async { 
  try {
    final response = await http.get(Uri.parse("${ApiUrl.getuserId}?id=$id"));
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['success']) {
        if (responseData.containsKey('user') && responseData['user'] is Map) {
          // Wrap the single user object in a list to maintain compatibility
          final List<GetUserModel> users = [
            GetUserModel.fromJson(responseData['user'])
          ];
          return users;
        } else {
          throw Exception('Key "user" not found or is not an object.');
        }
      } else {
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception('Failed to load users: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('Error fetching users: $error');
  }
}

Future<void> updateEmail(String email,String phone) async {
  final response = await http.post(Uri.parse("${ApiUrl.updateEmail}?phone=$phone"),
  headers: {'Content-Type' : 'application/json'},
  body: jsonEncode({
    'email':email,
  }));

  if(response.statusCode == 200){
    var data = json.decode(response.body);
    if(data['success']){
       // Parse user info
        Usermodel parentInfo = Usermodel.fromJson(data);
        // Save user info to shared preferences
        await RememberUserPrefs.saveRememberUser(parentInfo);
      Fluttertoast.showToast(msg: 'Email updated successfully');
    Get.toNamed(Appnames.loginotp);
    }else{
      Fluttertoast.showToast(msg: 'Invalid Number');
    }
    
  }
} 

Future<void> uploadImage(String name, String user, String image) async {
  
  try {
    final response = await http.post(
      Uri.parse(ApiUrl.uploadimages),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': name,
        'user': user,
        'image': image,  // Assuming image is a base64 string or a URL.
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Success response
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (kDebugMode) {
        print('Image uploaded successfully: ${responseData['image']}');
      }
    } else {
      // Handle failure
      final Map<String, dynamic> errorData = json.decode(response.body);
      if (kDebugMode) {
        print('Error: ${errorData['message']}');
      }
    }
  } catch (error) {
    if (kDebugMode) {
      print('An error occurred: $error');
    }
  }
}

 Future<String?> getImageById(String id) async {
  try {
    final response = await http.get(Uri.parse("${ApiUrl.getImageId}?user=$id"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body); // Print the raw response for debugging
      if (data['success']) {
        // Return the base64 image string
        return data['user']['image'];
      } else {
        debugPrint('Failed to fetch image: ${data['message']}');
      }
    } else {
      debugPrint('Failed to load image. Status code: ${response.statusCode}');
    }
  } catch (error) {
    debugPrint('Error: $error');
  }
  return null; // Return null if fetching fails
}

Future<void> updatePhone(String phone,String email) async {
  final response = await http.post(Uri.parse("${ApiUrl.updatePhone}?email=$email"),
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
       RememberUserPrefs.saveRememberUser(parentInfo);
      Fluttertoast.showToast(msg: 'Phone updated successfully');
    
    }else{
      Fluttertoast.showToast(msg: 'Invalid Number');
    }
  }
}
} 