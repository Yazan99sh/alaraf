import 'package:alaraf/data/alaraf_api_service.dart';
import 'package:alaraf/future/activity/model/alaraf_activity.dart';
import 'package:alaraf/future/login/model/alaraf_user.dart';
import 'package:alaraf/future/user/phone_call/model/call_model.dart';
import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/navigator_service.dart';
import 'package:alaraf/service/route.dart';
import 'package:alaraf/service/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
enum MessageTypeExpert {
  waiting,
  not_approve,
  rejected,
}
class FortunerMessageViewModel extends ChangeNotifier{

  var isLoading = true;
  List<AlarafActivity> allActivity = [];
  List<AlarafActivity> temp = [];
  var apiService = locator<AlarafApiService>();
  var user = locator<AlarafUser>();
  int userStatusIndex ;
  bool isFirst = true;
  bool isBusy = false;
  CallModel sendedCall;

  var messageType = MessageTypeExpert.waiting;


  FortunerMessageViewModel(){
    userStatusIndex = user.userStatus;
    init();
  }

  init() async{
    print('${user.userStatus}');
    temp = await apiService.getFortunerActivity(user.id);
      updateMessageType(MessageTypeExpert.waiting);
      isLoading = false;
      notifyListeners();
      activateListen();
  }
  activateListen(){
    FirebaseFirestore.instance.collection('call').where('expertId',isEqualTo: locator<AlarafUser>().id).orderBy('date').snapshots().listen((event) {
     if(event == null){
       isBusy = false;
     }
     else{
      if(event.docs.isNotEmpty){
        var response = CallModel.fromJson(event.docs.last.data());
        if(isFirst){
          isFirst = false;
        }
        else{
          if(!isBusy){
            response.firebaseId = event.docs.last.id;
            sendedCall = response;
            isBusy = true;
            locator<NavigationService>().navigateTo(Routes.fortuneReceiveCall,args: response);
          }
          else{
            if(!event.docs.map((e) => e.data()['id']).contains(sendedCall.id)){
              isBusy = false;
              locator<NavigationService>().goBack();
            }
          }

        }
      }

     }
    });
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

  updateStatus(a) {
    userStatusIndex = a;
    notifyListeners();
  }

  void updateRemote() async{
    apiService.updateUserStatus(user.id,userStatusIndex);
  }

  void updateMessageType(MessageTypeExpert type) async{
    isLoading = true;
    notifyListeners();
    temp = await apiService.getFortunerActivity(user.id);

    messageType = type;
    print('${temp.length} ${type}');
    if(type == MessageTypeExpert.waiting){
      allActivity = temp.where((element) => element.activated && !element.allowedForEXpert).toList();
    }
    else{
      allActivity = temp.where((element) => element.rejectedForEXpert).toList();
    }
    isLoading = false;
    notifyListeners();
  }
}