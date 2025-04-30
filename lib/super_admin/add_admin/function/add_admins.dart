import 'package:my_project/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../strings.dart';
import '../model/admin_model.dart';

Future<AdminModel> addAdmins({required String email,required String name,required String restaurantAdmin,required String phone,required String address}) async {
  try {
    var idAdmin = await supabase.rpc('get_uuid_by_email',params: {'user_email':email});

    if(idAdmin == null){
      throw 'Email Not Found';
    }

    List<Map<String,dynamic>> response =  await supabase.from(Table_Admins).insert({
      'uuid':idAdmin,
      'super_admin':supabase.auth.currentUser!.id,
      'name':name,
      'restaurant_admin':restaurantAdmin,
      'email':email,
      'phone':phone,
      'address':address
    }).select();
   return AdminModel.fromJson(response.first);
  }on PostgrestException catch(error){
    if(error.code == '23505'){
      throw 'Admin is already there';
    }
    else{
      print(error);
      throw 'A problem has occurred';
    }

  } catch (er) {
    if(er.toString().contains('Email Not Found')) throw 'Email Not Found';
    print(er);
  throw 'A problem has occurred';
  }
}
