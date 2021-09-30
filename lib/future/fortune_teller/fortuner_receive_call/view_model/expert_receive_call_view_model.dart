import 'dart:async';

import 'package:alaraf/future/user/phone_call/model/call_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ExpertReceiveCallViewModel extends ChangeNotifier{
  CallModel callModel;
  Timer timmerInstance;
  int _start = 0;
  String timmer = '';


  ExpertReceiveCallViewModel(CallModel model){
    callModel = model;

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

  void acceptCall() async{
    callModel.isActive = true;
    await FirebaseFirestore.instance.doc('call/${callModel.firebaseId}').update(
        {'isActive':true});
    startTimmer();
  }
  endCall() async{

  }
}