class FoodDetailModelX{
  int id;
  String name;
  int price;
  DateTime createdAt;
  bool check = false;

  FoodDetailModelX({required this.id, required this.name, required this.price, required this.createdAt});
  factory FoodDetailModelX.fromMap(Map<String,dynamic> json){

    return FoodDetailModelX(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
    };
  }
}
