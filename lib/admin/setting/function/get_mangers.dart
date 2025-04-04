import 'package:flutter/material.dart';
import 'package:my_project/admin/setting/model/manger_model.dart';

import '../../../main.dart';
import '../../../strings.dart';

Future<List<MangerModel>> getMangers(
    {required BuildContext context}) async {
  try {

    List<Map<String, dynamic>> result = await supabase.from(Table_Manger).select('*').eq('id_admin', supabase.auth.currentUser!.id);
    return result.map((data) => MangerModel.fromJson(data)).toList();



  } catch (e) {
    print('Error get mangers : $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Error in get manger error is : $e',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    ));
    rethrow;
  }
}
