import 'package:alaraf/data/alaraf_api_service.dart';
import 'package:alaraf/future/login/model/alaraf_user.dart';
import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/navigator_service.dart';
import 'package:alaraf/service/route.dart';
import 'package:alaraf/service/strings.dart';
import 'package:alaraf/service/translate.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ChangeNotifier {
  var navigatorService = locator<NavigationService>();
  var apiService = locator<AlarafApiService>();
  var key = GlobalKey<ScaffoldState>();
  var username = TextEditingController();
  var password = TextEditingController();
  var isLoading = false;
  var isRememberChecked = false;

  bool isRemember = false;

  LoginViewModel() {
    init();
  }

  init() {
    checkShared();
    isRememberChecked = true;
  }

  checkShared() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getInt('id') != null) {
      var id = prefs.getInt('id');
      var name = prefs.getString('name');
      var surname = prefs.getString('surname');
      var pictureUrl = prefs.getString('pictureUrl');
      var balance = prefs.getDouble('balance');
      var userName = prefs.getString('userName');
      var userType = prefs.getInt('userType');
      var countryCode = prefs.getInt('countryCode');
      var phoneNumber = prefs.getString('phoneNumber');
      var userStatus = prefs.getInt('userStatus');
     AlarafUser sharedUser = AlarafUser(
        userType: userType,
        countryCode: countryCode,
        phoneNumber: phoneNumber,
        id: id,
        name: name,
        surname: surname,
        pictureUrl: pictureUrl,
        balance: balance,
        userName: userName,
        userStatus: userStatus);
      locator<AlarafUser>().replaceAll(sharedUser);
      if (sharedUser.userType == 2) {
        navigatorService.navigateTo(Routes.fortuneMessage);
      }
      else
        goProfile();

    }

  }

  goRegister() {
    navigatorService.navigateTo(Routes.authRegister);
  }

  goProfile() {
    navigatorService.navigateTo(Routes.allActivity);
  }

  login() async {
    isLoading = true;
    notifyListeners();
    var data = await apiService.login(username.text, password.text);
    isLoading = false;
    var translate =
        Provider
            .of<TranslateService>(key.currentContext, listen: false)
            .selectedLanguageValue;
    notifyListeners();
    if (data is DioError) {
      print(data);
      key.currentState.showSnackBar(SnackBar(
        content: Text("${translate[StringKeys.str_wrong_pass_or_username]} \n ${data.response}  \n ${data.message} "),));
    }
    else {
      username.clear();
      password.clear();
      FocusScope.of(key.currentContext).unfocus();
      locator<AlarafUser>().replaceAll(data);
      if (isRemember)
        writeOnShared(data);

      if (data.userType == 2) {
        navigatorService.navigateTo(Routes.fortuneMessage);
      }
      else
        goProfile();
    }
  }

  void writeOnShared(AlarafUser data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', data.id);
    prefs.setString('userName', data.userName);
    prefs.setString('name', data.name);
    prefs.setString('surname', data.surname);
    prefs.setString('pictureUrl', data.pictureUrl);
    prefs.setDouble('balance', data.balance);
    prefs.setInt('userType', data.userType);
    prefs.setInt('countryCode', data.countryCode);
    prefs.setString('phoneNumber', data.phoneNumber);
    prefs.setInt('userStatus', data.userStatus);
  }

  void changeIsRemeber(bool a) {
    isRemember = a;
    notifyListeners();
  }
}
