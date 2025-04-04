import 'package:flutter/material.dart';
import 'package:my_project/admin/setting/controller/controller_manger.dart';
import 'package:my_project/admin/setting/model/manger_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../main.dart';
import '../../../strings.dart';

Future<void> addManger(
    {required String email,
    required String name,
    required MangerController controller,
    required BuildContext context}) async {
  try {
    final response =
        await supabase.rpc('get_uuid_by_email', params: {'user_email': email});

    final uuid = response;
    var d = await supabase.from(Table_Manger).insert({
      'name': name,
      'id_user': uuid,
      'email': email,
      'id_admin': supabase.auth.currentUser!.id
    }).select('*');

    controller.addManager(MangerModel.fromJson(d[0]));

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Add Manger successfully',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
    ));




  } on PostgrestException catch (er) {
    print('Error adding manger : $er');
    if (er.code == '23502') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Email not found',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Faild in Add Manger  is : ${er.message}',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    ));
  } catch (e) {
    print('Error adding manger : $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Error in addManger error is : $e',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    ));
  }
}
