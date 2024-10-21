import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pmc/src/Views/Routes/route_name.dart';
import 'package:pmc/src/Views/Utilies/images.dart';
import 'package:pmc/src/Views/Utilies/sizedbox_widget.dart';
import 'package:pmc/src/Views/Widget/button_widget.dart';
import 'package:pmc/src/Views/Widget/onboard_text.dart';
import 'package:pmc/src/Views/Widget/phonefield_widget.dart';
import 'package:pmc/src/Views/Widget/textfield_drawpaint.dart';
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
  TextEditingController date = TextEditingController();
  bool showvalue = false;
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
        date.text = DateFormat.yMd().format(selectedDate);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
           margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 22,left: 4,right: 4,),
          padding:const EdgeInsets.all(8),
          decoration:const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.background),
              fit: BoxFit.fill
              ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                  Padding(
                padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width / 14,
                right: MediaQuery.of(context).size.width /14 ),
                child: Image.asset(AppImages.logo, 
               ),
              ),
                8.vspace,
                Center(
                  child: Text('Signup',style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                  ),),
                ),
              8.vspace,
              const OnBoardText(text: 'First name', color: Colors.white),
              8.vspace,
              TextFormWidget(hintText: 'Enter your first name', 
              color: Colors.white,
              fillColor: Colors.transparent,
              height: 66, width: MediaQuery.of(context).size.width, 
              topsize: 15, 
              textEditingController: firstname),
              8.vspace,
              const OnBoardText(text: 'Last name', color: Colors.white),
              8.vspace,
              TextFormWidget(hintText: 'Enter your Last name', 
              color: Colors.white,
               fillColor: Colors.transparent,
              height: 66, width: MediaQuery.of(context).size.width, 
              topsize: 15, 
              textEditingController: lastname),
              8.vspace,
              const OnBoardText(text: 'Email', color: Colors.white),
              8.vspace,
              TextFormWidget(hintText: 'Enter your Email', 
              color: Colors.white,
               fillColor: Colors.transparent,
              height: 66, width: MediaQuery.of(context).size.width, 
              topsize: 15, 
              textEditingController: email),
              8.vspace,
              const OnBoardText(text: 'Phone', color: Colors.white),
              8.vspace,
                PhoneNumberField(
            height: 66, 
            width: MediaQuery.of(context).size.width, 
            topsize: 15, 
            textEditingController: phone, hintText: 'Enter your phone', hintColor: Colors.white),
              8.vspace,
             const Padding(
                padding:  EdgeInsets.only(left:50.0),
                child: OnBoardText(text: 'Date of Birth', color: Colors.white),
              ),
              8.vspace,
              Padding(
                padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width / 12),
                child: CustomPaint(
                  painter:RectanglePainter(Colors.transparent,15),
                  child: SizedBox(
                    height: 66,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: date,
                         keyboardType: TextInputType.text,
                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                         decoration: InputDecoration(
                          suffixIcon: IconButton(onPressed: (){selectDate(context);}, icon:const Icon(Icons.calendar_month,color: Colors.white,)),
                          border: InputBorder.none,
                          hintText: 'DD/MM/YYYY',
                          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white)
                         ),
                      ),
                    ),
                  ),
                )
              ),
              16.vspace,
              Padding(
                padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width / 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                   Container( 
                    width: 36, 
                    height: 36, 
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
                      width: MediaQuery.of(context).size.width / 1.8,
                      child:const OnBoardText(text: 'I agree to the Terms of Service & Privacy Policy', color: Colors.white))
                  ],
                ),
              ),
              16.vspace,
              Padding(
                padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width / 12),
                child: CommonButtonWidget(
                  text: 'Continue', height: 50, width: MediaQuery.of(context).size.width, 
                  fillColor: Colors.yellow, borderColor: Colors.white, 
                  shadowColor: Colors.yellow, textColor: Colors.black, onPressed: (){  
                    Get.toNamed(Appnames.registerotp);
                  }),
              ),
              36.vspace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}