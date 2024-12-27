import 'package:flutter/material.dart';
import 'package:pmc/src/Views/Widget/back_arrow_widget.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
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
        title: Text('Notifications',style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),),
        elevation: 12,
      ),
      body: Padding(
        padding:const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Center(
                 child: Text(
                  'No notifications',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.white,
                      ),
                               ),
               ),
            //   Text(
            //     'Subject : Lorem Ipsum is a dummy text placed for illustration',
            //     style: Theme.of(context).textTheme.labelMedium!.copyWith(
            //           color: Colors.white,
            //         ),
            //   ),
            //   16.vspace,
            //   Text(
            //   ' Description : Lorem Ipsumis simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularized in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum ',
            //   style: Theme.of(context).textTheme.labelMedium!.copyWith(
            //         color: Colors.white,
            //       ),
            // ),
            // 4.vspace,
            // Divider(
            //   thickness: 2,
            //   color: Colors.grey.withOpacity(0.75),
            // ),
            // 4.vspace,
            //   Text(
            //     'Date : 22-05-1990',
            //     style: Theme.of(context).textTheme.labelMedium!.copyWith(
            //           color: Colors.white,
            //         ),
            //   ),
            //   Text(
            //     'Subject : Lorem Ipsum is a dummy text placed for illustration',
            //     style: Theme.of(context).textTheme.labelMedium!.copyWith(
            //           color: Colors.white,
            //         ),
            //   ),
            //   16.vspace,
            //   Text(
            //   ' Description : Lorem Ipsumis simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularized in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum ',
            //   style: Theme.of(context).textTheme.labelMedium!.copyWith(
            //         color: Colors.white,
            //       ),
            // ),
            // 4.vspace,
            // Divider(
            //   thickness: 2,
            //   color: Colors.grey.withOpacity(0.75),
            // )
            ],
          ),
        ),),
    );
  }
}