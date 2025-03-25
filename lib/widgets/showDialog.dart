import 'package:flutter/material.dart';

Future<void> showDeleteDialog(
    {required BuildContext context,required  Function() onPressed,required String title,required String name,}) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text("Are you sure you want to delete this $name ?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {

              onPressed();

            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text("Delete"),
          ),
        ],
      );
    },
  );
}