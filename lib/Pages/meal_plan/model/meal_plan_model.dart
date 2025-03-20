import '../../shopping_cart/model/FoodOrderModel.dart';

class MealPlanModel {
  final FoodOrderModel orderModel;
  final int id;
  final DateTime createdAt;
  final int foodId;
  final int foodCount;
  final String idUser;
  final String price;
  final String status;
  final String admin;

  MealPlanModel({
    required Map<String, dynamic> json,
    required this.orderModel,
  })  : id = json['id'],
        createdAt = DateTime.parse(json['created_at'] as String),
        foodId = json['food_id'],
        foodCount = json['food_count'],
        idUser = json['id_user'],
        price = json['price'],
        status = json['statuse'],
        admin = json['admin'];

  // تحويل من كائن MealPlanModel إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'food_id': foodId,
      'food_count': foodCount,
      'id_user': idUser,
      'price': price,
      'statuse': status,
      'admin': admin,
    };
  }
}
