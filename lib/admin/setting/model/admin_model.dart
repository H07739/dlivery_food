import 'package:latlong2/latlong.dart';

class AdminModel {
  int id;
  DateTime createdAt;
  String uuid;
  String superAdmin;
  String name;
  String restaurantAdmin;
  String email;
  String? phone;
  String? address;
  String? image;
  double? latitude;
  double? longitude;

  AdminModel(
      {required this.id,
      required this.createdAt,
      required this.uuid,
      required this.superAdmin,
      required this.name,
      required this.restaurantAdmin,
      required this.email,
      this.phone,
      this.address,
      this.image,
      this.latitude,
      this.longitude});

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
        image: json['image'],
        latitude: json['latitude'] != null?double.parse(json['latitude']):null,
        longitude: json['longitude'] != null?double.parse(json['longitude']):null
    );
  }
}
