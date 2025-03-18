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
      'is_favorite': is_favorite,
    };
  }

  Future<void> addFood(FoodModel food) async {
    final prefs = await SharedPreferences.getInstance();

    // اbch yjib donnnnnnne mellllll base
    String? storedData = prefs.getString(FoodData);
    List<Map<String, dynamic>> foodList = [];

    if (storedData != null) {
      // تbch yb3th donne
      foodList = List<Map<String, dynamic>>.from(json.decode(storedData));
    }

    // اbch y3rf donner mwjouda bel food_id
    bool foodExists = foodList.any((item) => item['food_id'] == food.id);

    if (!foodExists) {
      // إkn mfmch donne yzidhe lel listet el food
      foodList.add(food.toJson());
      // حy5abi doneeeeeeeeeeee SharedPreferences
      await prefs.setString(FoodData, json.encode(foodList));
    } else {
      print("The food with ID ${food.id} already exists.");
    }
  }

  Future<void> removeFood(int foodId) async {
    final prefs = await SharedPreferences.getInstance();

    // اyraje3 donne ke String
    String? storedData = prefs.getString(FoodData);
    List<Map<String, dynamic>> foodList = [];

    if (storedData != null) {
      // تy7ewl donne  lel List
      foodList = List<Map<String, dynamic>>.from(json.decode(storedData));
    }

    // yfasa555  l'élément qui contient un food_id correspondant à foodId.
    foodList.removeWhere((item) => item['food_id'] == foodId);

    //حysejl kol chy f bas b3d te8yirat w te3dilet
    await prefs.setString('food_data', json.encode(foodList));
  }
}
