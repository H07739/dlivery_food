import 'package:flutter/material.dart';
import 'package:my_project/DataBase/OrderManager.dart';
import 'package:my_project/Pages/home/model/food_detail_model.dart';
import '../model/food_model.dart';



// void addFoodToCart({
//   required BuildContext context,
//   required FoodDetailListModel detailListModel,
//   required FoodModel foodModel,
//   required String id
// }) {
//   try {
//
//     final newItem = FoodItemCart(detailListModel: detailListModel, foodModel: foodModel,id: id);
//
//
//     ShoppingCartDB.itemsShoppingFood.value = List.from(ShoppingCartDB.itemsShoppingFood.value)..add(newItem);
//
//
//     if (context.mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Added to cart successfully')),
//       );
//     }
//   } catch (er) {
//     if (context.mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $er')),
//       );
//     }
//     print('Error: $er');
//   }
// }
