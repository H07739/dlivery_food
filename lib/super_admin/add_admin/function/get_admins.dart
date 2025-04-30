import 'package:my_project/main.dart';
import 'package:my_project/super_admin/add_admin/model/admin_model.dart';

import '../../../strings.dart';

Future<List<AdminModel>> getAdmins()async{
  try{
    List<Map<String,dynamic>> admins = await supabase.from(Table_Admins).select('*');
    return admins.map((e) => AdminModel.fromJson(e)).toList();
  }
      catch(er){
        throw 'A problem has occurred';
      }
}