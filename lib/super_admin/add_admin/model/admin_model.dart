class AdminModel {
  int id;
  DateTime createdAt;
  String idAdmin;
  String name;
  String restaurantAdmin;
  String email;
  String phone;
  String address;

  AdminModel({
    required this.name,
    required this.email,
    required this.id,
    required this.createdAt,
    required this.idAdmin,
    required this.restaurantAdmin,
    required this.phone,
    required this.address

  });

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      idAdmin: json['uuid'],
      name: json['name'],
      restaurantAdmin: json['restaurant_admin'],
      email: json['email'], phone: json['phone'], address: json['address'],
    );
  }
  Map<String,dynamic> toMap(){
    return {
      'uuid':idAdmin,
      'name':name,
      'email':email,
      'restaurant_admin':restaurantAdmin,
      'phone':phone,
      'address':address

    };
  }

} 