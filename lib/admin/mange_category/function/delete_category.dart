import 'package:flutter/material.dart';
import 'package:my_project/admin/mange_category/function/deleteImage.dart';
import 'package:my_project/main.dart';

import '../../../strings.dart';
import '../model/category_admin_model.dart';

Future<void> deleteCategory({required CategoryAdminModel model, required BuildContext context}) async{
  try {
    await supabase.from(Table_Categorys).delete().eq('id', model.id);
    await deleteImage(model.image);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Delete Category Success')));
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Delete Category Failed')));
    rethrow;
  }
}
