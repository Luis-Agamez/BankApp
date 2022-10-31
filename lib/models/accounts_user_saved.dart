// To parse this JSON data, do
//
//     final accountsUserResponse = accountsUserResponseFromMap(jsonString);

import 'dart:convert';

class AccountsUserResponse {
  AccountsUserResponse({
    required this.accounts,
  });

  final List<AccountElement> accounts;

  factory AccountsUserResponse.fromJson(String str) =>
      AccountsUserResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AccountsUserResponse.fromMap(Map<String, dynamic> json) =>
      AccountsUserResponse(
        accounts: List<AccountElement>.from(
            json["accounts"].map((x) => AccountElement.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "accounts": List<dynamic>.from(accounts.map((x) => x.toMap())),
      };
}

class AccountElement {
  AccountElement({
    required this.account,
  });

  final AccountAccount account;

  factory AccountElement.fromJson(String str) =>
      AccountElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AccountElement.fromMap(Map<String, dynamic> json) => AccountElement(
        account: AccountAccount.fromMap(json["account"]),
      );

  Map<String, dynamic> toMap() => {
        "account": account.toMap(),
      };
}

class AccountAccount {
  AccountAccount({
    required this.id,
    required this.user,
    required this.amount,
  });

  final String id;
  final List<User> user;
  final int amount;

  factory AccountAccount.fromJson(String str) =>
      AccountAccount.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AccountAccount.fromMap(Map<String, dynamic> json) => AccountAccount(
        id: json["_id"],
        user: List<User>.from(json["user"].map((x) => User.fromMap(x))),
        amount: json["amount"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "user": List<dynamic>.from(user.map((x) => x.toMap())),
        "amount": amount,
      };
}

class User {
  User({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
      };
}
