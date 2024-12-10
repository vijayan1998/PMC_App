import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pmc/src/Controller/Auth/api_url.dart';
import 'package:pmc/src/Model/course_model.dart';

class CourseController extends GetxController{

  Future<List<CourseModel>> getCourse(String userid) async {
    try {
    final response = await http.get(Uri.parse('${ApiUrl.getCoures}?userId=$userid'));

    if (response.statusCode == 200) {
      // Parse the JSON response into a List of Courses
      List<dynamic> data = json.decode(response.body);
      
      return data.map((course) => CourseModel.fromJson(course)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  } catch (error) {
    throw Exception('Error fetching courses: $error');
  }
  }
}