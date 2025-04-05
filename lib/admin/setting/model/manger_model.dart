class MangerModel {
  final int id;
  String name;
  final String email;
  final String idUser;
  final DateTime createdAt;
  final String id_admin;

  MangerModel({
    required this.id,
    required this.name,
    required this.email,
    required this.idUser,
    required this.createdAt,
    required this.id_admin,
  });

  factory MangerModel.fromJson(Map<String, dynamic> json) {
    return MangerModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      idUser: json['id_user'],
      createdAt: DateTime.parse(json['created_at'] as String),
      id_admin: json['id_admin'],
    );
  }

}
