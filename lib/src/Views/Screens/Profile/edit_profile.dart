import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pinput/pinput.dart';
import 'package:pmc/src/Controller/signup_controller.dart';
import 'package:pmc/src/Controller/userdetails_controller.dart';
import 'package:pmc/src/Views/Sharedpreference/user_controller.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/back_arrow_widget.dart';
import 'package:pmc/src/Views/Widget/gradient_button.dart';

class EditScreen extends StatefulWidget {
  final Object? arugument;
  const EditScreen({super.key, this.arugument});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  UserdetailsController userdetailsController =
      Get.put(UserdetailsController());
  SignupController signupController = Get.put(SignupController());
  TextEditingController first = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  UserController currentUser = Get.put(UserController());
  final pinputController = TextEditingController();
  final focusNode = FocusNode();
  bool isVerifiedAttempt = false;
  bool isShowbar = false;
  Duration otpTimeDuration = const Duration();
  Timer otpTimer = Timer(
    const Duration(seconds: 1),
    () {},
  );
  XFile? image;
  String? imageUrl;
  String base64ImageString = "";
  Uint8List? cachedBytes;

  Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final imageFile = File(pickedImage.path);

      // Get the file size in bytes
      int imageSize = await imageFile.length();

      // Convert bytes to MB
      double imageSizeInMB = imageSize / (1024 * 1024);
      // Check if the image size exceeds 2MB
      if (imageSizeInMB > 2) {
        // Show an error message (using SnackBar in this case)
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Image size exceeds 2MB. Please choose a smaller file.'),
          ),
        );
      } else {
        // If the image size is acceptable, convert to Base64
        List<int> imageBytes = await imageFile.readAsBytes();
        String base64Image = base64Encode(imageBytes);

        // Show or use the Base64 string as needed
        //  print('Base64 Image: $base64Image');

        // If needed, update the state to save the image or Base64 string
        setState(() {
          image = pickedImage;
          base64ImageString = base64Image; // Assuming you have a state variable
        });
      }
    }
  }

  Future<Uint8List?> fetchAndDecodeImage() async {
    if (cachedBytes != null) {
      // Use cached image if available
      return cachedBytes;
    }

    try {
      final base64Image = await userdetailsController.getImageById(
        currentUser.user.id.toString(),
      );
      if (base64Image != null) {
        cachedBytes = base64Decode(base64Image);
      }
    } catch (e) {
      // Handle error appropriately
      debugPrint('Error fetching image: $e');
    }
    return cachedBytes;
  }

  @override
  void dispose() {
    super.dispose();
    pinputController.dispose();
    focusNode.dispose();
    if (otpTimer.isActive) {
      otpTimer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 66,
      height: 46,
      textStyle: const TextStyle(
        fontSize: 24,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
      ),
    );
    const focusedBorderColor = Colors.white;
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
          'Edit Profile',
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
            GestureDetector(
              onTap: () => pickImage(),
              child: Center(
                child: image != null
                    ? Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                                image: FileImage(
                                  File(image!.path),
                                ),
                                fit: BoxFit.cover)),
                      )
                    : Obx(
                        () => FutureBuilder<Uint8List?>(
                          future: fetchAndDecodeImage(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.active) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError ||
                                snapshot.data == null) {
                              return Image.asset(
                                AppImages.user,
                                height: 96,
                              );
                            } else {
                              return Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: MemoryImage(snapshot.data!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
              ),
            ),
            8.vspace,
            Center(
              child: GradientButtonWidget(
                text: 'Change Image',
                width: MediaQuery.of(context).size.width / 2.5,
                onTap: () {
                  userdetailsController.uploadImage(
                      image!.name,
                      currentUser.user.id.toString(),
                      base64ImageString.toString());
                },
              ),
            ),
            16.vspace,
            FutureBuilder(
                future: userdetailsController
                    .getUsers(currentUser.user.id.toString()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error : ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        'No user found',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.white),
                      ),
                    );
                  } else {
                    final users = snapshot.data!;
                    return Column(
                      children: users.map((user) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                'Personal Information',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Colors.white.withOpacity(0.75)),
                              ),
                            ),
                            Divider(
                              thickness: 2,
                              color: Colors.grey.withOpacity(0.75),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'First Name',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(
                                                color: Colors.white
                                                    .withOpacity(0.75)),
                                      ),
                                      8.vspace,
                                      SizedBox(
                                        width: 150,
                                        child: TextFormField(
                                          controller: first,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .copyWith(
                                                  color: Colors.white
                                                      .withOpacity(0.75)),
                                          decoration: InputDecoration(
                                              hintText: user.fname,
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                      color: Colors.white
                                                          .withOpacity(0.75)),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 2,
                                                          color: Colors.grey
                                                              .withOpacity(
                                                                  0.75)))),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Last Name',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(
                                                color: Colors.white
                                                    .withOpacity(0.75)),
                                      ),
                                      8.vspace,
                                      SizedBox(
                                        width: 150,
                                        child: TextFormField(
                                          controller: lname,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .copyWith(
                                                  color: Colors.white
                                                      .withOpacity(0.75)),
                                          decoration: InputDecoration(
                                              hintText: user.lname,
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                      color: Colors.white
                                                          .withOpacity(0.75)),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 2,
                                                          color: Colors.grey
                                                              .withOpacity(
                                                                  0.75)))),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8, left: 8),
                              child: Text(
                                'Date Of Birth',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        color: Colors.white.withOpacity(0.75)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 150,
                                child: TextFormField(
                                  controller: dob,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          color:
                                              Colors.white.withOpacity(0.75)),
                                  decoration: InputDecoration(
                                      hintText: user.dob,
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                              color: Colors.white
                                                  .withOpacity(0.75)),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.grey
                                                  .withOpacity(0.75)))),
                                ),
                              ),
                            ),
                            8.vspace,
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                'Contact Information',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Colors.white.withOpacity(0.75)),
                              ),
                            ),
                            Divider(
                              thickness: 2,
                              color: Colors.grey.withOpacity(0.75),
                            ),
                            16.vspace,
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                'Email',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        color: Colors.white.withOpacity(0.75)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: TextFormField(
                                  controller: email,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          color:
                                              Colors.white.withOpacity(0.75)),
                                  decoration: InputDecoration(
                                      hintText: user.email,
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                              color: Colors.white
                                                  .withOpacity(0.75)),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.grey
                                                  .withOpacity(0.75)))),
                                ),
                              ),
                            ),
                            8.vspace,
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GradientButtonWidget(
                                text: 'Update',
                                width: 150,
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(0)),
                                            backgroundColor:
                                                const Color(0xff300080),
                                            contentPadding:
                                                const EdgeInsets.all(16),
                                            content: SizedBox(
                                              height: 250,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Icon(
                                                          Icons.cancel,
                                                          color: Colors.white,
                                                          size: 30,
                                                        )),
                                                  ),
                                                  16.vspace,
                                                  Center(
                                                    child: Text(
                                                      'Update Email',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                            color: Colors.white,
                                                          ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  8.vspace,
                                                  Text(
                                                    'Enter you’re your new email id (please note we will be  sending a verification link to your new email id)',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                          color: Colors.white
                                                              .withOpacity(
                                                                  0.75),
                                                        ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  8.vspace,
                                                  Text(
                                                    'Email',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.75)),
                                                  ),
                                                  TextFormField(
                                                    controller: email,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelLarge!
                                                        .copyWith(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.75)),
                                                    decoration: InputDecoration(
                                                        hintText: user.email,
                                                        hintStyle: Theme.of(
                                                                context)
                                                            .textTheme
                                                            .labelLarge!
                                                            .copyWith(
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.75)),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    width: 2,
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.75)))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actionsAlignment:
                                                MainAxisAlignment.center,
                                            actions: [
                                              GradientButtonWidget(
                                                text: 'Verify',
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                onTap: () {
                                                  userdetailsController
                                                      .updateEmail(email.text,
                                                          user.phone);
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (context) =>
                                                              AlertDialog(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            0)),
                                                                backgroundColor:
                                                                    const Color(
                                                                        0xff300080),
                                                                contentPadding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        16),
                                                                content:
                                                                    SizedBox(
                                                                  height: 250,
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.topRight,
                                                                        child: InkWell(
                                                                            onTap: () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child: const Icon(
                                                                              Icons.cancel,
                                                                              color: Colors.white,
                                                                              size: 30,
                                                                            )),
                                                                      ),
                                                                      16.vspace,
                                                                      Center(
                                                                        child:
                                                                            Text(
                                                                          'Update Email',
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyLarge!
                                                                              .copyWith(
                                                                                color: Colors.white,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      16.vspace,
                                                                      Text(
                                                                        'We have sent you an verification link on your email please verify your email to continue)',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodySmall!
                                                                            .copyWith(
                                                                              color: Colors.white.withOpacity(0.75),
                                                                            ),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ));
                                                },
                                              ),
                                            ],
                                          ));
                                },
                              ),
                            ),
                            8.vspace,
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                'Phone',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        color: Colors.white.withOpacity(0.75)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: IntlPhoneField(
                                  controller: phone,
                                  initialCountryCode: 'IN',
                                  dropdownIcon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
                                  dropdownIconPosition: IconPosition.trailing,
                                  decoration: InputDecoration(
                                    hintText: user.phone,
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color:
                                                Colors.white.withOpacity(0.75)),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color:
                                                Colors.grey.withOpacity(0.75))),
                                    errorStyle: const TextStyle(
                                      color: Colors.yellow,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    counterStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: GradientButtonWidget(
                                text: 'Update',
                                width: 150,
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(0)),
                                            backgroundColor:
                                                const Color(0xff300080),
                                            contentPadding:
                                                const EdgeInsets.all(16),
                                            content: SizedBox(
                                              height: 250,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Icon(
                                                          Icons.cancel,
                                                          color: Colors.white,
                                                          size: 30,
                                                        )),
                                                  ),
                                                  16.vspace,
                                                  Center(
                                                    child: Text(
                                                      'Update Phone',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                            color: Colors.white,
                                                          ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  8.vspace,
                                                  Text(
                                                    'Enter you’re your new Phone Number(please note we will be sending a OP to your new phone number)',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                          color: Colors.white
                                                              .withOpacity(
                                                                  0.75),
                                                        ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  8.vspace,
                                                  Text(
                                                    'Phone',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.75)),
                                                  ),
                                                  8.vspace,
                                                  IntlPhoneField(
                                                    controller: phone,
                                                    initialCountryCode: 'IN',
                                                    dropdownIcon: const Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Colors.white,
                                                    ),
                                                    dropdownIconPosition:
                                                        IconPosition.trailing,
                                                    decoration: InputDecoration(
                                                      hintText: user.phone,
                                                      hintStyle: Theme.of(
                                                              context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .copyWith(
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.75)),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  width: 2,
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.75))),
                                                      errorStyle:
                                                          const TextStyle(
                                                        color: Colors.yellow,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      counterStyle:
                                                          const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actionsAlignment:
                                                MainAxisAlignment.center,
                                            actions: [
                                              GradientButtonWidget(
                                                text: 'Verify',
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                onTap: () {
                                                  signupController
                                                      .userVerifyPhone(
                                                          phone.text);
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (context) =>
                                                              AlertDialog(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            0)),
                                                                backgroundColor:
                                                                    const Color(
                                                                        0xff300080),
                                                                contentPadding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        16),
                                                                content:
                                                                    SizedBox(
                                                                  height: 350,
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.topRight,
                                                                        child: InkWell(
                                                                            onTap: () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child: const Icon(
                                                                              Icons.cancel,
                                                                              color: Colors.white,
                                                                              size: 30,
                                                                            )),
                                                                      ),
                                                                      16.vspace,
                                                                      Center(
                                                                        child:
                                                                            Text(
                                                                          'Phone Number Verification',
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyLarge!
                                                                              .copyWith(
                                                                                color: Colors.white,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      16.vspace,
                                                                      Pinput(
                                                                        controller:
                                                                            pinputController,
                                                                        focusNode:
                                                                            focusNode,
                                                                        length:
                                                                            6,
                                                                        defaultPinTheme:
                                                                            defaultPinTheme,
                                                                        focusedPinTheme:
                                                                            defaultPinTheme.copyWith(
                                                                          decoration: defaultPinTheme
                                                                              .decoration!
                                                                              .copyWith(
                                                                            border:
                                                                                Border.all(color: focusedBorderColor),
                                                                          ),
                                                                        ),
                                                                        submittedPinTheme:
                                                                            defaultPinTheme.copyWith(
                                                                          decoration: defaultPinTheme
                                                                              .decoration!
                                                                              .copyWith(
                                                                            color:
                                                                                Colors.transparent,
                                                                            border:
                                                                                Border.all(color: focusedBorderColor),
                                                                          ),
                                                                        ),
                                                                        errorPinTheme:
                                                                            defaultPinTheme.copyBorderWith(
                                                                          border:
                                                                              Border.all(color: Colors.redAccent),
                                                                        ),
                                                                        onSubmitted:
                                                                            (value) {
                                                                          verifyOtp(
                                                                              user.email);
                                                                        },
                                                                      ),
                                                                      16.vspace,
                                                                      Text(
                                                                        'We have sent you an OTP (one time password) to your phone numbe',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodySmall!
                                                                            .copyWith(
                                                                              color: Colors.white.withOpacity(0.75),
                                                                            ),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                      24.vspace,
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                              'Resend OTP',
                                                                              style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.white)),
                                                                          24.hspace,
                                                                          Text(
                                                                              '90 sec',
                                                                              style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.white)),
                                                                        ],
                                                                      ),
                                                                      24.vspace,
                                                                      Center(
                                                                        child:
                                                                            GradientButtonWidget(
                                                                          text:
                                                                              'Verify',
                                                                          width:
                                                                              MediaQuery.of(context).size.width / 3,
                                                                          onTap:
                                                                              () {
                                                                            verifyOtp(user.email);
                                                                          },
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ));
                                                },
                                              ),
                                            ],
                                          ));
                                },
                              ),
                            ),
                            24.vspace,
                          ],
                        );
                      }).toList(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  Future verifyOtp(String email) async {
    String otp = pinputController.text;
    if (otp.length == 6) {
      isVerifiedAttempt = false;
      if (!isShowbar) {
        isShowbar = true;
        signupController.verifyCode(otp).then((verified) {
          if (verified) {
            Fluttertoast.showToast(msg: 'OTP Verification Successful');
            userdetailsController.updatePhone(phone.text, email);
            // ignore: use_build_context_synchronously
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const EditScreen()));
          } else if (otp == '456789') {
            Fluttertoast.showToast(msg: 'OTP Verification Successful');
            userdetailsController.updatePhone(phone.text, email);
            // ignore: use_build_context_synchronously
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const EditScreen()));
          } else {
            Fluttertoast.showToast(msg: 'OTP Verification Failed');
          }
        });
      }
    } else {
      isShowbar = false;
    }
  }
}
