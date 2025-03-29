import 'package:flutter/material.dart';
import '../../home/model/food_detail_model.dart';
import '../../home/model/food_model.dart';

class FoodOrderModel {
  // Number of dishes  
  ValueNotifier<int> count = ValueNotifier(1);

// List of selected additions  
  ValueNotifier<List<FoodDetailModelX>> selectedExtras = ValueNotifier([]);

// Total price  
  ValueNotifier<double> totalPrice = ValueNotifier(0.0);

  // Model food
  FoodModel foodModel;

  FoodOrderModel({required this.foodModel}) {
    _updateTotalPrice();
  }


  void toggleExtra(FoodDetailModelX extra) {
    if (selectedExtras.value.contains(extra)) {
      selectedExtras.value.remove(extra);
    } else {
      selectedExtras.value.add(extra);
    }
    selectedExtras.notifyListeners();
    _updateTotalPrice();
  }

// Update the quantity  
  void setCount(int newCount) {
    count.value = newCount;
    _updateTotalPrice();
  }

// Update the final price  
  void _updateTotalPrice() {
    double extrasPrice =
    selectedExtras.value.fold(0.0, (sum, extra) => sum + extra.price);
    totalPrice.value = (double.parse(foodModel.price) + extrasPrice) * count.value;
  }


}
