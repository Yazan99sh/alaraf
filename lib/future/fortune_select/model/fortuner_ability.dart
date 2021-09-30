
import 'dart:convert';

import 'package:alaraf/future/login/model/alaraf_user.dart';

List<FortunerAbility> fortunerAbilityFromJson(String str) => List<FortunerAbility>.from(json.decode(str).map((x) => FortunerAbility.fromJson(x)));

String fortunerAbilityToJson(List<FortunerAbility> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FortunerAbility {
  FortunerAbility({
    this.id,
    this.fortunerId,
    this.activityTypeId,
    this.price,
    this.alarafUser,
  });

  int id;
  int fortunerId;
  int activityTypeId;
  double price;
  AlarafUser alarafUser;

  factory FortunerAbility.fromJson(Map<String, dynamic> json) => FortunerAbility(
    id: json["id"],
    fortunerId: json["fortunerId"],
    activityTypeId: json["activityTypeId"],
    price: json["price"],
    alarafUser: json['alarafUser'] == null ? null : AlarafUser.fromJson(json["alarafUser"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fortunerId": fortunerId,
    "activityTypeId": activityTypeId,
    "price": price,
    "alarafUser": alarafUser!= null ? alarafUser.toJson() : null,
  };

  @override
  String toString() {
    return 'FortunerAbility{id: $id, fortunerId: $fortunerId, activityTypeId: $activityTypeId, price: $price, alarafUser: $alarafUser}';
  }
}