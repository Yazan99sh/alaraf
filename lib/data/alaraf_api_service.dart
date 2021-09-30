import 'dart:typed_data';

import 'package:alaraf/data/alaraf_api_repo.dart';
import 'package:alaraf/future/activity/model/alaraf_activity.dart';
import 'package:alaraf/future/activity/model/alaraf_image.dart';
import 'package:alaraf/future/fortune_select/model/fortuner_ability.dart';
import 'package:alaraf/future/fortune_teller/fortune_experts/model/alaraf_notify.dart';
import 'package:alaraf/future/login/model/alaraf_user.dart';
import 'package:dio/dio.dart';

class AlarafApiService extends AlarafApiRepo{


  var dio = Dio();
  //var serverUrl = "https://alaraf-api.herokuapp.com";
  var serverUrl = "http://alaraf.me:8080";

  @override
  Future<dynamic> login(String username, String password) async {


    try{
      print('$serverUrl/user?username=$username&password=$password');
      var response =  await dio.get("$serverUrl/user?username=$username&password=$password");
      return AlarafUser.fromJson(response.data);
    }
    on DioError catch(e){
      print(e);
      return e;
    }
  }

  @override
  Future<AlarafImage> saveImage(Uint8List image, int activityId,String name,{bool isProfilePicture=false,String userId}) async{

    FormData data = FormData.fromMap({
      "json": '{"alarafActivityId":$activityId,"profilePicture":$isProfilePicture}',
      "file": MultipartFile.fromBytes(image, filename: "${userId ?? name}"),
    });
    var response =
        await dio.post("$serverUrl/image", data: data);
    return AlarafImage.fromJson(response.data);

  }

  @override
  Future<AlarafActivity> saveActivity(Uint8List voiceRecord, AlarafActivity alarafActivity) async{
    FormData data = FormData.fromMap({
      "json": alarafActivity.toJsonFormat(alarafActivity),
        "file": MultipartFile.fromBytes(voiceRecord, filename: "record.mp3"),
    });
    var response =
        await dio.post("$serverUrl/activity", data: data);
    return null;
  }

  @override
  Future<AlarafUser> registerUser(AlarafUser user) async {
    var response = await dio.post("$serverUrl/user",data: user.toJson());
    return AlarafUser.fromJson(response.data);
  }

  @override
  Future<List<FortunerAbility>> getFortuneTeller(int id) async{
    print('$serverUrl/ability?id=$id');
    var response = await dio.get("$serverUrl/ability?id=$id");
    return (response.data as List).map((e) => FortunerAbility.fromJson(e)).toList();
  }

  @override
  Future<List<AlarafActivity>> getFortunerActivity(int id) async {
    print('$serverUrl/activity/fortuner?id=$id');
    var response = await dio.get("$serverUrl/activity/fortuner?id=$id");
    return (response.data as List).map((e) => AlarafActivity.fromJson(e)).toList();
  }

  @override
  Future<void> updateActivity(Uint8List voiceRecord, AlarafActivity alarafActivity) async{

    FormData data = FormData.fromMap({
      "json": alarafActivity.toJsonFormat(alarafActivity),
      "file": MultipartFile.fromBytes(voiceRecord, filename: "record.mp3"),
    });
    var response =
    await dio.put("$serverUrl/activity", data: data);

  }

  @override
  Future<List<AlarafActivity>> getUserActivity(int id) async {
    print('$serverUrl/activity/user?id=$id');
    var response = await dio.get("$serverUrl/activity/user?id=$id");
    return (response.data as List).map((e) => AlarafActivity.fromJson(e)).toList();
  }

  @override
  Future<void> updateUserStatus(int userId, int status) async{
    var response = await dio.get("$serverUrl/user/update-user-status?id=$userId&status=$status");
  }

  @override
  Future<List<AlarafUser>> getAllAralafUser() async {
    var response = await dio.get("$serverUrl/user/all");
    return (response.data as List).map((e) => AlarafUser.fromJson(e)).toList();
  }

  @override
  Future<void> updateUserType(int userType, int id) async {
    var response = await dio.get("$serverUrl/user/update-user-type?userType=$userType&id=$id");
  }

  @override
  Future<void> updateActivityState(int id, bool state) async{
    var response = await dio.get("$serverUrl/activity/active?status=$state&id=$id");
  }

  @override
  Future<List<FortunerAbility>> getFortuneAbility(int id) async{
    var response = await dio.get("$serverUrl/ability/fortuner?id=$id");
    return (response.data as List).map((e) => FortunerAbility.fromJson(e)).toList();
  }

  @override
  Future<FortunerAbility> saveFortuneAbility(FortunerAbility ability) async{

    var response = await dio.post('$serverUrl/ability',data: ability.toJson());
    return FortunerAbility.fromJson(response.data);
  }

  @override
  Future<void> deleteFortuneAbility(int id) async {
    var response = await dio.delete('$serverUrl/ability?id=$id');
  }

  @override
  Future<void> updateUserMobile(int id, String mobile) async {
    var response = await dio.get("$serverUrl/user/update-user-mobile?id=$id&mobile=$mobile");
  }

  @override
  Future<void> updateUserName(int id, String name) async{
    var response = await dio.get("$serverUrl/user/update-user-name?id=$id&name=$name");
  }

  @override
  Future<void> updateUserPassword(int id, String password) async{
    var response = await dio.get("$serverUrl/user/update-user-password?id=$id&password=$password");
  }

  @override
  Future<List<AlarafUser>> getAllAlarafExpert() async{
    var response = await dio.get("$serverUrl/user/get-fortuner");
    return (response.data as List).map((e) => AlarafUser.fromJson(e)).toList();
  }

  @override
  Future<void> updateUserAbout(int id, String about) async {
    var response = await dio.get("$serverUrl/user/update-user-about?id=$id&about=$about");

  }

  @override
  Future<void> deleteNotifyById(int id) async {
    var response = await dio.delete("$serverUrl/notify?id=$id");
  }

  @override
  Future<List<AlarafNotify>> getNotifyByUserId(int userId) async{
    var response = await dio.get("$serverUrl/notify/user?id=$userId");
    return (response.data as List).map((e) => AlarafNotify.fromJson(e)).toList();
  }

  @override
  Future<AlarafNotify> saveNotify(AlarafNotify notify) async{
    var response = await dio.post("$serverUrl/notify",data: notify.toJson());
    return AlarafNotify.fromJson(response.data);
  }

  @override
  Future<void> updateUserVoiceRecord(Uint8List voiceRecord, int userId) async {
    FormData data = FormData.fromMap({
      "file": MultipartFile.fromBytes(voiceRecord, filename: "$userId"),
    });
    var response = await dio.post("$serverUrl/user/update-user-voice", data: data);
  }

  @override
  Future<void> updateExpertActiveState(int id, bool state) async {
    print('$serverUrl/activity/active-expert-message?status=$state&id=$id');
    var response = await dio.get("$serverUrl/activity/active-expert-message?status=$state&id=$id");

  }

  @override
  Future<void> updateExpertMessageRejectState(int id, bool state) async {
    var response = await dio.get("$serverUrl/activity/reject-expert-message?status=$state&id=$id");

  }

  @override
  Future<void> updateRejectState(int id, bool state) async{
    var response = await dio.get("$serverUrl/activity/reject-user-message?status=$state&id=$id");
  }


}