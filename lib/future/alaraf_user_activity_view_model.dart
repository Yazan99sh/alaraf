import 'dart:io';
import 'dart:typed_data';
import 'dart:io' as io;

import 'package:alaraf/core/util/country_data.dart';
import 'package:alaraf/core/util/util_function.dart';
import 'package:alaraf/core/widget/bottom_picker.dart';
import 'package:alaraf/data/alaraf_api_service.dart';
import 'package:alaraf/future/activity/model/alaraf_activity.dart';
import 'package:alaraf/future/fortune_select/model/fortuner_ability.dart';
import 'package:alaraf/future/login/model/alaraf_user.dart';
import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/navigator_service.dart';
import 'package:alaraf/service/route.dart';
import 'package:alaraf/service/strings.dart';
import 'package:alaraf/service/translate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/src/asset.dart';
import 'package:provider/provider.dart';

class AlarafUserActivityViewModel extends ChangeNotifier {
  int activityId = UtilFunction.getRandomId();
  bool isImageUploading = false;
  bool isLoading = false;
  bool isDone = true;
  var key = GlobalKey<ScaffoldState>();
  FortunerAbility fortunerAbility;
  var service = locator<AlarafApiService>();
  var navigationService = locator<NavigationService>();
  var txtForeName = TextEditingController();
  var txtWrittenLetter = TextEditingController();
  var txtMotherName = TextEditingController();
  var socialSituations = <String>[];
  int counter = -1;

  File recordSound;
  DateTime dtBirth;
  DateTime dtBirthPartner;
  int sex = -1;
  int socialSituation = -1;
  int activityTypeId = 0;
  var imageUploaded = false;

  var txtBirthPlace = TextEditingController(
      text: countryList.firstWhere((element) =>
          element['dial_code'] == locator<AlarafUser>().countryCode.toString(),orElse: ()=>{'name':''})['name']);

  var txtPartnerName = TextEditingController();
  var txtPartnerMotherName = TextEditingController();

  uploadImage(File file) async {
    isImageUploading = true;
     imageUploaded = true;
    notifyListeners();
    Uint8List data = file.readAsBytesSync();
    String completePath = file.path;
    var fileName = (completePath.split('/').last);

    await Future.delayed(Duration(seconds: 1));
    await service.saveImage(data, activityId, "$fileName");
    isImageUploading = false;
    notifyListeners();
  }

  selectDate(context,{bool isPartnerDate = false}) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(1950),
      lastDate: DateTime(2025),
    );
    if(isPartnerDate){
      if (picked != null && picked != dtBirthPartner) {
        dtBirthPartner = picked;
        notifyListeners();
      }
    }
   else{
      if (picked != null && picked != dtBirth) {
        dtBirth = picked;
        notifyListeners();
      }
    }
  }

  void changeGender(a) {
    sex = a;
  }

  void changeSocialSituation(a) {
    socialSituation = a;
    notifyListeners();
  }
  checkField(int activityTypeId){
    var language = locator<TranslateService>().selectedLanguageValue;
    if([1,3,4].contains(activityTypeId) && !imageUploaded ){
      showAlert(language[StringKeys.str_not_selected_image]);
    }
    else{
      if(txtForeName.text.isEmpty)
        showAlert(language[StringKeys.str_required_forename]);
      else if(txtMotherName.text.isEmpty)
        showAlert(language[StringKeys.str_required_mother_name]);
      else if(txtBirthPlace.text.isEmpty)
        showAlert(language[StringKeys.str_required_birth_date]);
      else if(dtBirth == null)
        showAlert(language[StringKeys.str_required_birt_place]);
      else if(sex == -1)
        showAlert(language[StringKeys.str_required_sex]);
      else if(socialSituation == -1)
        showAlert(language[StringKeys.str_required_birt_place]);
      else if(recordSound == null)
        showAlert(language[StringKeys.str_required_voice]);
      else
        goTeller(activityTypeId);
    }
  }
  showAlert(String alert) =>key.currentState.showSnackBar(SnackBar(content: Text(alert)));
  save() async {
    isDone = false;
    isLoading = true;
    notifyListeners();
    AlarafActivity alarafActivity = AlarafActivity(
        id: activityId,
        dateOfBirth: dtBirth,
        fortuneTypeId: activityTypeId,
        forename: txtForeName.text,
        fortunerId: fortunerAbility.fortunerId,
        sex: sex,
        motherName: txtMotherName.text,
        socialSituation: socialSituation,
        userId: locator<AlarafUser>().id,
        voiceUrl: "",
        partnerMotherName: txtMotherName.text,
        partnerBirthDate: dtBirthPartner,
        partnerName: txtPartnerName.text,
        birthPlace: txtBirthPlace.text,
        isAnswered: false,
        writenLetter: txtWrittenLetter.text);
    await Future.delayed(Duration(seconds: 2));
    isDone = true;
    await service.saveActivity(recordSound.readAsBytesSync(), alarafActivity);
    locator<AlarafUser>().balance -= 30;
    notifyListeners();

    await Future.delayed(Duration(seconds: 2));
    isLoading = false;
    navigationService.goBack();
    notifyListeners();
  }

  void goTeller(int activityId) async {
    //1-Cup
    //2-Tarot
    //3-Palmistry
    //4-FAce
    //5-Dreams
    //6-Love Harmony
    //7-Constellation
    //8- My Soul Revealed
    activityTypeId = activityId;

    var result = await navigationService.navigateTo(Routes.fortuneTeller,
        args: activityId);
    if (result != null) {
      fortunerAbility = result;
      notifyListeners();
    }
  }

  uploadImages(List<Asset> a) async {
    isImageUploading = true;
    notifyListeners();

    for (int i = 0; i < a.length; i++) {
      Asset file = a[i];
      var byteData = await file.getByteData();
      final buffer = byteData.buffer;

      Uint8List data =
          buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      var fileName = file.name;

      await Future.delayed(Duration(seconds: 1));
      await service.saveImage(data, activityId, "$fileName");
    }

    isImageUploading = false;
    notifyListeners();
  }

  void selectdSituation() {
    var translate =
        Provider.of<TranslateService>(key.currentContext, listen: false)
            .selectedLanguageValue;
    if (socialSituations.isEmpty)
      socialSituations = [
        translate[StringKeys.str_single],
        translate[StringKeys.str_divorced],
        translate[StringKeys.str_widower],
        translate[StringKeys.str_separated],
        translate[StringKeys.str_linked],
        translate[StringKeys.str_married],
      ];
  }

  updateCounter(int a) {
    counter = a;
    notifyListeners();
  }
}
