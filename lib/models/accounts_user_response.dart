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
    required this.userDb,
    required this.amount,
  });

  final String id;
  final List<UserDb> userDb;
  final int amount;

  factory AccountAccount.fromJson(String str) =>
      AccountAccount.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AccountAccount.fromMap(Map<String, dynamic> json) => AccountAccount(
        id: json["_id"],
        userDb: List<UserDb>.from(json["userDb"].map((x) => UserDb.fromMap(x))),
        amount: json["amount"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "userDb": List<dynamic>.from(userDb.map((x) => x.toMap())),
        "amount": amount,
      };
}

class UserDb {
  UserDb({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory UserDb.fromJson(String str) => UserDb.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserDb.fromMap(Map<String, dynamic> json) => UserDb(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
      };
}
