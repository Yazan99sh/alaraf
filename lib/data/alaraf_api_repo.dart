import 'dart:typed_data';

import 'package:alaraf/future/activity/model/alaraf_activity.dart';
import 'package:alaraf/future/activity/model/alaraf_image.dart';
import 'package:alaraf/future/fortune_select/model/fortuner_ability.dart';
import 'package:alaraf/future/fortune_teller/fortune_experts/model/alaraf_notify.dart';
import 'package:alaraf/future/login/model/alaraf_user.dart';
import 'package:dio/dio.dart';

abstract class AlarafApiRepo{
  Future<dynamic> login(String username,String password);
  Future<AlarafImage> saveImage(Uint8List image,int activityId,String name);
  Future<AlarafActivity> saveActivity(Uint8List voiceRecord, AlarafActivity alarafActivity);
  Future<List<AlarafActivity>> getFortunerActivity(int id);
  Future<List<AlarafActivity>> getUserActivity(int id);
  Future<AlarafUser> registerUser(AlarafUser user);
  Future<List<FortunerAbility>> getFortuneTeller(int id);
  Future<void> updateActivity(Uint8List voiceRecord, AlarafActivity alarafActivity);
  Future<void> updateUserStatus(int userId,int status);
  Future<void> updateUserType(int userType,int id);
  Future<List<AlarafUser>> getAllAralafUser();
  Future<List<AlarafUser>> getAllAlarafExpert();
  Future<void> updateActivityState(int id,bool state);
  Future<List<FortunerAbility>> getFortuneAbility(int id);
  Future<FortunerAbility> saveFortuneAbility(FortunerAbility ability);
  Future<void> deleteFortuneAbility(int id);
  Future<void> updateUserName(int id,String name);
  Future<void> updateUserPassword(int id,String password);
  Future<void> updateUserMobile(int id,String mobile);
  Future<void> updateUserAbout(int id,String about);
  Future<AlarafNotify> saveNotify(AlarafNotify notify);
  Future<List<AlarafNotify>> getNotifyByUserId(int userId);
  Future<void> deleteNotifyById(int id);
  Future<void> updateUserVoiceRecord(Uint8List voiceRecord,int userId);
  Future<void> updateRejectState(int id,bool state);
  Future<void> updateExpertActiveState(int id,bool state);
  Future<void> updateExpertMessageRejectState(int id,bool state);

}