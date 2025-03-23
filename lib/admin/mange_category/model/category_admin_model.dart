class CategoryAdminModel{
  int id;
  String name;
  String admin;
  String image;
  DateTime createdAt;
  CategoryAdminModel({required this.id, required this.name, required this.admin, required this.image, required this.createdAt});
  factory CategoryAdminModel.fromJson(Map<String,dynamic> json){
    return CategoryAdminModel(
      id: json['id'],
      name: json['name'],
      admin: json['admin'],
      image: json['image'],
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
  Map<String, dynamic> toJson(){
    return {
      'name': name,
      'image': image,
    };
  }
}