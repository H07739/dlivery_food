import 'package:flutter/material.dart';
import 'package:my_project/main.dart';
import 'package:my_project/strings.dart';

Future<void> deleteFood({required int idFood,required BuildContext context}) async {
  try {
    await supabase.from(Table_Food).delete().eq('id', idFood);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete food successfully')));

  } catch (e) {
    print('error deleting food : $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete food Filders')));
  }
}


