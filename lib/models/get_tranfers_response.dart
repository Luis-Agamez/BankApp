// To parse this JSON data, do
//
//     final getTransfersResponse = getTransfersResponseFromMap(jsonString);

import 'dart:convert';

class GetTransfersResponse {
  GetTransfersResponse({
    required this.results,
  });

  final List<Result> results;

  factory GetTransfersResponse.fromJson(String str) =>
      GetTransfersResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetTransfersResponse.fromMap(Map<String, dynamic> json) =>
      GetTransfersResponse(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
      };
}

class Result {
  Result({
    required this.id,
    required this.accountorigin,
    required this.accountdestiny,
    required this.send,
    required this.origin,
    required this.us,
    required this.amount,
  });

  final String id;
  final String accountorigin;
  final List<String> accountdestiny;
  final List<String> send;
  final String origin;
  final bool us;
  final int amount;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["_id"],
        accountorigin: json["accountorigin"],
        accountdestiny: List<String>.from(json["accountdestiny"].map((x) => x)),
        send: List<String>.from(json["send"].map((x) => x)),
        origin: json["origin"],
        us: json["us"],
        amount: json["amount"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "accountorigin": accountorigin,
        "accountdestiny": List<dynamic>.from(accountdestiny.map((x) => x)),
        "send": List<dynamic>.from(send.map((x) => x)),
        "origin": origin,
        "us": us,
        "amount": amount,
      };
}
