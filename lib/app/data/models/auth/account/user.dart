class User {
  final String username;
  final String email;
  final String lang;
  final String idRef;
  final int id;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.lang,
    required this.idRef,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        lang: json["lang"],
        idRef: json["id_ref"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "lang": lang,
        "id_ref": idRef,
      };
}
