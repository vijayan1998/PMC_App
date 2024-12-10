import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:pmc/src/Controller/Auth/api_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


 class AiChatController extends GetxController {

  final TextEditingController messageController = TextEditingController();
  final RxList<Map<String, String>> messages = <Map<String, String>>[].obs;

  String mainTopic = '';
  
  String get defaultMessage =>
      "Hey there! I'm your AI teacher. If you have any questions about your $mainTopic course, "
      "whether it's about videos, images, or theory, just ask me. I'm here to clear your doubts.";

  String get defaultPrompt =>
      "I have a doubt about this topic :- $mainTopic. Please clarify my doubt in very short :- ";

String _convertHtmlToPlainText(String htmlContent) {
  var document = parse(htmlContent);  // Parse the HTML content
  return document.body?.text ?? '';  // Extract and return the plain text
}
  Future<void> loadMessages(String topic) async {
    mainTopic = topic;

    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonValue = prefs.getString(mainTopic);

      if (jsonValue != null) {
        messages.value = List<Map<String, String>>.from(jsonDecode(jsonValue));
      } else {
        final newMessages = [
          {"text": defaultMessage, "sender": "bot"},
        ];
        messages.value = newMessages;
        await storeMessagesLocally(newMessages);
      }
    } catch (error) {
      debugPrint("Error loading messages: $error");
    }
  }

  Future<void> storeMessagesLocally(List<Map<String, String>> messagesToStore) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(mainTopic, jsonEncode(messagesToStore));
    } catch (error) {
      debugPrint("Error saving messages locally: $error");
    }
  }

  Future<void> sendMessage() async {
    final newMessage = messageController.text.trim();
    if (newMessage.isEmpty) return;

    final userMessage = {"text": newMessage, "sender": "user"};
    final updatedMessages = [...messages, userMessage];

    // Update the messages list locally
    messages.value = updatedMessages;
    messageController.clear();
    await storeMessagesLocally(updatedMessages);

    final mainPrompt = defaultPrompt + newMessage;
    final dataToSend = jsonEncode({"prompt": mainPrompt});

    try {
      final response = await http.post(
        Uri.parse(ApiUrl.aichat),
        headers: {'Content-Type': 'application/json'},
        body: dataToSend,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
    
         List<Map<String, String>> updatedMessagesWithBot = [
  ...updatedMessages,
  {"text": _convertHtmlToPlainText(responseData['text']), "sender": "bot"}
];

          // Update the messages list with the bot response
          messages.value = updatedMessagesWithBot;
          await storeMessagesLocally(updatedMessagesWithBot);
      } else {
        debugPrint("Failed to fetch response: ${response.statusCode}");
      }
    } catch (error) {
      debugPrint("Error in sending message: $error");
    }
  }


}

  

