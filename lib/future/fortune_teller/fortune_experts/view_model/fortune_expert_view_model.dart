import 'package:alaraf/data/alaraf_api_service.dart';
import 'package:alaraf/future/fortune_teller/fortune_experts/model/alaraf_notify.dart';
import 'package:alaraf/future/login/model/alaraf_user.dart';
import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/strings.dart';
import 'package:alaraf/service/translate.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class FortuneExpertViewModel extends ChangeNotifier {
  var isLoading;
  var allExpert = <AlarafUser>[];
  double page = 0.0;
  AlarafUser selectedExpert;
  var service = locator<AlarafApiService>();
  var key = GlobalKey<ScaffoldState>();
  var notifyList = <AlarafNotify>[];

  FortuneExpertViewModel() {
    init();
  }

  init() async {
    isLoading = true;
    allExpert = await service.getAllAlarafExpert();
    notifyList = await  service.getNotifyByUserId(locator<AlarafUser>().id);
    selectedExpert = allExpert.first;
    isLoading = false;
    notifyListeners();
  }

  updatePage(double pageValue) {
    page = pageValue;
    notifyListeners();
  }

  void updateExpert(int pos) {
    selectedExpert = allExpert[pos];
    print(selectedExpert);
    notifyListeners();
  }

  void saveNotify() async {

    isLoading = true;
    notifyListeners();
    var oneSignal = await OneSignal.shared.getPermissionSubscriptionState();
    var oneSignalId = oneSignal.subscriptionStatus.userId;
    var notify = AlarafNotify(
        expertId: selectedExpert.id,
        userId: locator<AlarafUser>().id,
        userPushId: oneSignalId,
        message:
            "${selectedExpert.name} - ${locator<TranslateService>().selectedLanguageValue[StringKeys.str_online]}");
    var result = await service.saveNotify(notify);
    notifyList.add(result);
    isLoading = false;
    notifyListeners();
  }

  void removeNotify() async{
    isLoading = true;
    notifyListeners();
    var notify = notifyList.firstWhere((element) => element.expertId == selectedExpert.id);
    await service.deleteNotifyById(notify.id);
    notifyList.remove(notify);
    isLoading = false;
    notifyListeners();
  }
}
