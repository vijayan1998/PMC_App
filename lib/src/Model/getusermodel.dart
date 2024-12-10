
class GetUserModel{
  final String id;
  final String fname;
  final String lname;
  final String email;
  final String phone;
  final String dob;
  final String type;
  final String company;

  GetUserModel({required this.id,required this.fname,required this.lname,required this.email,
  required this.phone,required this.company,required this.dob,required this.type});

 factory GetUserModel.fromJson(Map<String, dynamic> json) {
  return GetUserModel(
    id: json['_id'] ?? '', // Provide default values if necessary
    fname: json['fname'] ?? '',
    lname: json['lname'] ?? '',
    email: json['email'] ?? '',
    phone: json['phone'] ?? '',
    company: json['company'] ?? '',
    dob: json['dob'] ?? '',
    type: json['type'] ?? '',
  );
}

}