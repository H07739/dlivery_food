import 'package:flutter/material.dart';
import 'package:my_project/Pages/notification/model/notification_model.dart';

class ItemNotification extends StatelessWidget {

  NotificationModel model;
  ItemNotification({
    super.key,
    required this.model,
  });


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: const CircleAvatar(
          backgroundColor: Colors.deepOrange,
          child: Icon(Icons.notifications, color: Colors.white),
        ),

        title: Text(model.body),
        trailing: Text(
          model.timeFormatted,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ),
    );
  }
}
