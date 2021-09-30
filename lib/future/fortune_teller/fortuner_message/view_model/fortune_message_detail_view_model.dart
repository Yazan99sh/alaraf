import 'dart:io';

import 'package:alaraf/data/alaraf_api_service.dart';
import 'package:alaraf/future/activity/model/alaraf_activity.dart';
import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/navigator_service.dart';
import 'package:alaraf/service/strings.dart';
import 'package:flutter/material.dart';

class FortuneMessageDetailViewModel extends ChangeNotifier{
  var apiService = locator<AlarafApiService>();
  final AlarafActivity activity;
  TextEditingController txtResponse ;
  bool isLoading = false;
  bool isDone = true;
  var navigationService = locator<NavigationService>();

  File recordSound;

  FortuneMessageDetailViewModel(this.activity){
    txtResponse = TextEditingController(text: activity.answerOfFortuner == 'null' || activity.answerOfFortuner == null ? "" : activity.answerOfFortuner);
  }

  update() async{
    print("Update Start");
    activity.answerOfFortuner = txtResponse.text;
    isDone = false;
    isLoading = true;
    notifyListeners();
    await apiService.updateActivity(recordSound.readAsBytesSync(),activity);
    isDone = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    isLoading = false;
    notifyListeners();
    navigationService.goBack();

  }

  String getSocialSituation(Map translate) {
    var temp =  [
      translate[StringKeys.str_single],
      translate[StringKeys.str_divorced],
      translate[StringKeys.str_widower],
      translate[StringKeys.str_separated],
      translate[StringKeys.str_linked],
      translate[StringKeys.str_married],
    ];
    return temp[activity.socialSituation];

  }

}