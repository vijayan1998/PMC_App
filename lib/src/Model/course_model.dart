
class CourseModel{
  final String? id;
  final String? user;
  final String? content;
  final String? type;
  final String? mainTopic;
  final String? photo;
  final bool? completed;
  final String? date;
  final String? end;

  CourseModel({ this.id,  this.user, this.content,
   this.type, this.mainTopic, this.photo, this.completed,
   this.date, this.end,});

  factory CourseModel.fromJson(Map<String,dynamic>json){
    return CourseModel(
      id: json['_id'], 
      user: json['user'], 
      content: json['content'], 
      type: json['type'], 
      mainTopic: json['mainTopic'], 
      photo: json['photo'], 
      completed: json['completed'] ?? false, 
      date: json['date'], 
      end: json['end']);
  }
}