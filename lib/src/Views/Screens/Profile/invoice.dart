import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pmc/src/Controller/subscription_controller.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/back_arrow_widget.dart';
import 'package:pmc/src/Views/Widget/gradient_button.dart';

class InvoiceScreen extends StatefulWidget {
  final String tax;
  final String amount;
  final String method;
  final String plan;
  final String date;
  final String course;
  final String subscriptionId;
  final String subscription;
  final String receiptId;
  const InvoiceScreen({super.key, required this.tax, required this.amount, required this.method, required this.plan, required this.date, required this.course, required this.subscriptionId, required this.subscription,required this.receiptId});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  SubscriptionController subscriptionController = Get.put(SubscriptionController());
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
          String filePath = "${directory.path}/PMC_Invoice.png";

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
  Widget build(BuildContext context) {
    final double amount =  double.parse(widget.amount.toString());
    final double taxAmount = amount * (double.parse(widget.tax.toString()) / 100);
    final double grandTotal = amount + taxAmount;
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
          'Invoice',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ),
        elevation: 12,
      ),
      body: RepaintBoundary(
        key: _certificateKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(AppImages.logo,height: 66,width: 200,),
                ),
                8.vspace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Payment Method :',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                          fontWeight:FontWeight.w500
                        ),),
                        4.vspace,
                         Text('Subscription Plan :',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                          fontWeight:FontWeight.w500
                        ),),
                        4.vspace,
                         Text('Subscription ID :',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                          fontWeight:FontWeight.w500,
                        ),),
                        4.vspace,
                         Text('Customer ID :',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                          fontWeight:FontWeight.w500
                        ),),
                        4.vspace,
                         Text('Amount :',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                          fontWeight:FontWeight.w500
                        ),),
                        Divider(
                          thickness: 2,
                          color: Colors.black.withOpacity(0.55),
                        ),
                         4.vspace,
                         Text('Receipt #:',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                          fontWeight:FontWeight.w500
                        ),),
                         4.vspace,
                         Text('Date :',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                          fontWeight:FontWeight.w500
                        ),),
                        Divider(
                          thickness: 2,
                          color: Colors.black.withOpacity(0.55),
                        ),
                         4.vspace,
                         Text('Basic Monthly Plan :',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                          fontWeight:FontWeight.w500
                        ),),
                         4.vspace,
                         Text('Qty : ${widget.course} ',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey.withOpacity(0.75),
                          fontWeight:FontWeight.w400
                        ),),
                          Divider(
                          thickness: 2,
                          color: Colors.black.withOpacity(0.55),
                        ),
                         4.vspace,
                         Text('Tax :',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                          fontWeight:FontWeight.w500
                        ),),
                         4.vspace,
                         Text('${widget.tax} ',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey.withOpacity(0.75),
                          fontWeight:FontWeight.w400
                        ),),
                           Divider(
                          thickness: 2,
                          color: Colors.black.withOpacity(0.55),
                        ),
                        4.vspace,
                         Text('Grand Total :',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                          fontWeight:FontWeight.w500
                        ),),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        4.vspace,
                        Text(widget.method,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey.withOpacity(0.75),
                          fontWeight:FontWeight.w500
                        ),),
                        8.vspace,
                         Text(widget.plan,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey.withOpacity(0.75),
                          fontWeight:FontWeight.w500,
                        ),),
                        8.vspace,
                         Text(widget.subscriptionId,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey.withOpacity(0.75),
                          fontWeight:FontWeight.w500,
                        ),),
                        8.vspace,
                         Text(widget.subscription,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey.withOpacity(0.75),
                          fontWeight:FontWeight.w500
                        ),),
                        8.vspace,
                        widget.method == 'Razorpay' ? Text('${widget.amount} INR',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey.withOpacity(0.75),
                          fontWeight:FontWeight.w500
                        ),) : Text('${widget.amount} USD',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey.withOpacity(0.75),
                          fontWeight:FontWeight.w500
                        ),),
                        Divider(
                          thickness: 2,
                          color: Colors.black.withOpacity(0.55),
                        ),
                         8.vspace,
                         Text(widget.receiptId,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey.withOpacity(0.75),
                          fontWeight:FontWeight.w500
                        ),),
                         8.vspace,
                         Text(widget.date,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey.withOpacity(0.75),
                          fontWeight:FontWeight.w500
                        ),),
                        Divider(
                          thickness: 2,
                          color: Colors.black.withOpacity(0.55),
                        ),
                        8.vspace,
                        widget.method == 'Razorpay' ? Text('₹ ${int.parse(widget.amount)}',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey.withOpacity(0.75),
                          fontWeight:FontWeight.w500
                        ),) : Text('\$ ${int.parse(widget.amount)}',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey.withOpacity(0.75),
                          fontWeight:FontWeight.w500
                        ),),
                          Divider(
                          thickness: 2,
                          color: Colors.black.withOpacity(0.55),
                        ),
                         32.vspace,
                       widget.method == 'Razorpay'? Text('₹ ${(int.parse(widget.amount) * double.parse(widget.tax) /100).toStringAsFixed(2)}',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey.withOpacity(0.75),
                          fontWeight:FontWeight.w500
                        ),) : Text('\$ ${(int.parse(widget.amount) * double.parse(widget.tax) / 100).toStringAsFixed(2)}',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey.withOpacity(0.75),
                          fontWeight:FontWeight.w500
                        ),) ,
                           Divider(
                          thickness: 2,
                          color: Colors.black.withOpacity(0.55),
                        ),
                        32.vspace,
                       widget.method == 'Razorpay' ?  Text("₹ $grandTotal",style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey.withOpacity(0.75),
                          fontWeight:FontWeight.w500
                        ),) :  Text('\$ $grandTotal',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey.withOpacity(0.75),
                          fontWeight:FontWeight.w500
                        ),),
                      ],
                    ),
                  
                  ],
                ),
                16.vspace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,             
                    children: [
                      OutlinedButton(
                          onPressed: (){
                            Navigator.pop(context);
                          }, 
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)
                            )
                          ),
                        child: Text('Cancel',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                        ),)),
                           GradientButtonWidget(
                            height: 42,
                                text: 'Download Invoice',
                                width:200,
                                onTap: saveCertificate,
                              )
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}