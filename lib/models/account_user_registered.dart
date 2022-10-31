import 'dart:convert';

class AccountsUserResponseRegistered {
  AccountsUserResponseRegistered({
    required this.accountSaved,
  });

  final List<AccountSaved> accountSaved;

  factory AccountsUserResponseRegistered.fromJson(String str) =>
      AccountsUserResponseRegistered.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AccountsUserResponseRegistered.fromMap(Map<String, dynamic> json) =>
      AccountsUserResponseRegistered(
        accountSaved: List<AccountSaved>.from(
            json["accountSaved"].map((x) => AccountSaved.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "accountSaved": List<dynamic>.from(accountSaved.map((x) => x.toMap())),
      };
}

class AccountSaved {
  AccountSaved({
    required this.id,
    required this.user,
    required this.account,
  });

  final String id;
  final List<String> user;
  final List<String> account;

  factory AccountSaved.fromJson(String str) =>
      AccountSaved.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AccountSaved.fromMap(Map<String, dynamic> json) => AccountSaved(
        id: json["_id"],
        user: List<String>.from(json["user"].map((x) => x)),
        account: List<String>.from(json["account"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "user": List<dynamic>.from(user.map((x) => x)),
        "account": List<dynamic>.from(account.map((x) => x)),
      };
}
