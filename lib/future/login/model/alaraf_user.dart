import 'dart:convert';

AlarafUser alarafUserFromJson(String str) => AlarafUser.fromJson(json.decode(str));

String alarafUserToJson(AlarafUser data) => json.encode(data.toJson());

class AlarafUser {
  AlarafUser({
    this.id,
    this.userName,
    this.password,
    this.name,
    this.surname,
    this.pictureUrl,
    this.balance,
    this.userType,
    this.phoneNumber,
    this.countryCode,
    this.userStatus,
    this.abilityIndex,
    this.aboutExpert,
    this.userVoiceInfoUrl
  });

  int id;
  String userName;
  String password;
  String name;
  String surname;
  String pictureUrl;
  double balance;
  int userType;
  String phoneNumber;
  int countryCode;
  int userStatus;
  List<int> abilityIndex;
  String aboutExpert;
  String userVoiceInfoUrl;


  replaceAll(AlarafUser alarafUser){
    this.id = alarafUser.id;
    this.userName = alarafUser.userName;
    this.password = alarafUser.password;
    this.name = alarafUser.name;
    this.surname = alarafUser.surname;
    this.pictureUrl =  alarafUser.pictureUrl;
    this.balance = alarafUser.balance;
    this.userType  = alarafUser.userType;
    this.countryCode = alarafUser.countryCode;
    this.phoneNumber = alarafUser.phoneNumber;
    this.userStatus = alarafUser.userStatus;
    this.aboutExpert = alarafUser.aboutExpert;
    this.abilityIndex = alarafUser.abilityIndex;
    this.userVoiceInfoUrl = alarafUser.userVoiceInfoUrl;
  }

  factory AlarafUser.fromJson(Map<String, dynamic> json) => AlarafUser(
    id: json["id"] == null ? null : json["id"],
    userName: json["userName"] == null ? null : json["userName"],
    password: json["password"] == null ? null : json["password"],
    name: json["name"] == null ? null : json["name"],
    surname: json["surname"] == null ? null : json["surname"],
    pictureUrl: json["pictureUrl"] == null ? null : json["pictureUrl"],
    balance: json["balance"] == null ? null : json["balance"].toDouble(),
    userType: json["userType"] == null ? null : json["userType"],
    phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
    countryCode: json["countryCode"] == null ? null : json["countryCode"],
    userStatus: json["userStatus"] == null ? null : json["userStatus"],
    abilityIndex: json["abilityIndex"] == null ? [] : List<int>.from(json["abilityIndex"].map((x) => x)),
    aboutExpert: json["aboutExpert"],
      userVoiceInfoUrl: json["userVoiceInfoUrl"]
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "userName": userName == null ? null : userName,
    "password": password == null ? null : password,
    "name": name == null ? null : name,
    "surname": surname == null ? null : surname,
    "pictureUrl": pictureUrl == null ? null : pictureUrl,
    "balance": balance == null ? null : balance,
    "userType": userType == null ? null : userType,
    "countryCode": countryCode == null ? null : countryCode,
    "phoneNumber": phoneNumber == null ? null : phoneNumber,
    "userStatus": userStatus == null ? null : userStatus,
    "aboutExpert": aboutExpert == null ? null : aboutExpert,
    "userVoiceInfoUrl": userVoiceInfoUrl == null ? null : userVoiceInfoUrl,

  };

  @override
  String toString() {
    return 'AlarafUser{${abilityIndex} - id: $id, userName: $userName, password: $password, name: $name, surname: $surname, pictureUrl: $pictureUrl, balance: $balance, userType: $userType}';
  }
}
