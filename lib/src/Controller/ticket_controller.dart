import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:pmc/src/Controller/Auth/api_url.dart';
import 'package:pmc/src/Model/ticket_model.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';


class TicketController extends GetxController{
  final List<XFile> selectedFiles = [];
   RxList<String> userImagesTemp = <String>[].obs;
  RxList<String> adminImageTemp = <String>[].obs;
     bool isDataFetched = false;


 Future<List<Map<String, dynamic>>> fetchCategories() async {
  try {
    final response = await http.get(Uri.parse(ApiUrl.getCategory));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['success'] == true) {
        return List<Map<String, dynamic>>.from(jsonData['cate']);
      } else {
        throw Exception('Failed to fetch categories: ${jsonData['message']}');
      }
    } else {
      throw Exception('Failed to connect to API: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('Error fetching categories: $error');
  }
}

Future<void> raiseTicket(String id,String fname,String lname,String email,String phone,String category,String subject,
String desc,String priority) async {
  final response = await http.post(Uri.parse(ApiUrl.ticket),
  headers: {'Content-Type' : 'application/json'},
  body: jsonEncode({
    'user':id,
    'fname':fname,
    'lname':lname,
    'email':email,
    'phone':phone,
    'category':category,
    'subject':subject,
    'desc1':desc,
    'priority':priority,
  }));
  if(response.statusCode == 200){
    var data = jsonDecode(response.body);
    final ticketid = data['Ticket'];
    if(selectedFiles.isNotEmpty){
       final uri = Uri.parse(ApiUrl.ticketImage);
  final request = http.MultipartRequest('POST', uri)
    ..fields['user'] = id
    ..fields['ticketId'] = ticketid
    ..fields['createdby'] = 'user';

  for (var file in selectedFiles) {
    if (await File(file.path).exists()) {
      final multipartFile = await http.MultipartFile.fromPath('files', file.path);
      request.files.add(multipartFile);
    } else {
      if (kDebugMode) {
        print('File not found: ${file.path}');
      }
    }
  }

  try {
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    if (kDebugMode) {
      print('Response Body: $responseBody');
    }

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Upload successful!');
      }
    } else {
      if (kDebugMode) {
        print('Upload failed with status: ${response.statusCode}');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error: $e');
    }
  }
    }

    if (kDebugMode) {
      print(data);
    }
    Fluttertoast.showToast(msg: 'Ticket created successfully');
    Get.toNamed(Appnames.help);
  }else {
    debugPrint('error:${response.body}');
  }
}


Future<List<TicketModel>> getTicket(String ticketId) async {
  final response = await http.get(
    Uri.parse('${ApiUrl.getTicketUserid}?user=$ticketId'),
  );
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    if (kDebugMode) {
      print('jsonResponse: $jsonResponse');
    }

    if (jsonResponse['success'] == true) {
      if (jsonResponse.containsKey('ticket')) {
        if (jsonResponse['ticket'] is List) {
          List<dynamic> ticketsJson = jsonResponse['ticket'];
          return ticketsJson.map((json) => TicketModel.fromJson(json)).toList();
        } else if (jsonResponse['ticket'] is Map) {
          TicketModel ticket = TicketModel.fromJson(jsonResponse['ticket']);
          return [ticket]; // Return as a list with one item
        } else {
          throw Exception('Unexpected data type for ticket');
        }
      } else {
        throw Exception('Ticket key missing in response');
      }
    } else {
    
      throw Exception('Failed to load tickets');
    }
  } else {
    if (kDebugMode) {
      print('Request failed with status code: ${response.statusCode}');
    }
    throw Exception('Failed to load tickets');
  }
}

 // Fetch attachments from API
  Future<void> fetchAttachments(ticketId) async {
    try {
      final response = await http.get(Uri.parse('${ApiUrl.getattachments}?ticketId=$ticketId'));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        List<dynamic> attachments = responseData['attachments'];  
        await loadAttachmentFiles(attachments,ticketId);
      } else {
        if (kDebugMode) {
          print('Failed to load attachments: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching attachments: $e');
      }
    }
    isDataFetched = true; // Mark as fetched
  }

// Load attachment files and filter based on ticketId
  Future<void> loadAttachmentFiles(List<dynamic> attachments, String ticketId) async {
    // Clear previous data to reload images for the current ticket
    userImagesTemp.clear(); 
     adminImageTemp.clear();

    for (var attachment in attachments) {
      try {
        if (attachment['ticketId'] == ticketId) {  // Only process images for the current ticketId
          final response = await http.get(
            Uri.parse('${ApiUrl.getattachmentsfile}/${attachment['attachment']}'),
          );
          if (response.statusCode == 200) {
            String? contentType = response.headers['content-type'];
            if (contentType == null || contentType == 'undefined' || contentType.isEmpty) {
              contentType = 'application/octet-stream'; // Fallback to a default MIME type
            }
            final bytes = response.bodyBytes;
            final blobUrl = Uri.dataFromBytes(bytes, mimeType: contentType).toString();

            if (attachment['createdby'] == "user") {
              userImagesTemp.add(blobUrl); // Add only images from the current ticketId
            } else if(attachment['createdby'] == 'admin'){
              adminImageTemp.add(blobUrl);
            }
          } else {
            if (kDebugMode) {
              print('Failed to load file: ${response.statusCode}');
            }
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error loading file: $e');
        }
      }
    }
  }

}