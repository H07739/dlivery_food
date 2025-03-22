import 'package:my_project/admin/edit_food/model/food_admin_model.dart';

import '../../../Pages/home/model/category_model.dart';

class EditFoodModel{
  FoodAdminModel foodAdminModel;
  List<CategoryModel> categoryModel;
  EditFoodModel({required this.foodAdminModel,required this.categoryModel});
}