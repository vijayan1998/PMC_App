import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pmc/src/Controller/Auth/api_url.dart';
import 'package:pmc/src/Views/Widget/back_arrow_widget.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;



class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  String policy = '';

Future<void> fetchPolicy() async {
  try {
    final response = await http.get(Uri.parse(ApiUrl.policies));
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      // Extract the text from the HTML content in the 'privacy' field
      final privacyHtml = responseData['data']['privacy'] ?? 'No Privacy content';
      final document = htmlParser.parse(privacyHtml);
      final privacyText = document.body?.text ?? '';
      setState(() {
        policy = privacyText;
      });
    } else {
      if (kDebugMode) {
        print('Error fetching policy');
      }
    }
  } catch (error) {
    if (kDebugMode) {
      print('Error fetching subscriptions: $error');
    }
  }
}


  @override
  void initState(){
    fetchPolicy();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff300080),
      appBar: AppBar(
        backgroundColor: const Color(0xff4C07F4),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BackArrowWidget(
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text('Privacy Policy',style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),),
        elevation: 12,
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0,right: 16),
          child:  policy.isNotEmpty
                  ? Text(policy.toString(),style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w400
                  ),)
                  :const Center(child: Text('No Privacy Policy Found')),
        ),
      ),
    );
  }
}
