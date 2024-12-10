import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pmc/src/Controller/ticket_controller.dart';
import 'package:pmc/src/Model/ticket_model.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';
import 'package:pmc/src/Views/Screens/Profile/helpview.dart';
import 'package:pmc/src/Views/Sharedpreference/user_controller.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/back_arrow_widget.dart';
import 'package:pmc/src/Views/Widget/gradient_button.dart';

class HelpandSupport extends StatefulWidget {
  const HelpandSupport({super.key});

  @override
  State<HelpandSupport> createState() => _HelpandSupportState();
}

class _HelpandSupportState extends State<HelpandSupport> {
  TicketController ticketController = Get.put(TicketController());
  UserController currentUser = Get.put(UserController());
  TextEditingController ticket = TextEditingController();
  String selectTicket ='';
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
        title: Text(
          'Help & Support',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ),
        elevation: 12,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            16.vspace,
            Center(
              child: GradientButtonWidget(
                text: 'Raise a Ticket',
                width: MediaQuery.of(context).size.width / 2,
                onTap: () {
                  Get.toNamed(Appnames.raise);
                },
              ),
            ),
            16.vspace,
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Your Support Tickets',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white.withOpacity(0.75),
                    ),
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.grey.withOpacity(0.75),
            ),
            8.vspace,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
              controller: ticket,
              onChanged: (value) {
                setState(() {
                  selectTicket = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search By Course Name',
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.grey.shade800),
                filled: true,
                fillColor: Colors.white,
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(16),
                )),
                prefixIcon: const Icon(Icons.search),
              ),
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Colors.grey.shade800, fontSize: 18),
                        ),
            ),
            24.vspace,
            FutureBuilder(
              future:
                  ticketController.getTicket(currentUser.user.id.toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('No ticket found'));
                } else {
                  List<TicketModel> ticket = snapshot.data!;
                  List<TicketModel> ticketList = ticket.where((tick) => tick.category!.toLowerCase().contains(selectTicket) ||
                  tick.status!.toLowerCase().contains(selectTicket)).toList();
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: ticketList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      DateTime parsedDate =
                          DateTime.parse(ticketList[index].updatedAt.toString());
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(parsedDate);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: HelpWidget(
                              text: "TicketId : ${ticketList[index].ticketid.toString()}",
                              text1: 'Category : ${ticketList[index].category}',
                              text2: 'Date : $formattedDate',
                              txt3: 'Status : ',
                              widget: Container(
                                padding: const EdgeInsets.all(6),
                                color: Colors.green,
                                child: Text(
                                  '${ticketList[index].status}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                              button: GradientButtonWidget(
                                text: 'View',
                                width: MediaQuery.of(context).size.width / 5,
                                onTap: () {
                                 
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => HelpViewScreen(
                                  fname: ticketList[index].fname,
                                  lname: ticketList[index].lname,
                                  ticketId: ticketList[index].ticketid,
                                  category: ticketList[index].category,
                                  priority: ticketList[index].priority,
                                  date: formattedDate,
                                  desc1: ticketList[index].desc1,
                                 )));
                                },
                              ),
                            ),
                          ),
                          4.vspace,
                          Divider(
                            thickness: 2,
                            color: Colors.grey.withOpacity(0.75),
                          ),
                          4.vspace,
                        ],
                      );
                    },
                  );
                }
              },
            ),
            24.vspace,
          ],
        ),
      ),
    );
  }
}

class HelpWidget extends StatelessWidget {
  final String text;
  final String text1;
  final String text2;
  final String txt3;
  final Widget widget;
  final Widget button;
  const HelpWidget(
      {super.key,
      required this.text,
      required this.text1,
      required this.text2,
      required this.txt3,
      required this.button,
      required this.widget});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: Colors.white),
            ),
            Text(
              text1,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: Colors.white),
            ),
            Text(
              text2,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: Colors.white),
            ),
            Row(
              children: [
                Text(
                  txt3,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: Colors.white),
                ),
                4.hspace,
                widget,
              ],
            ),
          ],
        ),
        button,
      ],
    );
  }
}
