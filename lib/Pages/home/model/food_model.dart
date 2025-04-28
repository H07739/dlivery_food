
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
  int? rival;
  String priceOld;
  String restaurant;

  FoodModel({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.category,
    required this.seller,
    required this.rival,
    required this.priceOld,
   required this.restaurant,

  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    final int price = int.tryParse(json['price'].toString()) ?? 0;
    final int rivalx = int.tryParse(json['rival'].toString()) ?? 0;

    return FoodModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at'] as String),
      name: json['name'],
      image: json['image'],
      description: json['description'],
      price: ((price * (100 - rivalx)) ~/ 100).toString(),
      category: json['categorys'],
      seller: json['admin'],
      rival: json['rival'],
      priceOld: price.toString(), restaurant:json['restaurant'],
    );
  }



}
