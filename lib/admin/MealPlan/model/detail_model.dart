class DetailModel {
  int id;
  String name;
  int price;
  String admin;
  DateTime createdAt;

  DetailModel({
    required this.id,
    required this.name,
    required this.price,
    required this.admin,
    required this.createdAt,
  });

  factory DetailModel.fromJson(Map<String, dynamic> json) {
    return DetailModel(
      id: json['id'],
      name: json['name'] ,
      price: json['price'] ,
      admin: json['admin'],
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
