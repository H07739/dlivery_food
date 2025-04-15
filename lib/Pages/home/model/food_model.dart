
class FoodModel {
  final int id;
  final DateTime createdAt;
  final String name;
  final String image;
  final String description;
  final String price;
  final String category;
  final String seller;
  bool is_favorite = false;

  FoodModel({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.category,
    required this.seller,

  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at'] as String),
      name: json['name'],
      image: json['image'],
      description: json['description'],
      price: json['price'],
      category: json['categorys'],
      seller: json['admin'],

    );
  }

}
