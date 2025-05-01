class AdminModel {
  final int id;
  final DateTime createdAt;
  final String uuid;
  final String superAdmin;
  final String name;
  final String restaurantAdmin;
  final String email;
  final String? phone;
  final String? address;

  AdminModel({
    required this.id,
    required this.createdAt,
    required this.uuid,
    required this.superAdmin,
    required this.name,
    required this.restaurantAdmin,
    required this.email,
    this.phone,
    this.address,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      uuid: json['uuid'],
      superAdmin: json['super_admin'],
      name: json['name'],
      restaurantAdmin: json['restaurant_admin'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
    );
  }
}
