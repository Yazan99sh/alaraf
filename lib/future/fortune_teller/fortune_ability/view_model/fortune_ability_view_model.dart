import 'package:alaraf/data/alaraf_api_service.dart';
import 'package:alaraf/future/activity/model/alaraf_activity.dart';
import 'package:alaraf/future/fortune_select/model/fortuner_ability.dart';
import 'package:alaraf/future/login/model/alaraf_user.dart';
import 'package:alaraf/service/locator.dart';
import 'package:flutter/foundation.dart';

class FortuneAbilityViewModel extends ChangeNotifier{
  var isLoading = false;
  var fortuneAbility =  <FortunerAbility>[];
  var apiService = locator<AlarafApiService>();
  int expertId;
  FortuneAbilityViewModel(int expertId){
    this.expertId = expertId;
    init();
  }
  init() async{
    isLoading = true;
    notifyListeners();
    fortuneAbility = await apiService.getFortuneAbility(expertId ?? locator<AlarafUser>().id);
    isLoading = false;
    notifyListeners();
    print(fortuneAbility);
  }

  changeAbilityStatus(bool state, int abilityTypeId,{int price}) async{
    if(state == false) {
      isLoading = true;
      notifyListeners();
      int abilityId = fortuneAbility.firstWhere((element) => element.activityTypeId == abilityTypeId).id;
      await apiService.deleteFortuneAbility(abilityId);
      fortuneAbility.remove(fortuneAbility.firstWhere((element) => element.activityTypeId == abilityTypeId));
      notifyListeners();
      isLoading = false;
      notifyListeners();
      }
    else{
      isLoading = true;
      notifyListeners();
      FortunerAbility ability = FortunerAbility();
      ability.activityTypeId = abilityTypeId;
      ability.fortunerId = expertId ?? locator<AlarafUser>().id;
      ability.price = double.parse(price.toString());
      var result = await apiService.saveFortuneAbility(ability);
      fortuneAbility.add(result);
      isLoading = false;
      notifyListeners();
    }
  }
}