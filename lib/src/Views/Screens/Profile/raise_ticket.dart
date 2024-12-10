import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pmc/src/Controller/ticket_controller.dart';
import 'package:pmc/src/Views/Sharedpreference/user_controller.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/back_arrow_widget.dart';
import 'package:pmc/src/Views/Widget/gradient_button.dart';

class RaiseTicketScreen extends StatefulWidget {
  const RaiseTicketScreen({super.key});

  @override
  State<RaiseTicketScreen> createState() => _RaiseTicketScreenState();
}

class _RaiseTicketScreenState extends State<RaiseTicketScreen> {
  TextEditingController subject = TextEditingController();
  TextEditingController desc = TextEditingController();
  TicketController ticketController = Get.put(TicketController());
  UserController currentUser = Get.put(UserController());
  String? selectedValue;
  List<Map<String, dynamic>> categories = [];
  String? selectedCategory;
  List<DropdownMenuItem> droplist = [
    const DropdownMenuItem(
      value: 'Low',
      child: Text('Low'),
    ),
    const DropdownMenuItem(
      value: 'Medium',
      child: Text('Medium'),
    ),
    const DropdownMenuItem(
      value: 'High',
      child: Text('High'),
    ),
  ];

  clickEvent(String value) async {
    selectedValue = value;
  }

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      final fetchedCategories = await ticketController.fetchCategories();
      setState(() {
        categories = fetchedCategories;
      });
    } catch (error) {
      // Handle error
      if (kDebugMode) {
        print('Error fetching categories: $error');
      }
    }
  }

  Future<void> pickFiles() async {
    try {
      final pickedFiles = await ImagePicker().pickMultiImage();

      for (var file in pickedFiles) {
        final fileBytes = await file.readAsBytes();
        final fileSizeInKB = fileBytes.lengthInBytes / 1024;

        if (fileSizeInKB <= 400) {
          if (ticketController.selectedFiles.length < 5) {
            setState(() {
              ticketController.selectedFiles.add(file);
            });
          } else {
            Fluttertoast.showToast(
              msg: 'You can only select up to 5 images in total',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 15.0,
            );
            break;
          }
        } else {
          Fluttertoast.showToast(
            msg: 'File ${file.name} exceeds 400KB and was not added',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 15.0,
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error picking files: $e');
      }
    }
  }

  void removeFile(int index) {
    setState(() {
      ticketController.selectedFiles.removeAt(index);
    });
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
          'Raise a Ticket',
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
            children: [
              Center(
                child: Text(
                  'Raise A Ticket',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.white.withOpacity(0.75),
                      ),
                ),
              ),
              16.vspace,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Select Category',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.white.withOpacity(0.75)),
                  ),
                  Text(
                    ' *',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
              DropdownButtonFormField(
                hint: Text('Select Category',style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.grey.shade800,
                      ),),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.white,
                  constraints:const BoxConstraints(
                    maxHeight: 54,
                    minHeight: 54
                  )
                ),
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.grey.shade800, fontSize: 18),
                iconEnabledColor: Colors.black,
                iconSize: 26,
                dropdownColor: Colors.white,
                items: categories.map((categories) {
                  return DropdownMenuItem<String>(
                    value: categories[
                        'category'], // Use the unique ID or other key
                    child: Text(
                      categories['category'] ?? 'Unnamed Category',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: Colors.black.withOpacity(0.75)),
                    ),
                  );
                }).toList(),
                value: selectedCategory,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
              24.vspace,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Subject',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.white.withOpacity(0.75)),
                  ),
                  Text(
                    ' *',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: TextFormField(
                  controller: subject,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.grey.shade800,
                      ),
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      hintText: 'Enter Subject',
                      hintStyle:
                          Theme.of(context).textTheme.labelMedium!.copyWith(
                                color: Colors.grey.shade800,
                              ),
                      alignLabelWithHint: true,
                      fillColor: Colors.white,
                      filled: true),
                ),
              ),
              24.vspace,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.white.withOpacity(0.75)),
                  ),
                  Text(
                    ' *',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: TextFormField(
                  controller: desc,
                  minLines: 7,
                  maxLines: null,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.grey.shade800,
                      ),
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      hintText: 'Describe Your issue',
                      hintStyle:
                          Theme.of(context).textTheme.labelMedium!.copyWith(
                                color: Colors.grey.shade800,
                              ),
                      alignLabelWithHint: true,
                      fillColor: Colors.white,
                      filled: true),
                ),
              ),
              24.vspace,
              Text(
                'Attachments (you can select multiple files) ',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Colors.white.withOpacity(0.75)),
              ),
              4.vspace,
              InkWell(
                onTap: pickFiles,
                child: Container(
                  height: 46,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 46,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(4),
                                bottomRight: Radius.circular(4)),
                            color: Colors.grey.withOpacity(0.75)),
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Choose Files',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: Colors.grey.shade800),
                        ),
                      ),
                      12.hspace,
                      Text(
                        '${ticketController.selectedFiles.length} Files Choosen',
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: Colors.grey.shade800,
                                ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ticketController.selectedFiles.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 5),
                    leading: const Icon(Icons.file_present),
                    title: Text(
                      ticketController.selectedFiles[index].name,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () => removeFile(index),
                    ),
                  );
                },
              ),
              24.vspace,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Select Priority',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.white.withOpacity(0.75)),
                  ),
                  Text(
                    ' *',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
              4.vspace,
              DropdownButtonFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.white,
                  constraints:const BoxConstraints(
                    maxHeight: 54,
                    minHeight: 54
                  )
                ),
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: Colors.grey.shade800, fontSize: 18),
                iconEnabledColor: Colors.black,
                iconSize: 26,
                hint: Text('Select Priority',style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.grey.shade800,
                      )),
                dropdownColor: Colors.white,
                items: droplist,
                value: selectedValue,
                onChanged: (value) {
                  setState(() {
                    clickEvent(value);
                  });
                },
              ),
              24.vspace,
              Center(
                child: GradientButtonWidget(
                  text: 'Raise a Ticket',
                  width: MediaQuery.of(context).size.width / 2,
                  onTap: () {
                    ticketController.raiseTicket(
                        currentUser.user.id.toString(),
                        currentUser.user.fname.toString(),
                        currentUser.user.lname.toString(),
                        currentUser.user.email.toString(),
                        currentUser.user.phone.toString(),
                        selectedCategory.toString(),
                        subject.text,
                        desc.text,
                        selectedValue.toString());
                  },
                ),
              ),
              16.vspace,
            ],
          ),
        ),
      ),
    );
  }
}
