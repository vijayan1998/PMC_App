import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pmc/src/Controller/signup_controller.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/bottom_widget.dart';
import 'package:pmc/src/Views/Widget/gradient_button.dart';
import 'package:pmc/src/Views/Widget/phonefield_widget.dart';
import 'package:pmc/src/Views/Widget/textformfield_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController dob = TextEditingController();
  bool showvalue = false;
    bool isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  String? setDate = "DD-MM-YYYY";
  String? dateTime;
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1960),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dob.text = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }

  SignupController signupController = Get.put(SignupController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        //  color: Color(0xff300080),
        image: DecorationImage(
            image: AssetImage(AppImages.background2), fit: BoxFit.fill),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 24,
                        left: MediaQuery.of(context).size.width / 14,
                        right: MediaQuery.of(context).size.width / 14),
                    child: Image.asset(
                      AppImages.logo,
                    ),
                  ),
                  8.vspace,
                  Center(
                    child: Text(
                      'Create an account',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                  16.vspace,
                  Row(
                    children: [
                      Text(
                        'First Name',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      Text(
                        ' *',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ],
                  ),
                  8.vspace,
                  TextFormWidget(
                      hintText: 'e.g John',
                      color: Colors.grey.shade800,
                      fillColor: Colors.transparent,
                      textEditingController: firstname,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value){
                        if (value!.isEmpty) {
                          return 'Please Required Lastname';
                        } else if (RegExp(
                                r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+ [A-Za-z]+\.?\s*$")
                            .hasMatch(value)) {
                          return 'Enter Correct Lastname';
                        } else {
                          return null;
                        }
                      },),
                  8.vspace,
                  Row(
                    children: [
                      Text(
                        'Last Name',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      Text(
                        ' *',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ],
                  ),
                  8.vspace,
                  TextFormWidget(
                      hintText: 'e.g Doe',
                      color: Colors.grey.shade800,
                      fillColor: Colors.transparent,
                      textEditingController: lastname,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value){
                        if (value!.isEmpty) {
                          return 'Please Required Lastname';
                        } else if (RegExp(
                                r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+ [A-Za-z]+\.?\s*$")
                            .hasMatch(value)) {
                          return 'Enter Correct Lastname';
                        } else {
                          return null;
                        }
                      },),
                  8.vspace,
                  Row(
                    children: [
                      Text(
                        'Email',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      Text(
                        ' *',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ],
                  ),
                  8.vspace,
                  TextFormWidget(
                      hintText: 'example@gmail.com',
                      color: Colors.grey.shade800,
                      fillColor: Colors.transparent,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textEditingController: email,
                      validator: (value){
                        if (value!.isEmpty) {
                        return 'Please Required Email';
                      } else if (!RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                          .hasMatch(value)) {
                        return 'Enter correct Email';
                      } else {
                        return null;
                      }
                      },),
                  8.vspace,
                  Row(
                    children: [
                      Text(
                        'Phone',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      Text(
                        ' *',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ],
                  ),
                  8.vspace,
                  PhoneNumberField(
                      textEditingController: phone,
                      hintText: '  Enter phone',
                      hintColor: Colors.grey.shade800),
                  8.vspace,
                  Row(
                    children: [
                      Text(
                        'Date of Birth',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      Text(
                        ' *',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ],
                  ),
                  8.vspace,
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: dob,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.grey.shade800
                    ),
                    decoration: InputDecoration(
                      hintText: 'DD/MM/YYYY',
                      hintStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.grey.shade800,
                          ),
                      filled: true,
                      suffixIcon: IconButton(onPressed: (){
                        selectDate(context);
                      },icon: Icon(Icons.calendar_month,color: Colors.grey.shade800,)),
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.only(top: 12,left: 8),
                      border: InputBorder.none,
                    ),
                  ),
                 
                  16.vspace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        alignment: Alignment.center, // Alignment as center
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFF09869),
                              Color(0xFFC729B2),
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              showvalue = !showvalue;
                            });
                          },
                          child: showvalue
                              ? const Icon(Icons.check_rounded, color: Colors.white)
                              : Padding(
                                  padding: const EdgeInsets.all(2.5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                        ),
                      ),
                      8.hspace,
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 1.3,
                          child: Row(
                            children: [
                              Text(
                                'I agree to the',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(color: Colors.white, fontSize: 16),
                              ),
                              InkWell(
                                onTap: (){
                                  Get.toNamed(Appnames.termsofservice);
                                },
                                child: Text(
                                  ' Terms of Service',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          // color: const Color(0xff4C07F4),
                                          color: const Color(0xff10d6cd),
                                          fontSize: 16),
                                ),
                              ),
                              Text(
                                '  & ',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: InkWell(
                      onTap: (){
                        Get.toNamed(Appnames.privacypolice);
                      },
                      child: Text(
                        'Privacy Policy',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            //color: const Color(0xff4C07F4),
                            color: const Color(0xff10d6cd),
                            fontSize: 16),
                      ),
                    ),
                  ),
                  36.vspace,
                  Center(
                      child: GradientButtonWidget(
                    text: 'Continue',
                    width: 200,
                    isWaiting: isLoading,
                    onTap: () async {
                      if(formKey.currentState!.validate()){
                      }
                      if (showvalue == false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Please accept Terms & Privacy")),);
                      } else {
                        if(isLoading) return;
                        signupController.userVerifyPhone(phone.text);
                        setState(() {
                        isLoading = true;
                      });
                      await Future.delayed(const Duration(seconds: 2),(){
                      Get.toNamed(Appnames.registerotp,arguments: [email.text,firstname.text,
                        lastname.text,phone.text,dob.text]);
                      });
                      setState(() {
                        isLoading = false;
                      });
                      }
                    },
                  )),
                  36.vspace,
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const BottomWidget(),
      ),
    );
  }
}
