import 'dart:convert';

class RenewTokenResponse {
  RenewTokenResponse({
    required this.user,
    required this.token,
  });

  final User user;
  final String token;

  factory RenewTokenResponse.fromJson(String str) =>
      RenewTokenResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RenewTokenResponse.fromMap(Map<String, dynamic> json) =>
      RenewTokenResponse(
        user: User.fromMap(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "user": user.toMap(),
        "token": token,
      };
}

class User {
  User({
    required this.id,
  });

  final String id;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(id: json["id"]);

  Map<String, dynamic> toMap() => {
        "id": id,
      };
}
