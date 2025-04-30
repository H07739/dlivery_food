import 'package:my_project/main.dart';
import 'package:my_project/strings.dart';

import '../model/admin_model.dart';

Future<void> deletedAdmin({required AdminModel admin})async{
  try{
    await supabase.from(Table_Admins).delete().eq('id', admin.id);
  }
      catch(error){
    rethrow;
      }
}