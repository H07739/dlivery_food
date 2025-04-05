import 'package:flutter/material.dart';
import 'package:my_project/admin/setting/controller/controller_manger.dart';
import 'package:my_project/main.dart';

import '../../../strings.dart';
import '../model/manger_model.dart';

Future<void> updateNameManger(
    {required BuildContext context,
    required MangerModel model,
    required MangerController controller}) async {
  try {
    await supabase
        .from(Table_Manger)
        .update({'name': model.name}).eq('id', model.id);
    controller.updateManagerName(model.id, model.name);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      'update Name Manger Success',
      style: TextStyle(color: Colors.white),
    ),backgroundColor: Colors.green,));
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Failed to update name manger',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    ));
    print('Failed to update name manger : $e');
  }
}
