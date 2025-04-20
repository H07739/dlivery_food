class FoodAdminModel {
  int id;
  String name;
  String price;
  String image;
  String category;
  String description;
  DateTime createdAt;
  String admin;
  int idCategory;
  int? rival;

  FoodAdminModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.admin,
      required this.category,
      required this.description,
      required this.image,
      required this.createdAt,
      required this.idCategory,
      required this.rival});

  factory FoodAdminModel.fromJson({required Map<String, dynamic> json}) {
    return FoodAdminModel(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        admin: json['admin'],
        category: json['categorys'],
        description: json['description'],
        image: json['image'],
        createdAt: DateTime.parse(json['created_at'] as String),
        idCategory: json['id_category'], rival: json['rival']);
  }

  Map<String, dynamic> toJson() {
    return  {
      'name': name,
      'price': price,
      'categorys': category,
      'description': description,
      'image': image,
      'id_category': idCategory,
      'rival':rival
    };
  }
}
