import 'package:my_project/admin/setting/model/admin_model.dart';
import 'package:my_project/strings.dart';

import '../../../main.dart';

Future<AdminModel> getAdminData() async {
  try {
    List<Map<String, dynamic>> response = await supabase
        .from(Table_Admins)
        .select()
        .eq('uuid', supabase.auth.currentUser!.id);

    return AdminModel.fromJson(response.first);
  } catch (error) {
    rethrow;
  }
}
