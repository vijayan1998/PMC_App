class Subscriptionget {
  final String id;
  final String fname;
  final String lname;
  final String recieptId;
  final String phone;
  final String email;
  final String amount; // Keep as String if it's returned as String
  final int course; // Same here
  final String subscriberId;
  final String subscription;
  final String plan;
  final String method;
  final bool active;
  final String date;
  final String user;
  final int tax;

 

  Subscriptionget({
    required this.id,
    required this.fname,
    required this.lname,
    required this.recieptId,
    required this.phone,
    required this.email,
    required this.amount,
    required this.course,
    required this.subscriberId,
    required this.subscription,
    required this.plan,
    required this.method,
    required this.active,
    required this.date,
    required this.user,
    required this.tax,
    
  });

  factory Subscriptionget.fromJson(Map<String, dynamic> json) {
    return Subscriptionget(
      id: json['_id'],
      fname: json['fname'],
      lname: json['lname'],
      recieptId: json['recieptId'],
      phone: json['phone'],
      email: json['email'],
      amount: json['amount'], // Parse as String
      course: json['course'], // Parse as String
      subscriberId: json['subscriberId'],
      subscription: json['subscription'], 
      plan: json['plan'],
      method: json['method'],
      active: json['active'], // Parse as bool
      date: json['date'],
      user: json['user'],
      tax: json['tax'],
    );
  }
}
