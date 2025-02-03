// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pmc/src/Controller/Auth/api_url.dart';
import 'package:pmc/src/Views/Screens/new_screens/generative_course1.dart';
import 'package:pmc/src/Views/Screens/new_screens/topic_type.dart';
import 'package:pmc/src/Views/Sharedpreference/user_controller.dart';
import 'package:html/parser.dart' show parse;


class GenerateCourseController extends GetxController {
  final isLoading = false.obs;
  final responseMessage = ''.obs;
  var processing = false.obs;  
  var percentage = 0.obs;
  var isComplete = false.obs;
 var courseProgress = <String, int>{}.obs;
 UserController currentUser = Get.put(UserController());
// Helper function to convert HTML content to plain text
String _convertHtmlToPlainText(String htmlContent) {
  var document = parse(htmlContent);  // Parse the HTML content
  return document.body?.text ?? '';  // Extract and return the plain text
}
UserController userController = Get.put(UserController());
  // @override
  // void onInit() {
  //   super.onInit();
  //   _loadProgress();
  // }

  //  void _loadProgress() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final savedProgress = prefs.getString('courseProgress');
  //   if (savedProgress != null) {
  //     courseProgress.value = Map<String, int>.from(
  //       Map<String, dynamic>.from(jsonDecode(savedProgress)),
  //     );
  //   }
  // }

  // // Save progress for all courses
  // void _saveProgress() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString('courseProgress', jsonEncode(courseProgress));
  // }

  // // Update progress for a specific course
  // void updateCourseProgress(String courseId, int percentage) {
  //   courseProgress[courseId] = percentage;
  //   isComplete.value = percentage >= 100;
  //   _saveProgress();
  // }
  void calculateCourseProgress(String courseId, Map<String, dynamic> jsonData, String mainTopic) {
    countDoneTopics(courseId, jsonData, mainTopic);
     isComplete.value = courseProgress[courseId] != null && courseProgress[courseId]! >= 100;
  }

  // Get progress for a specific course
  int getCourseProgress(String courseId) {
    return courseProgress[courseId] ?? 0;
  }
void countDoneTopics(String courseId,Map<String, dynamic> jsonData, String mainTopic) {
    int doneCount = 0;
    int totalTopics = 0;

    var topics = jsonData[mainTopic.toLowerCase()];
      Map<String, dynamic> firstTopic = topics.first;
  List<dynamic> subtopics = firstTopic["subtopics"] ?? [];
    if (subtopics.isNotEmpty) {
    subtopics[0]["done"] = true;
  }
    if (topics != null) {
      for (var topic in topics) {
        for (var subtopic in topic['subtopics']) {
          
          if (subtopic['done'] == true) {
            doneCount++;
          }
          totalTopics++;
        }
      }
      
      
    }

    int completionPercentage = ((doneCount / totalTopics) * 100).round();
//isComplete.value = completionPercentage >= 100;
courseProgress[courseId] = completionPercentage;
    // Update reactive variables using `.value`
    // percentage.value = completionPercentage;
    
  }

  Future<void> postPrompt(String prompt, String maintopic, String selectedtype,
      BuildContext context) async {
    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(ApiUrl.generateCoursePromt),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({"prompt": prompt}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final generatedText = responseData['generatedText'];
        if (generatedText != null) {
          final decodedData = jsonDecode(generatedText);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GenerateCourse1(
                topic: maintopic,
                type: selectedtype,
                data: decodedData,
              ),
            ),
          );
        } else {
          debugPrint("generatedText is null in the response.");
        }
      } else {
        debugPrint("Error: ${response.body}");
      }
    } catch (e) {
      responseMessage.value = "Exception: $e";
      //  print("Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }

 redirectCourse(Map<String, dynamic> jsonData, String mainTopic, String type,
 BuildContext context) {
    final mainTopicData = jsonData[mainTopic][0];
    final firstSubtopic = mainTopicData['subtopics'][0];
    processing.value = true;
    if (type == "video & text course") {
      
      final query = "${firstSubtopic['title']} $mainTopic in English";
      sendVideo(query, firstSubtopic['title'],jsonData,mainTopic,type,context);
      updateCount();
    } else {
      final prompt =
          "Explain me about this subtopic of $mainTopic with examples :- ${firstSubtopic['title']}. Please Strictly Don't Give Additional Resources And Images.";
      final promptImage = "Example of ${firstSubtopic['title']} in $mainTopic";
      sendPrompt(prompt, promptImage,jsonData,mainTopic,type,context);
      updateCount();
    }
  }

 Future sendVideo(query, subtopic,Map<String, dynamic> jsonData, String mainTopic, String type, BuildContext context) async {
    var dataToSend = {
      'prompt': query,
    };
    try {
      var postURL = ApiUrl.sendvideo;
      var res = await http.post(Uri.parse(postURL),
      headers: {'Content-Type': 'application/json',},
      body: json.encode(dataToSend));
      if(res.statusCode == 200){
        final responseData = json.decode(res.body);
        final generatedText = responseData['url'];
          // Call sendTranscript with the generated text and subtopic
        await sendTranscript(generatedText, subtopic,jsonData,mainTopic,type,context);
      }else{
        // Retry if response is not successful
        await sendVideo(query, subtopic,jsonData,mainTopic,type,context);
      }
    } catch (error) {
       // Retry in case of an error
      sendVideo(query, subtopic,jsonData,mainTopic,type,context);
    }
  }

   // Function to send transcript
  Future<void> sendTranscript(String url, String subtopic,Map<String, dynamic> jsonData, String mainTopic, String type, BuildContext context) async {
    final Map<String, String> dataToSend = {
      "prompt": url,
    };

    try {
      final postURL = Uri.parse(ApiUrl.sendTranscript);
      final response = await http.post(
        postURL,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(dataToSend),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData["url"] != null) {
          final List<dynamic> generatedText = responseData["url"];
          final List<String> allText = generatedText.map((item) => item["text"] as String).toList();
          final String concatenatedText = allText.join(" ");
          final String prompt = "Summarize this theory in a teaching way and :- $concatenatedText.";
          
          // Call sendSummary with the generated prompt and url
          await sendSummary(prompt, url,jsonData,mainTopic,type,context);
        } else {
          // Handle unexpected response structure
          throw Exception("Invalid response structure");
        }
      } else {
        throw Exception("Failed to fetch transcript");
      }
    } catch (error) {
      // Fallback prompt
      final String prompt =
          "Explain me about this subtopic of $subtopic with examples. Please strictly don't give additional resources and images.";
      await sendSummary(prompt, url,jsonData,mainTopic,type,context);
    }
  }

   Future<void> sendSummary(String prompt, String url,Map<String, dynamic> jsonData, String mainTopic, String type, BuildContext context) async {
    final dataToSend = {"prompt": prompt};
    try {
      processing.value = true;

      // Make the POST request
      final response = await http.post(
        Uri.parse(ApiUrl.sendSummary),
        headers: {"Content-Type": "application/json"},
        body: json.encode(dataToSend),
      );

      if (response.statusCode == 200) {
        final generatedText = json.decode(response.body)["text"];
        final htmlContent = generatedText;

        try {
          final parsedJson = htmlContent; // Simulate parsing if needed.
          processing.value = false;
          sendDataVideo(url, parsedJson,jsonData, mainTopic, type,context);
           //sendDataVideo(url, parsedJson); // Implement this function.
        } catch (error) {
          // Retry on parsing failure
          await sendSummary(prompt, url,jsonData,mainTopic,type,context);
        }
      } else {
        // Retry on HTTP failure
        await sendSummary(prompt, url,jsonData,mainTopic,type,context);
      }
    } catch (error) {
      // Retry on request failure
      await sendSummary(prompt, url,jsonData,mainTopic,type,context);
    }
  }

  Future<void> sendPrompt(String prompt, String promptImage,Map<String, dynamic> jsonData, String mainTopic, String type,
  BuildContext context) async {
    processing.value = true;

    final dataToSend = {"prompt": prompt};
    try {
      final res = await http.post(Uri.parse(ApiUrl.sendPrompt),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(dataToSend));
      if (res.statusCode == 200) {
        final generatedText = jsonDecode(res.body)["text"];
        sendImage(generatedText, promptImage,jsonData,mainTopic,type,context);
      } else {
        throw Exception("Failed to generate prompt");
      }
    } catch (error) {
      sendPrompt(prompt, promptImage,jsonData,mainTopic,type,context); // Retry on failure
    }
  }
  Future<void> sendImage(String parsedJson, String promptImage,Map<String, dynamic> jsonData, String mainTopic, String type,
  BuildContext context) async {
    final dataToSend = {"prompt": promptImage};

    try {
      final res = await http.post(Uri.parse(ApiUrl.sendImage),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(dataToSend));

      if (res.statusCode == 200) {
        final imageUrl = jsonDecode(res.body)["url"];
        sendData(imageUrl, parsedJson,jsonData,mainTopic,type,context);
      } else {
        throw Exception("Failed to generate image");
      }
    } catch (error) {
      sendImage(parsedJson, promptImage,jsonData,mainTopic,type,context); // Retry on failure
    } finally {
      processing.value = false;
    }
  }

  Future<void> sendData(String image, String theory,Map<String, dynamic> jsonData, String mainTopic, String type,
  BuildContext context) async {
    
    // Check if jsonData["mainTopic"] exists
  // if (jsonData.containsKey("title") && jsonData["title"] != null) {
  //   if (jsonData["title"].containsKey("subtopics") && jsonData["title"]["subtopics"] != null) {
  //     jsonData["title"]["subtopics"][0]["theory"] = theory;
  //     jsonData["title"]["subtopics"][0]["image"] = image;
  //     debugPrint('bbb:${jsonData["title"]["subtopics"][0]["theory"]}');
  //   } else {
  //     debugPrint("subtopics is null or missing");
  //   }
  // } else {
  //   debugPrint("title is null or missing");
  // }
   // Convert HTML to plain text
  
  String plainTextTheory = _convertHtmlToPlainText(theory);

  // Check if the main topic exists in the jsonData
  if (!jsonData.containsKey(mainTopic)) {
    return;
  }

  // Get the list of topics under the main topic
  List<dynamic>? mainTopics = jsonData[mainTopic];
  if (mainTopics == null || mainTopics.isEmpty) {
    return;
  }

  // Assume we are updating the first subtopic of the first topic
  Map<String, dynamic>? firstTopic = mainTopics.first;
  if (firstTopic == null || !firstTopic.containsKey("subtopics")) {
    return;
  }

  List<dynamic>? subtopics = firstTopic["subtopics"];
  if (subtopics == null || subtopics.isEmpty) {
    return;
  }

  // Update the first subtopic with the provided theory and youtube values
  subtopics[0]["theory"] = plainTextTheory; 
  subtopics[0]["image"] = image;


    try {
      final response = await http.post(
        Uri.parse(ApiUrl.senddata),
        body: jsonEncode({
          'user': userController.user.id.toString(), // Replace with actual user data
          'fname':userController.user.fname.toString(),
          'lname':userController.user.lname.toString(),
          'phone':userController.user.phone.toString(),
          'email':userController.user.email.toString(),
          'content': jsonEncode(jsonData),
          'type': type, // Replace with actual type
          'mainTopic': mainTopic, // Replace with actual mainTopic
        }),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData["success"]) {
          responseMessage.value = responseData["message"];
          // Get the courseId from the response
        String courseId = responseData["courseId"];
          // Navigate to the content screen with response data
          countDoneTopics(courseId,jsonData, mainTopic);
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  TopicType(
            topic: mainTopic,
            type: type,
            data: jsonData,
            courseid: courseId,
          )
          ));
          
        } else {
          throw Exception("Failed to save data");
        }
      }
    } catch (error) {
      // Handle retry logic or error message
      if (kDebugMode) {
        print(error);
      }
    }
  }

Future<void> sendDataVideo(
    String image, String theory, Map<String, dynamic> jsonData, String mainTopic, String type, BuildContext context) async {


  // Convert HTML to plain text
  String plainTextTheory = _convertHtmlToPlainText(theory);

  // Check if the main topic exists in the jsonData
  if (!jsonData.containsKey(mainTopic)) {
    return;
  }

  // Get the list of topics under the main topic
  List<dynamic>? mainTopics = jsonData[mainTopic];
  if (mainTopics == null || mainTopics.isEmpty) {
    return;
  }

  // Assume we are updating the first subtopic of the first topic
  Map<String, dynamic>? firstTopic = mainTopics.first;
  if (firstTopic == null || !firstTopic.containsKey("subtopics")) {
    return;
  }

  List<dynamic>? subtopics = firstTopic["subtopics"];
  if (subtopics == null || subtopics.isEmpty) {
    return;
  }

  // Update the first subtopic with the provided theory and youtube values
  subtopics[0]["theory"] = plainTextTheory; 
  subtopics[0]["youtube"] = image;


  // Proceed with the API call
  try {

    final response = await http.post(
      Uri.parse(ApiUrl.senddata),
      body: jsonEncode({
        'user': userController.user.id.toString(),
        'fname':userController.user.fname.toString(),
        'lname':userController.user.lname.toString(),
        'phone':userController.user.phone.toString(),
        'email':userController.user.email.toString(),
        'content': jsonEncode(jsonData),
        'type': type,
        'mainTopic': mainTopic,
      }),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
          // Get the courseId from the response
        String courseId = responseData["courseId"];
           countDoneTopics(courseId,jsonData, mainTopic);
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  TopicType(
            topic: mainTopic,
            type: type,
            data: jsonData,
            courseid: courseId,
          )
          ));
    } else {
    //  print("HTTP Error: ${response.statusCode}");
    }
  } catch (error) {
  //  print("Exception occurred: $error");
  }
}

 
handleSelect(String topics, String sub,Map<String, dynamic> jsonData,String mainTopic, String type,String courseid,BuildContext context) async {
    final mTopic = jsonData[mainTopic.toLowerCase()]
        ?.firstWhere((topic) => topic['title'] == topics, orElse: () => null);

    final mSubTopic = mTopic?['subtopics']
        ?.firstWhere((subtopic) => subtopic['title'] == sub, orElse: () => null);


    if (mSubTopic == null) return;

    if (mSubTopic['theory'] == null || mSubTopic['theory'].isEmpty) {
     final id = await showToastLoading();
      if (type == "video & text course") {
        final query = "${mSubTopic['title']} $mainTopic in English";
        sendVideo2(query, topics, sub, jsonData, mainTopic, type, courseid, id,context);
      } else {
        final prompt =
            "Explain me about this subtopic of $mainTopic with examples :- ${mSubTopic['title']}. Please Strictly Don't Give Additional Resources And Images.";
        final promptImage =
            "Example of ${mSubTopic['title']} in $mainTopic.";
        sendPrompt2(prompt, promptImage, topics, sub,jsonData,mainTopic,type,courseid,id,context);
      }
    } else {
      setSelected(mSubTopic['title']);
      setTheory(mSubTopic['theory']);
      setMedia(type == "video & text course"
          ? mSubTopic['youtube']
          : mSubTopic['image']);
    }
  }

  Future<void> sendPrompt2(
      String prompt, String promptImage, String topics, String sub,Map<String, dynamic> jsonData,
  String mainTopic,String type ,String courseid,String id,BuildContext context) async {
    final dataToSend = {'prompt': prompt};

    try {
      final res = await http.post(Uri.parse(ApiUrl.sendPrompt),
          body: jsonEncode(dataToSend),
          headers: {'Content-Type': 'application/json'});
            if (res.statusCode == 200) {
        final generatedText = jsonDecode(res.body)["text"];
         sendImage2(generatedText, promptImage, topics, sub,jsonData,mainTopic,type,courseid,id,context);
      } else {
        throw Exception("Failed to generate prompt");
      }
    } catch (error) {
      sendPrompt2(prompt, promptImage, topics, sub,jsonData,mainTopic,type,courseid,id,context);
    }
  }

  Future<void> sendImage2(
      String parsedJson, String promptImage, String topics, String sub,Map<String, dynamic> jsonData,
  String mainTopic,String type ,String courseid,String id,BuildContext context) async {
    final dataToSend = {'prompt': promptImage};
    try {
      final res = await http.post(Uri.parse(ApiUrl.sendImage),
          body: jsonEncode(dataToSend),
          headers: {'Content-Type': 'application/json'});
           if (res.statusCode == 200) {
        final imageUrl = jsonDecode(res.body)["url"];
        sendData2(imageUrl, parsedJson, topics, sub,jsonData,mainTopic,type,courseid,id,context);
      } else {
        throw Exception("Failed to generate image");
      }
     
    } catch (error) {
      sendImage2(parsedJson, promptImage, topics, sub,jsonData ,mainTopic,type,courseid,id,context);
    }
  }

  Future<void> sendData2(String image, String theory, String topics, String sub,Map<String, dynamic> jsonData,
  String mainTopic,String type,String courseid,String id,BuildContext context) async {
    
    final mTopic = jsonData[mainTopic.toLowerCase()]
        ?.firstWhere((topic) => topic['title'] == topics, orElse: () => null);
    final mSubTopic = mTopic?['subtopics']
        ?.firstWhere((subtopic) => subtopic['title'] == sub, orElse: () => null);
  String plainTextTheory = _convertHtmlToPlainText(theory);

    if (mSubTopic == null) return;

    mSubTopic['theory'] = plainTextTheory;
    mSubTopic['image'] = image;
    setSelected(mSubTopic['title']);
    showToastDone(id);
    setTheory(theory);
    setMedia(type == "video & text course" ? mSubTopic['youtube'] : image);
    mSubTopic['done'] = true;
    await updateCourse(topics,sub,mainTopic,type,jsonData,courseid,context);
  }

   Future<void> sendDataVideo2(String image, String theory, String topics, String sub,Map<String, dynamic> jsonData,
  String mainTopic,String type,String courseid,String id,BuildContext context) async {
    final mTopic = jsonData[mainTopic.toLowerCase()]
        ?.firstWhere((topic) => topic['title'] == topics, orElse: () => null);
    final mSubTopic = mTopic?['subtopics']
        ?.firstWhere((subtopic) => subtopic['title'] == sub, orElse: () => null);
  String plainTextTheory = _convertHtmlToPlainText(theory);

    if (mSubTopic == null) return;

    mSubTopic['theory'] = plainTextTheory;
    mSubTopic['youtube'] = image;
    setSelected(mSubTopic['title']);
    showToastDone(id);
    setTheory(theory);
    setMedia(type == "video & text course" ? mSubTopic['youtube'] : image);
    mSubTopic['done'] = true;
    await updateCourse(topics,sub,mainTopic,type,jsonData,courseid,context);
  }

  Future<void> updateCourse( String topic ,String sub,String mainTopic,String type,Map<String, dynamic> jsonData,String courseid,BuildContext context) async {
   
    countDoneTopics(courseid,jsonData,mainTopic);

    final dataToSend = {
      'content': jsonEncode(jsonData),
      'courseId': courseid,
    };
  
    try {
        final res = await http.post(Uri.parse(ApiUrl.updatecourse),
          body: jsonEncode(dataToSend),
          headers: {'Content-Type': 'application/json'});

           if (res.statusCode == 200) {
        final responsedata = jsonDecode(res.body);
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  TopicType(
            topic: mainTopic,
            type: type,
            data: jsonData,
            courseid: courseid,
            drawertitle:topic ,
            drawersubtopic: sub,
          )
          ));

        if (kDebugMode) {
          print('finaldata: $responsedata');
        }
   
      } else {
        throw Exception("Failed to generate image");
      }
     
    } catch (error) {
      updateCourse(topic,sub,mainTopic,type,jsonData,courseid,context);
    }
  }

   Future sendVideo2(query,String topics,subtopic,Map<String, dynamic> jsonData, String mainTopic, String type,String courseid,String id,BuildContext context) async {
    var dataToSend = {
      'prompt': query,
    };
    try {
      var postURL = ApiUrl.sendvideo;
      var res = await http.post(Uri.parse(postURL),
      headers: {'Content-Type': 'application/json',},
      body: json.encode(dataToSend));
      if(res.statusCode == 200){
        final responseData = json.decode(res.body);
        final generatedText = responseData['url'];
          // Call sendTranscript with the generated text and subtopic
       await sendTranscript2(generatedText, topics,subtopic,jsonData,mainTopic,type,courseid,id,context);
      }else{
        // Retry if response is not successful
        await sendVideo2(query, topics,subtopic,jsonData,mainTopic,type,courseid,id,context);
      }
    } catch (error) {
       // Retry in case of an error
      sendVideo2(query, topics,subtopic,jsonData,mainTopic,type,courseid,id,context);
    }
  }

   // Function to send transcript
  Future<void> sendTranscript2(String url, String topics,String subtopic,Map<String, dynamic> jsonData, String mainTopic, String type,String courseid,String id,BuildContext context) async {
    final Map<String, String> dataToSend = {
      "prompt": url,
    };
    
    try {
      final postURL = Uri.parse(ApiUrl.sendTranscript);
      final response = await http.post(
        postURL,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(dataToSend),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData["url"] != null) {
          final List<dynamic> generatedText = responseData["url"];
          final List<String> allText = generatedText.map((item) => item["text"] as String).toList();
          final String concatenatedText = allText.join(" ");
          final String prompt = "Summarize this theory in a teaching way and :- $concatenatedText.";
          
          // Call sendSummary with the generated prompt and url
          await sendSummary2(prompt, url,topics,subtopic,jsonData,mainTopic,type,courseid,id,context);
        } else {
          // Handle unexpected response structure
          throw Exception("Invalid response structure");
        }
      } else {
        throw Exception("Failed to fetch transcript");
      }
    } catch (error) {
      // Fallback prompt
      final String prompt =
          "Explain me about this subtopic of $subtopic with examples. Please strictly don't give additional resources and images.";
      await sendSummary2(prompt, url,topics,subtopic,jsonData,mainTopic,type,courseid,id,context);
    }
  }

   Future<void> sendSummary2(String prompt, String url,String topics,String subtopic,Map<String, dynamic> jsonData, String mainTopic, String type,String courseid,String id,BuildContext context) async {
    final dataToSend = {"prompt": prompt};
    try {
      processing.value = true;

      // Make the POST request
      final response = await http.post(
        Uri.parse(ApiUrl.sendSummary),
        headers: {"Content-Type": "application/json"},
        body: json.encode(dataToSend),
      );

      if (response.statusCode == 200) {
        final generatedText = json.decode(response.body)["text"];
        final htmlContent = generatedText;

        try {
          final parsedJson = htmlContent; // Simulate parsing if needed.
          processing.value = false;
          sendDataVideo2(url, parsedJson, topics,subtopic, jsonData, mainTopic, type, courseid, id,context);
           //sendDataVideo(url, parsedJson); // Implement this function.
        } catch (error) {
          // Retry on parsing failure
          await sendSummary2(prompt, url,topics,subtopic,jsonData,mainTopic,type,courseid,id,context);
        }
      } else {
        // Retry on HTTP failure
        await sendSummary2(prompt, url,topics,subtopic,jsonData,mainTopic,type,courseid,id,context);
      }
    } catch (error) {
      // Retry on request failure
      await sendSummary2(prompt, url,topics,subtopic,jsonData,mainTopic,type,courseid,id,context);
    }
  }

  Future<void> finishcourse(String courseid,BuildContext context) async {
    final dataToSend = {'courseId': courseid};

      final res = await http.post(Uri.parse(ApiUrl.finish),
          body: jsonEncode(dataToSend),
          headers: {'Content-Type': 'application/json'});
           if (res.statusCode == 200) {
     
      } else {
        throw Exception("Failed to generate image");
      }
     
  }

  Future<String> showToastLoading() async {
     bool isLoading = true; // Condition to keep the loop running
  Future.delayed(const Duration(seconds: 20), () {
    isLoading = false; // Stop the loop after 5 seconds
  });
       await Future.doWhile(() async {
    // Show the toast message
    Fluttertoast.showToast(
      msg: "Please wait...",
      toastLength: Toast.LENGTH_SHORT,
    );
    // Wait for 2 seconds before repeating
    await Future.delayed(const Duration(seconds: 2));
    return isLoading; // Continue looping if `isLoading` is true
  });
     
    return "toast_id";
  }

  Future<void> updateCount() async {
    final body ={
      "user": currentUser.user.id.toString(),
    };
    final response = await http.post(Uri.parse(ApiUrl.updateCount),
    headers:{'Content-Type': 'application/json',},
    body: jsonEncode(body));
    if(response.statusCode == 200){
      final responseData = jsonDecode(response.body);
      if (kDebugMode) {
        print(responseData);
      }else {
        if (kDebugMode) {
          print('error:${response.body}');
        }
      }
    }
  }

 void showToastDone(String id) {
    Fluttertoast.showToast(msg: "Done!", toastLength: Toast.LENGTH_SHORT);
  }

  void setSelected(String title) {
    if (kDebugMode) {
      print("Selected: $title");
    }
  }

  void setTheory(String theory) {
    if (kDebugMode) {
      print("Theory: $theory");
    }
  }

  void setMedia(String media) {
    if (kDebugMode) {
      print("Media: $media");
    }
  }

}
