
import 'package:get/get.dart';
import 'package:pmc/src/Model/subscription.dart';
import 'package:pmc/src/Views/Sharedpreference/subscription_preference.dart';

class Subscription  extends GetxController {
  
final Rx<SubscriptionPlan> currentUser = SubscriptionPlan(plan : '',amount: '', course: '').obs;

  SubscriptionPlan get user => currentUser.value;

 getUserInfo() async {
  SubscriptionPlan? getUserInfoFromLocalStorage = await Remembersubscription.readUser();
 currentUser.value = getUserInfoFromLocalStorage!;
 
}
}