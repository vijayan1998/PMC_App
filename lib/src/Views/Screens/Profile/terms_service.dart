import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pmc/src/Controller/Auth/api_url.dart';
import 'package:pmc/src/Views/Widget/back_arrow_widget.dart';

class TermsServiceScreen extends StatefulWidget {
  const TermsServiceScreen({super.key});

  @override
  State<TermsServiceScreen> createState() => _TermsServiceScreenState();
}

class _TermsServiceScreenState extends State<TermsServiceScreen> {
  String terms ='';

  Future<void> fetchTerms() async {
  try {
    final response = await http.get(Uri.parse(ApiUrl.policies));
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      // Extract the text from the HTML content in the 'privacy' field
      final privacyHtml = responseData['data']['terms'] ?? 'No Terms content';
      final document = htmlParser.parse(privacyHtml);
      final privacyText = document.body?.text ?? '';
      setState(() {
        terms = privacyText;
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
  super.initState();
  fetchTerms();
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
        title: Text(
          'Terms of Service',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ),
        elevation: 12,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: terms.isNotEmpty ?
          Text(terms.toString(),style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w400
                  ),)
                  :const Padding(
                    padding:  EdgeInsets.all(16.0),
                    child: Center(child: Text('No Terms and Condition')),
                  ),
        ),
      ),
    );
  }
}
