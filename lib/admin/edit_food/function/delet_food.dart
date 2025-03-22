import 'package:flutter/material.dart';
import 'package:my_project/main.dart';
import 'package:my_project/strings.dart';

Future<void> deleteFood({required int idFood}) async {
  try {
    await supabase.from(Table_Food).delete().eq('id', idFood);
  } catch (e) {
    print('error deleting food : $e');
  }
}


