import 'package:intl/intl.dart';

class NotificationModel {
  final int id;
  final String idSender;
  final String idReceive;
  final String title;
  final String body;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.idSender,
    required this.idReceive,
    required this.title,
    required this.body,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      idSender: json['id_sender'],
      idReceive: json['id_receive'],
      title: json['title'],
      body: json['body'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_sender': idSender,
      'id_receive': idReceive,
      'title': title,
      'body': body,
      'created_at': createdAt.toIso8601String(),
    };
  }

  String get timeFormatted {
    return DateFormat.jm().format(createdAt); // مثال: 2:05 PM
  }
}
