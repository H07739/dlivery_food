import '../../shopping_cart/model/FoodOrderModel.dart';

class MealPlanModel {
  FoodOrderModel orderModel;
  int id;
  DateTime createdAt;
  int foodId;
  int foodCount;
  String idUser;
  String price;
  String status;
  String admin;

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
      'food_count': foodCount,
      'price': price,
      'statuse': status,
    };
  }
}
