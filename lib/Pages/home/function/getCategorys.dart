import 'package:my_project/Pages/home/model/category_model.dart';
import 'package:my_project/main.dart';

import '../../../strings.dart';

Future<List<CategoryModel>> getCategory() async {
  try {
    final List<Map<String, dynamic>> c = await supabase.from(Table_Categorys).select('*');

    return List<CategoryModel>.from(c.map((json) => CategoryModel.fromJson(json)));

  } catch (er) {
    print('Error in getCategory: $er');
    rethrow;
  }
}