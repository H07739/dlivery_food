import 'package:my_project/admin/edit_food/model/food_admin_model.dart';
import 'package:my_project/main.dart';
import 'package:my_project/strings.dart';

import '../../../Pages/home/function/getCategorys.dart';
import '../../../Pages/home/model/category_model.dart';
import '../model/EditFoodModel.dart';

Future<List<EditFoodModel>> getFoodsAdmin()async{
  try{
    List<EditFoodModel> list =  [];
    List<Map<String,dynamic>> result = await supabase.from(Table_Food).select('*').eq('admin', supabase.auth.currentUser!.id);
    List<CategoryModel> categories = await getCategory();
    result.forEach((Map<String, dynamic> data) {
      list.add(EditFoodModel(foodAdminModel: FoodAdminModel.fromJson(json: data), categoryModel: categories));
    });
    return list;
  }
      catch(er){
    print('Error in getFoodsAdmin function : $er');
    rethrow;
      }
}