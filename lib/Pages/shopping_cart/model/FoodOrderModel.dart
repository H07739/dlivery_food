import 'package:flutter/material.dart';
import '../../home/model/food_detail_model.dart';
import '../../home/model/food_model.dart';

class FoodOrderModel {
  // عدد الأطباق
  ValueNotifier<int> count = ValueNotifier(1);

  // قائمة الإضافات المختارة
  ValueNotifier<List<FoodDetailModel>> selectedExtras = ValueNotifier([]);

  // السعر الإجمالي
  ValueNotifier<double> totalPrice = ValueNotifier(0.0);

  // موديل الطعام
  FoodModel foodModel;

  FoodOrderModel({required this.foodModel}) {
    _updateTotalPrice();
  }

  ValueNotifier<List<FoodDetailModel>> details = ValueNotifier([
    FoodDetailModel(name: 'Ketchup', price: 6, check: false),
    FoodDetailModel(name: 'Mayonnaise', price: 8, check: false),
    FoodDetailModel(name: 'Harissa', price: 4, check: false),
    FoodDetailModel(name: 'Egg', price: 5, check: false),
  ]);

  // تبديل اختيار الإضافة
  void toggleExtra(FoodDetailModel extra) {
    if (selectedExtras.value.contains(extra)) {
      selectedExtras.value.remove(extra);
    } else {
      selectedExtras.value.add(extra);
    }
    selectedExtras.notifyListeners();
    _updateTotalPrice();
  }

  // تحديث العدد
  void setCount(int newCount) {
    count.value = newCount;
    _updateTotalPrice();
  }

  // تحديث السعر النهائي
  void _updateTotalPrice() {
    double extrasPrice =
    selectedExtras.value.fold(0.0, (sum, extra) => sum + extra.price);
    totalPrice.value = (double.parse(foodModel.price) + extrasPrice) * count.value;
  }


}
