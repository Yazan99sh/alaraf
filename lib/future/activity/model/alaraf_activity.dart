// To parse this JSON data, do
//
//     final alarafActivity = alarafActivityFromJson(jsonString);

import 'dart:convert';

import 'package:alaraf/future/login/model/alaraf_user.dart';

AlarafActivity alarafActivityFromJson(String str) =>
    AlarafActivity.fromJson(json.decode(str));

String alarafActivityToJson(AlarafActivity data) => json.encode(data.toJson());

class AlarafActivity {
  AlarafActivity(
      {this.activated,
      this.rejected,
      this.rejectedForEXpert,
      this.allowedForEXpert,
      this.id,
      this.userId,
      this.fortunerId,
      this.forename,
      this.dateOfBirth,
      this.sex,
      this.socialSituation,
      this.writenLetter,
      this.voiceUrl,
      this.isAnswered,
      this.fortuneTypeId,
      this.answerOfFortuner,
      this.alarafUser,
      this.allImage,
      this.motherName,
      this.birthPlace,
      this.partnerBirthDate,
      this.partnerMotherName,
      this.partnerName});

  int id;
  int userId;
  int fortunerId;
  int fortuneTypeId;
  String forename;
  DateTime dateOfBirth;
  int sex;
  int socialSituation;
  String writenLetter;
  String voiceUrl;
  bool isAnswered;
  String answerOfFortuner;
  String motherName;
  AlarafUser alarafUser;
  List<int> allImage;
  String birthPlace;
  bool activated;
  String partnerName;
  String partnerMotherName;
  DateTime partnerBirthDate;
  bool rejected;
  bool allowedForEXpert;
  bool rejectedForEXpert;

  factory AlarafActivity.fromJson(Map<String, dynamic> json) => AlarafActivity(
      id: json["id"],
      rejected: json['rejected'],
      allowedForEXpert: json['allowedForEXpert'],
      rejectedForEXpert: json['rejectedForEXpert'],
      userId: json["userId"],
      fortunerId: json["fortunerId"],
      forename: json["forename"],
      dateOfBirth: DateTime.parse(json["dateOfBirth"]),
      sex: json["sex"],
      socialSituation: json["socialSituation"],
      writenLetter: json["writenLetter"],
      voiceUrl: json["voiceUrl"],
      isAnswered: json["answered"],
      fortuneTypeId: json["fortuneTypeId"],
      answerOfFortuner: json["answerOfFortuner"],
      alarafUser: AlarafUser.fromJson(json['userInfo']),
      allImage: json["allImage"] == null
          ? null
          : List<int>.from(json["allImage"].map((x) => x)),
      motherName: json["motherName"],
      birthPlace: json['birthPlace'],
      activated: json['activated'],
      partnerBirthDate: json['partnerBirthDate'] == null
          ? null
          : DateTime.parse(json["partnerBirthDate"]),
      partnerName: json['partnerName'] == null ? null : json['partnerName'],
      partnerMotherName:
          json['partnerMotherName'] == null ? null : json['partnerMotherName']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "fortunerId": fortunerId,
        "forename": forename,
        "dateOfBirth": dateOfBirth.toIso8601String(),
        "sex": sex,
        "socialSituation": socialSituation,
        "writenLetter": writenLetter,
        "voiceUrl": voiceUrl,
        "isAnswered": isAnswered,
        "fortuneTypeId": fortuneTypeId,
        "answerOfFortuner": answerOfFortuner,
        "partnerMotherName": partnerMotherName,
        "partnerBirthDate": partnerBirthDate.toIso8601String(),
        "partnerName": partnerName,
        "rejected": rejected,
        "rejectedForEXpert": rejectedForEXpert,
        "allowedForEXpert": allowedForEXpert
      };

  toJsonFormat(AlarafActivity a) {
    return '{"id":${a.id},"rejected":${a.rejected},"rejectedForEXpert":${a.rejectedForEXpert},"allowedForEXpert":${a.allowedForEXpert},"partnerMotherName":"${a.partnerMotherName}","partnerName":"${a.partnerName}","partnerBirthDate":"${a.partnerBirthDate == null ? null : a.partnerBirthDate.toIso8601String() }","birthPlace":"${a.birthPlace}","motherName":"${a.motherName}","answerOfFortuner":"${a.answerOfFortuner}","fortuneTypeId":${a.fortuneTypeId},"answered":${a.isAnswered},"fortunerId":${a.fortunerId},"userId":${a.userId},"forename":"${a.forename}","dateOfBirth":"${a.dateOfBirth.toIso8601String()}","sex":${a.sex},"socialSituation":${a.socialSituation},"writenLetter":"${a.writenLetter}","voiceUrl":"${a.voiceUrl}"}';
  }

  @override
  String toString() {
    return 'AlarafActivity{aciteved: $activated forename: $forename, socialSituation: $socialSituation, isAnswered: $isAnswered}';
  }
}
