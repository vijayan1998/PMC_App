class Attachment {
  final String user;
  final String ticketId;
  final String createdby;
  final String attachment;
  final String attachmentid;

  Attachment({
    required this.user,
    required this.ticketId,
    required this.createdby,
    required this.attachment,
    required this.attachmentid,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      user: json['user'],
      ticketId: json['ticketId'],
      createdby:json['createdby'],
      attachment: json['attachment'],
      attachmentid: json['attachment_id'],
    );
  }
}