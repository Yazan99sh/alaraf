import 'package:alaraf/data/alaraf_api_service.dart';
import 'package:alaraf/future/login/model/alaraf_user.dart';
import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/navigator_service.dart';
import 'package:alaraf/service/strings.dart';
import 'package:alaraf/service/translate.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterViewModel extends ChangeNotifier{
  bool isLoading = false;
  TextEditingController txtName = TextEditingController();
  TextEditingController txtSurname = TextEditingController();
  TextEditingController txtMail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtPasswordRe = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  var key = GlobalKey<ScaffoldState>();
  var navigationService = locator<NavigationService>();
  Country country;


  save() async{
    AlarafUser alarafUser = AlarafUser(
      name: txtName.text,
      password: txtPassword.text,
      balance: 120.0,
      pictureUrl: "https://t3.ftcdn.net/jpg/01/09/00/64/360_F_109006426_388PagqielgjFTAMgW59jRaDmPJvSBUL.jpg",
      userName: txtMail.text,
      userType: 1,
      countryCode: int.parse(country.phoneCode),
      phoneNumber: txtPhone.text,
      surname: txtSurname.text,
    );
    var translate =
        Provider.of<TranslateService>(key.currentContext,listen: false).selectedLanguageValue;
    if(txtPassword.text !=txtPasswordRe.text )
      key.currentState.showSnackBar(SnackBar(content: Text("${translate[StringKeys.str_not_match]}")));
    else{
      var apiService = locator<AlarafApiService>();
      isLoading = true;
      notifyListeners();
      print('${alarafUser.password}');
      var result =  await apiService.registerUser(alarafUser);
      isLoading = false;
      notifyListeners();
      navigationService.goBack();


    }
  }
  void showPickerCountry(context){
    showCountryPicker(
      context: context,
      //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
      showPhoneCode: true,
      onSelect: (Country country) {
          this.country = country;
          print(country.phoneCode);
          notifyListeners();
      },
    );
  }


}