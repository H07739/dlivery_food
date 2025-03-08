class CategoryModel {
  final int id;
  final String name;
  final String image;

  CategoryModel({required this.id, required this.name,required this.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      image: json['image'] ?? "https://5.imimg.com/data5/SELLER/Default/2021/11/JX/RO/DO/30368866/indian-food-catering-service.jpg",
    );
  }
}
