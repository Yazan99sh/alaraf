import 'package:alaraf/data/alaraf_api_service.dart';
import 'package:alaraf/future/fortune_select/model/fortuner_ability.dart';
import 'package:alaraf/future/login/model/alaraf_user.dart';
import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/navigator_service.dart';
import 'package:alaraf/service/route.dart';
import 'package:flutter/material.dart';

class FortunerSelectViewModel extends ChangeNotifier {
  var isLoading = true;
  var apiService = locator<AlarafApiService>();
  var navigatorService = locator<NavigationService>();
  int activityTypeId;
  List<FortunerAbility> allFortuner = [];
  List<AlarafUser> allExpert = [];
  FortunerSelectViewModel(int id){
    this.activityTypeId = id;
    init();
  }
  init() async{
    if(activityTypeId == -1)
      allExpert = await apiService.getAllAlarafExpert();
      allFortuner = await apiService.getFortuneTeller(activityTypeId);

    isLoading = false;
    notifyListeners();
  }

  navigateTo(String navigate) {}
}
