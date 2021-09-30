// To parse this JSON data, do
//
//     final alarafNotify = alarafNotifyFromJson(jsonString);

import 'dart:convert';

AlarafNotify alarafNotifyFromJson(String str) => AlarafNotify.fromJson(json.decode(str));

String alarafNotifyToJson(AlarafNotify data) => json.encode(data.toJson());

class AlarafNotify {
  AlarafNotify({
    this.id,
    this.message,
    this.userPushId,
    this.expertId,
    this.userId,
  });

  int id;
  String message;
  String userPushId;
  int expertId;
  int userId;

  factory AlarafNotify.fromJson(Map<String, dynamic> json) => AlarafNotify(
    id: json["id"],
    message: json["message"],
    userPushId: json["userPushId"],
    expertId: json["expertId"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message,
    "userPushId": userPushId,
    "expertId": expertId,
    "userId": userId,
  };

  @override
  String toString() {
    return 'AlarafNotify{id: $id, message: $message, userPushId: $userPushId, expertId: $expertId, userId: $userId}';
  }
}
