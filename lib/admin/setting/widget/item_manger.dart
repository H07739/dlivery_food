import 'package:flutter/material.dart';
import 'package:my_project/admin/setting/controller/controller_manger.dart';
import 'package:my_project/admin/setting/function/delete_manger.dart';

import '../model/manger_model.dart';

class ItemManger extends StatelessWidget {
  ItemManger({super.key,required this.model,required this.controller});
  MangerModel model;
  MangerController controller;
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: model.name);
    return Card(
      child: ListTile(
        title: TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (newName) {

           print('New name for $newName');
            // مثال: updateMangerName(manager.id, newName);
          },
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${model.email}'),
            Text('Created At: ${model.createdAt.toString()}'),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () async{
            await deleteManger(model: model, controller: controller, context: context);

          },
        ),
      ),
    );
  }
}
