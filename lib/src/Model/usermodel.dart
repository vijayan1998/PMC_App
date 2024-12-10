class Usermodel {
  String? id;
  String? fname;
  String? lname;
  String? email;
  String? phone;
  String? dob;
  String? type;
  String? company;
  
  Usermodel( 
      { 
      this.id,
      this.fname,
      this.lname,
      this.email,
      this.phone,
      this.dob,
      this.type,
      this.company,
    });

factory Usermodel.fromJson(Map<String, dynamic> json) {
  try {
    // Try to get data using userId key if present
    final userId = json['userId'];

    if (userId != null) {
      return Usermodel(
        id: userId['_id'],
        fname: userId['fname'],
        lname: userId['lname'],
        email: userId['email'],
        phone: userId['phone'],
        dob: userId['dob'],
        type: userId['type'],
        company: userId['company'],
      );
    } else {
      // If userId is not present, decode directly
      return Usermodel(
        id: json['_id'],
        fname: json['fname'],
        lname: json['lname'],
        email: json['email'],
        phone: json['phone'],
        dob: json['dob'],
        type: json['type'],
        company: json['company'],
      );
    }
  } catch (e) {
    throw Exception('Error decoding user data: $e');
  }
}

 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['fname'] = fname;
    data['lname'] = lname;
    data['email'] = email;
    data['phone'] = phone;
    data['dob'] = dob;
    data['type'] = type;
    data['company'] = company;
  
    return data;
  }

  @override
  String toString() {
    return 'Usermodel{_id: $id, fname: $fname, lname: $lname, email: $email, phone: $phone, dob: $dob, type: $type, company: $company}';
  }
  
}