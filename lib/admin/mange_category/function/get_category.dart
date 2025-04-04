import 'package:my_project/admin/mange_category/model/category_admin_model.dart';
import 'package:my_project/main.dart';
import 'package:my_project/strings.dart';

Future<List<CategoryAdminModel>> getCategory() async {
  try {
    List<Map<String,dynamic>> result = await supabase.from(Table_Categorys).select('*');
    return result.map((data) => CategoryAdminModel.fromJson(data)).toList();
  } catch (e) {
    print('error in get category : $e');
    rethrow;
  }
}
