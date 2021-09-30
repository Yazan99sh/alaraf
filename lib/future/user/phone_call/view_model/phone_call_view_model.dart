import 'dart:async';

import 'package:alaraf/future/login/model/alaraf_user.dart';
import 'package:alaraf/future/user/phone_call/model/call_model.dart';
import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/navigator_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PhoneCallViewModel extends ChangeNotifier{
  final int expertId;
  final firestore = FirebaseFirestore.instance;
  Timer timmerInstance;
  int _start = 0;
  String timmer = '';
  var listen;
  String connectionId;
  PhoneCallViewModel(this.expertId){
    sendPhoneCallRequest();
  }
  endToCall() async{
    await firestore.collection('call').doc(connectionId).delete();
    locator<NavigationService>().goBack();
  }
  sendPhoneCallRequest() async{
    var result = await firestore.collection('call').add(CallModel(
      channelId: DateTime.now().toIso8601String().substring(11).replaceAll(":",'').replaceAll('.',''),
      expertId: expertId,
      isActive: false,
      userId: locator<AlarafUser>().id,
      userPicture: locator<AlarafUser>().pictureUrl,
      userName: locator<AlarafUser>().name,
    ).toMap());
    connectionId = result.id;
    await Future.delayed(Duration(seconds: 1));
     listen = firestore.collection('call').doc(result.id).snapshots().listen((event) {
      if(event == null){
        listen.cancel();
      }
      else{
        var response = CallModel.fromJson(event.data());
        if(response.isActive){
          startTimmer();
        }
      }
    });

  }

  void startTimmer() async {
    await Future.delayed(Duration(seconds: 3));
    var oneSec = Duration(seconds: 1);
    timmerInstance = Timer.periodic(
        oneSec,
            (Timer timer) {
              if (_start < 0) {
                timmerInstance.cancel();
              } else {
                _start = _start + 1;
                timmer = getTimerTime(_start);
              }
              notifyListeners();
            });
  }
  
  String getTimerTime(int start) {
    int minutes = (start ~/ 60);
    String sMinute = '';
    if (minutes.toString().length == 1) {
      sMinute = '0' + minutes.toString();
    } else
      sMinute = minutes.toString();

    int seconds = (start % 60);
    String sSeconds = '';
    if (seconds.toString().length == 1) {
      sSeconds = '0' + seconds.toString();
    } else
      sSeconds = seconds.toString();

    return sMinute + ':' + sSeconds;
  }
}