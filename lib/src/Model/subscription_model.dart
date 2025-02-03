class SubscriptionModel{
  final String packagename;
  final String price;
  final String course;
  final int tax;
  final int inr;
  final String subtopic;
  final String coursetype;
 

  SubscriptionModel({required this.packagename,required this.price,required this.course,required this.tax,
  required this.coursetype,required this.subtopic,required this.inr});

  factory SubscriptionModel.fromJson(Map<String, dynamic> json){
    return SubscriptionModel(
      packagename: json['packagename'] ?? '', 
      price: json['price'].toString(), 
      course: json['course'].toString(), 
      tax: json['tax'], 
      inr: json['inr'],
      coursetype: json['coursetype'] ?? '', 
      subtopic: json['subtopic'] ?? '');
  }
}