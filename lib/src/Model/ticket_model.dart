class TicketModel {
  final String? id;
  final String? userid;
  final String? fname;
  final String? lname;
  final String? email;
  final String? phone;
  final String? category;
  final String? subject;
  final String? ticketid;
  final String? desc1;
  final String? desc2;
  final String? priority;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  TicketModel({this.id, this.userid, this.fname, this.lname, this.email, this.phone, this.category, this.subject, this.ticketid, this.desc1, this.desc2, this.priority, this.status, this.createdAt, this.updatedAt});

  factory TicketModel.fromJson(Map<String,dynamic>json){
    return TicketModel(
      id: json['_id'],
      userid: json['user'],
      fname: json['fname'],
      lname: json['lname'],
      email: json['email'],
      phone: json['phone'],
      ticketid: json['ticketId'],
      category: json['category'],
      subject: json['subject'],
      desc1: json['desc1'],
      desc2:json['desc2'],
      priority: json['priority'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt']

    );
  }
}