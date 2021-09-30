import 'package:alaraf/data/alaraf_api_service.dart';
import 'package:alaraf/future/activity/model/alaraf_activity.dart';
import 'package:alaraf/future/login/model/alaraf_user.dart';
import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/navigator_service.dart';
import 'package:alaraf/service/route.dart';
import 'package:alaraf/service/strings.dart';
import 'package:flutter/material.dart';
enum MessageType{
  answered,
  not_answered,
  rejected
}
class UserMessageViewModel extends ChangeNotifier{
  var isLoading = true;
  List<AlarafActivity> allActivity = [];
  List<AlarafActivity> temp = [];
  var apiService = locator<AlarafApiService>();
  var user = locator<AlarafUser>();
  var messageType = MessageType.answered;
  UserMessageViewModel(){
    init();
  }

  init() async{
    temp = await apiService.getUserActivity(user.id);
    updateMessageType(messageType);

    isLoading = false;
    notifyListeners();
  }

  getType(int id) {
    if(id == 1)
      return StringKeys.str_cup;
    else
      return StringKeys.str_constellations;
  }
  goDetail(AlarafActivity activity){
    locator<NavigationService>().navigateTo(Routes.fortuneMessageDetail,args: activity);
  }

  void updateMessageType(MessageType type) {
    messageType = type;
    if(type == MessageType.answered){
      allActivity = temp.where((element) => element.isAnswered && element.allowedForEXpert).toList();
    }
    else if(type == MessageType.rejected){
      allActivity = temp.where((element) => element.rejected).toList();

    }
    else{
      allActivity = temp.where((element) => !element.isAnswered  || !element.allowedForEXpert).toList();
    }

    notifyListeners();
  }
}