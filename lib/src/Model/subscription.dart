class SubscriptionPlan {
  String? plan;
  String? amount;
  String? course;
  
  
  SubscriptionPlan( 
      { 
      this.plan,
      this.amount,
      this.course,
    
    });

factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(       
        plan: json['plan'],
        amount: json['amount'],
        course: json['course'],
      );
}

 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['plan'] = plan;
    data['amount'] = amount;
    data['course'] = course;
  
    return data;
  }

  @override
  String toString() {
    return 'SubscriptionPlan{plan: $plan, amount: $amount, course: $course}';
  }
  
}