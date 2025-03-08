import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notification',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        elevation: 2,
        shadowColor: Colors.grey.withOpacity(0.5),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Text('how are you'),
    );
  }
}
