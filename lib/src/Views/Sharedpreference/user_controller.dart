

import 'package:get/get.dart';
import 'package:pmc/src/Model/usermodel.dart';
import 'package:pmc/src/Views/Sharedpreference/user_preference.dart';

class UserController  extends GetxController {
  
final Rx<Usermodel> currentUser = Usermodel(id : '',fname: '', lname: '',email: '',type: '', phone: '',dob: '',company: '').obs;

  Usermodel get user => currentUser.value;

 getUserInfo() async {
  Usermodel? getUserInfoFromLocalStorage = await RememberUserPrefs.readUser();
 currentUser.value = getUserInfoFromLocalStorage!;
 
}
}