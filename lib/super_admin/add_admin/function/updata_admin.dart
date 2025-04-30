import 'package:my_project/super_admin/add_admin/model/admin_model.dart';

import '../../../main.dart';
import '../../../strings.dart';

Future<AdminModel> updateAdmins({required AdminModel admin}) async {
  try {
    var idAdmin = await supabase.rpc('get_uuid_by_email',params: {'user_email':admin.email});

    if(idAdmin == null){
      throw 'Email Not Found';
    }
    admin.idAdmin = idAdmin;

  List<Map<String, dynamic>> response = await supabase
        .from(Table_Admins)
        .update(admin.toMap())
        .eq('id', admin.id)
        .select();

    if (response.isEmpty) {
      throw 'Admin not found or update failed';
    }

    return AdminModel.fromJson(response.first);
  } catch (er) {
    rethrow;
  }
}
