class MangerModel {
  final int id;
  final String name;
  final String email;
  final String idUser;
  final DateTime createdAt;

  MangerModel({
    required this.id,
    required this.name,
    required this.email,
    required this.idUser,
    required this.createdAt,
  });

  factory MangerModel.fromJson(Map<String, dynamic> json) {
    return MangerModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      idUser: json['id_user'],
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

}
