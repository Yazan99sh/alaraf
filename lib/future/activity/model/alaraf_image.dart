// To parse this JSON data, do
//
//     final alarafImage = alarafImageFromJson(jsonString);

import 'dart:convert';

AlarafImage alarafImageFromJson(String str) => AlarafImage.fromJson(json.decode(str));

String alarafImageToJson(AlarafImage data) => json.encode(data.toJson());

class AlarafImage {
  AlarafImage({
    this.id,
    this.activityId,
    this.imageUrl,
  });

  int id;
  int activityId;
  String imageUrl;

  factory AlarafImage.fromJson(Map<String, dynamic> json) => AlarafImage(
    id: json["id"],
    activityId: json["alarafActivityId"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "activityId": activityId,
    "imageUrl": imageUrl,
  };
}
