import 'package:get/get.dart';

import '../model/EditFoodModel.dart';

class FoodController extends GetxController{
  RxList<EditFoodModel> foods = <EditFoodModel>[].obs;

  void addFood(EditFoodModel food) {
    foods.add(food);
  }

  void setFoods(List<EditFoodModel> newList) {
    foods.value = newList;
  }
  void deleteFood(int id) {
    foods.removeWhere((f) => f.foodAdminModel.id == id);
  }
  void updateFood(int id, EditFoodModel updatedFood) {
    int index = foods.indexWhere((f) => f.foodAdminModel.id == id);
    if (index != -1) {
      foods[index] = updatedFood;
    }
  }


}