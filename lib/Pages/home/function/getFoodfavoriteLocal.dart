import 'dart:convert';
import 'package:my_project/Pages/home/model/food_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../strings.dart';

Future<List<FoodModel>> getFoodFavoriteLocal() async {
  final prefs = await SharedPreferences.getInstance();

  // استرجاع البيانات المخزنة كـ String
  String? storedData = prefs.getString(FoodData);

  if (storedData != null) {
    List<dynamic> jsonList = json.decode(storedData);
    List<FoodModel> foodList = jsonList.map((item) => FoodModel.fromJson(item)).toList();
    return foodList;
  } else {
    // إذا لم تكن البيانات موجودة، إرجاع قائمة فارغة
    return [];
  }
}
