import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:pmc/src/Controller/ticket_controller.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/back_arrow_widget.dart';

class HelpViewScreen extends StatefulWidget {
  final String? fname;
  final String? lname;
  final String? ticketId;
  final String? date;
  final String? category;
  final String? priority;
  final String? desc1;
  const HelpViewScreen({
    super.key,
    this.fname,
    this.lname,
    this.ticketId,
    this.date,
    this.category,
    this.priority,
    this.desc1,
  });

  @override
  State<HelpViewScreen> createState() => _HelpViewScreenState();
}

class _HelpViewScreenState extends State<HelpViewScreen> {
  TicketController ticketController = Get.put(TicketController());
  late Future<void> fetchAttachmentsFuture;

  @override
  void initState() {
    super.initState();
    fetchAttachmentsFuture =
        ticketController.fetchAttachments(widget.ticketId.toString());
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
          'Help & Support',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ),
        elevation: 12,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${widget.fname} ${widget.lname}',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.white.withOpacity(0.75),
                    ),
              ),
              4.vspace,
              Text(
                'Ticket No: ${widget.ticketId}',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white.withOpacity(0.75),
                    ),
              ),
              16.vspace,
              Text(
                'Date : ${widget.date}',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
              Text(
                'Category : ${widget.category}',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
              Text(
                'Priority : ${widget.priority}',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
              16.vspace,
              Text(
                'Attachments : ',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
              SizedBox(
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder(
                  future: fetchAttachmentsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: ticketController.userImagesTemp.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final imageUrl =
                              ticketController.userImagesTemp[index];

                          // Check if the imageUrl is null, empty, or invalid
                          if (imageUrl.isEmpty ||
                              !imageUrl.startsWith(RegExp(r'data:'))) {
                            return const Icon(Icons.broken_image, size: 50);
                          }
                          try {
                            final base64Data =
                                imageUrl.split(',')[1]; // Get the Base64 part
                            final decodedBytes = base64Decode(base64Data);
                            return  InstaImageViewer(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.memory(
                                  decodedBytes,
                                  fit: BoxFit.cover,
                                  width: 56,
                                  height: 56,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.image, size: 50);
                                  },
                                ),
                              ),
                            );
                          } catch (e) {
                            return const Icon(Icons.image, size: 50);
                          }
                        },
                      );
                    }
                  },
                ),
              ),
              8.vspace,
              Text(
                'Description : ',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
              Text(
                '${widget.desc1}',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white.withOpacity(0.75),
                    ),
              ),
              4.vspace,
              Divider(
                thickness: 2,
                color: Colors.grey.withOpacity(0.75),
              ),
              4.vspace,
              Text(
                'Support',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white.withOpacity(0.75),
                    ),
              ),
              16.vspace,
              Text(
                'Date : ${widget.date}',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
              16.vspace,
              Text(
                'Attachments : ',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
              ticketController.adminImageTemp.isEmpty ?  
             const Icon(Icons.image,size: 50,color: Colors.white,)
              :SizedBox(
                height: 80,
                width: MediaQuery.of(context).size.width,
                 child:  FutureBuilder(
                    future: fetchAttachmentsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: ticketController.adminImageTemp.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final imageUrl =
                                ticketController.adminImageTemp[index];
                 
                            // Check if the imageUrl is null, empty, or invalid
                            if (imageUrl.isEmpty ||
                                !imageUrl.startsWith(RegExp(r'data:'))) {
                              return const Icon(Icons.image, size: 50);
                            }
                            try {
                              final base64Data =
                                  imageUrl.split(',')[1]; // Get the Base64 part
                              final decodedBytes = base64Decode(base64Data);
                              return  InstaImageViewer(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.memory(
                                    decodedBytes,
                                    fit: BoxFit.cover,
                                    width: 56,
                                    height: 56,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.image, size: 50);
                                    },
                                  ),
                                ),
                              );
                            } catch (e) {
                              return const Icon(Icons.image, size: 50,color: Colors.white,);
                            }
                          },
                        );
                      }
                    },
                  ),
               ),
              8.vspace,
              Text(
                'Description : ',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
              Text(
                '${widget.desc1}',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white.withOpacity(0.75),
                    ),
              ),
              4.vspace,
              Divider(
                thickness: 2,
                color: Colors.grey.withOpacity(0.75),
              ),
              16.vspace,
            ],
          ),
        ),
      ),
    );
  }
}
