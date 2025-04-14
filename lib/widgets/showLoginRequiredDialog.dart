import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/Pages/auth/auth_view.dart';

Future<void> showLoginRequiredDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Notice'),
      content: Text('You need to be logged in to perform this action.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
            Get.offAll(AuthView());
          },
          child: Text('Login'),
        ),
      ],
    ),
  );
}
