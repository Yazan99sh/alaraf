import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/navigator_service.dart';
import 'package:alaraf/service/route.dart';
import 'package:flutter/material.dart';

class ActivityViewModel extends ChangeNotifier {
  var navigatorService = locator<NavigationService>();

  goRegister() {
    navigatorService.navigateTo(Routes.authRegister);
  }

  goProfile() {
    navigatorService.navigateTo(Routes.profile);
  }

  navigateTo(String navigate) {}
}
