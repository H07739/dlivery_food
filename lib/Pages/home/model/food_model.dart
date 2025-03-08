import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../strings.dart';

class FoodModel {
  final int id;
  final DateTime createdAt;
  final String name;
  final String image;
  final String description;
  final String price;
  final String category;
  final String seller;
  bool is_favorite;
  final String manager;
  FoodModel({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.category,
    required this.seller,
    required this.is_favorite,
    required this.manager,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['food_id'],
      createdAt: DateTime.parse(json['created_at'] as String),
      name: json['food_name'],
      image: json['food_image'],
      description: json['food_description'],
      price: json['food_price'],
      category: json['categorys'],
      seller: json['manager'],
      is_favorite: json['is_favorite'],
      manager: json['manager'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'food_id': id,
      'created_at': createdAt.toIso8601String(),
      'food_name': name,
      'food_image': image,
      'food_description': description,
      'food_price': price,
      'categorys': category,
      'manager': manager,
      'is_favorite': is_favorite,
    };
  }

  Future<void> addFood(FoodModel food) async {
    final prefs = await SharedPreferences.getInstance();

    // استرجاع البيانات المخزنة كـ String
    String? storedData = prefs.getString(FoodData);
    List<Map<String, dynamic>> foodList = [];

    if (storedData != null) {
      // تحويل البيانات المخزنة إلى List
      foodList = List<Map<String, dynamic>>.from(json.decode(storedData));
    }

    // التحقق إذا كانت البيانات موجودة بالفعل باستخدام food_id
    bool foodExists = foodList.any((item) => item['food_id'] == food.id);

    if (!foodExists) {
      // إذا لم تكن البيانات موجودة، أضفها إلى القائمة
      foodList.add(food.toJson());
      // حفظ البيانات مرة أخرى في SharedPreferences
      await prefs.setString(FoodData, json.encode(foodList));
    } else {
      print("The food with ID ${food.id} already exists.");
    }
  }

  Future<void> removeFood(int foodId) async {
    final prefs = await SharedPreferences.getInstance();

    // استرجاع البيانات المخزنة كـ String
    String? storedData = prefs.getString(FoodData);
    List<Map<String, dynamic>> foodList = [];

    if (storedData != null) {
      // تحويل البيانات المخزنة إلى List
      foodList = List<Map<String, dynamic>>.from(json.decode(storedData));
    }

    // حذف العنصر الذي يحتوي على food_id مطابق للـ foodId
    foodList.removeWhere((item) => item['food_id'] == foodId);

    // حفظ البيانات المعدلة
    await prefs.setString('food_data', json.encode(foodList));
  }


}