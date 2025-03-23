import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_project/admin/add_food/function/uploadImage.dart';
import 'package:my_project/main.dart';

import '../../../strings.dart';
import '../model/category_admin_model.dart';

Future<void> updateCategory(
    {required CategoryAdminModel model,
    File? file,
    required BuildContext context}) async {
  try {
    if (file != null) {
      String? url = await uploadImage(
          imageFile: file, pathFolder: 'categorys', context: context);
      if (url != null) {
        model.image = url;
      } else {
        throw 'Faild Image Upload';
      }
    }
    await supabase
        .from(Table_Categorys)
        .update(model.toJson())
        .eq('id', model.id);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Update Category Success')));
  } catch (er) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Failed to update Category')));

    rethrow;
  }
}
