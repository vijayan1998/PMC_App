// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pmc/src/Views/Sharedpreference/user_controller.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/back_arrow_widget.dart';
import 'package:pmc/src/Views/Widget/gradient_button.dart';

class CertificateViewScreen extends StatefulWidget {
  final String? mainTopic;
  final String? formattedDate;
  const CertificateViewScreen({super.key, this.mainTopic, this.formattedDate});

  @override
  State<CertificateViewScreen> createState() => _CertificateViewScreenState();
}

class _CertificateViewScreenState extends State<CertificateViewScreen> {
  UserController currentUser = Get.put(UserController());
  final GlobalKey _certificateKey = GlobalKey();

   Future<void> saveCertificate() async {
    try {
       var status = await Permission.storage.status; 
    if (!status.isGranted) { 
      // If not we will ask for permission first 
      await Permission.storage.request(); 
       RenderRepaintBoundary boundary =
            _certificateKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
        ui.Image image = await boundary.toImage(pixelRatio: 3.0);
        ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        if (byteData != null) {
          Uint8List pngBytes = byteData.buffer.asUint8List();

          // Get the directory to save the image
           Directory directory = Directory(""); 
    if (Platform.isAndroid) { 
       // Redirects it to download folder in android 
      directory = Directory("/storage/emulated/0/Download"); 
    } else { 
      directory = await getApplicationDocumentsDirectory(); 
    } 
          // Directory directory = await getApplicationDocumentsDirectory();
          String filePath = "${directory.path}/PMC_${widget.mainTopic}.png";

          // Save the file
          File file = File(filePath);
          await file.writeAsBytes(pngBytes);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Certificate saved to $filePath'),
            duration: const Duration(seconds: 2),
          ));
        }
    } 
      // Request permission to access storage
    else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Permission to access storage is denied'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to save certificate: $e'),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  @override
  void initState() {
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
        title: Text('My Certificates',style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),),
        elevation: 12,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            66.vspace,
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: RepaintBoundary(
                key: _certificateKey,
                 child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset(AppImages.certificate,
                   width: MediaQuery.of(context).size.width,
                   fit: BoxFit.cover,),
                   Positioned(
                    top: 10,
                    left: 10,
                    child: Image.asset(AppImages.logo,
                    height: 46,
                    width: 150,),
                    ),
                     Positioned(
                    top: 60,
                    left: MediaQuery.of(context).size.width / 8,
                    right: MediaQuery.of(context).size.width / 8,
                    child:Text('CERTIFICATE OF COMPLETION',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                    ),
                    ),
                    Positioned(
                    top: 86,
                    left: MediaQuery.of(context).size.width / 3.5,
                    right: MediaQuery.of(context).size.width / 3.5,
                    child:Text('This is to certify that',style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Colors.white.withOpacity(0.75),
                    ),
                    textAlign: TextAlign.center,),
                    ),
                     Positioned(
                    top: 120,
                    left: MediaQuery.of(context).size.width / 3,
                    right: MediaQuery.of(context).size.width / 3,
                    child:Text("${currentUser.user.fname.toString()} ${currentUser.user.lname}",style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,),
                    ),
                    Positioned(
                    top: 168,
                    left: MediaQuery.of(context).size.width / 9,
                    right: MediaQuery.of(context).size.width / 9,
                    child:Text('has successfully completed the course on',style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Colors.white.withOpacity(0.75)
                    ),
                    textAlign: TextAlign.center,),
                    ),
                     Positioned(
                    top: 196,
                    left: MediaQuery.of(context).size.width / 3,
                    right: MediaQuery.of(context).size.width / 3,
                    child:Text(widget.mainTopic.toString(),style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,),
                    ),
                    Positioned(
                    top: 220,
                    left: MediaQuery.of(context).size.width / 3,
                    right: MediaQuery.of(context).size.width / 3,
                    child:Text('On ${widget.formattedDate}',style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Colors.white.withOpacity(0.75),
                      
                    ),
                    textAlign: TextAlign.center,),
                    ),
                  ],  
                 ),
               ),
             ),
             36.vspace,
             Padding(
               padding: const EdgeInsets.all(36.0),
               child: GradientButtonWidget(text: 'Download Certificate', width: MediaQuery.of(context).size.width / 1,
               onTap: saveCertificate,),
             ),
          ],
        ),
      ),
    );
  }
}