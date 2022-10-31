import 'dart:convert';

class AuthResponse {
  AuthResponse({
    required this.user,
    required this.token,
  });

  final User user;
  final String token;

  factory AuthResponse.fromJson(String str) =>
      AuthResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthResponse.fromMap(Map<String, dynamic> json) => AuthResponse(
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
    required this.name,
    required this.email,
    required this.activeStream,
    required this.activeSavings,
    required this.id,
  });

  final String name;
  final String email;
  final bool activeStream;
  final bool activeSavings;
  final String id;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        activeStream: json["activeStream"],
        activeSavings: json["activeSavings"],
        id: json["_id"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "activeStream": activeStream,
        "activeSavings": activeSavings,
        "_id": id,
      };
}
