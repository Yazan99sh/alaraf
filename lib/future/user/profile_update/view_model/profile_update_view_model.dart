import 'dart:io';
import 'dart:typed_data';

import 'package:alaraf/data/alaraf_api_service.dart';
import 'package:alaraf/future/login/model/alaraf_user.dart';
import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/navigator_service.dart';
import 'package:alaraf/service/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUpdateViewModel extends ChangeNotifier {
  var navigatorService = locator<NavigationService>();
  var apiService = locator<AlarafApiService>();
  var user = locator<AlarafUser>();
  var key = GlobalKey<ScaffoldState>();
  TextEditingController txtName;
  TextEditingController txtMobile;
  TextEditingController txtPassword = TextEditingController();
  bool isLoading = false;
  int counter = -1;
  File recordSound;


  var txtAbout ;
  ProfileUpdateViewModel(){
    txtName = TextEditingController(text: user.name);
    txtMobile = TextEditingController(text: user.phoneNumber);
    txtAbout = TextEditingController(text: user.aboutExpert);
  }

  void updateUserName(String doneText) async{
    isLoading = true;
    notifyListeners();
    await apiService.updateUserName(user.id, txtName.text);
    key.currentState.showSnackBar(SnackBar(content: Text('$doneText')));
    isLoading = false;
    notifyListeners();
  }
  void updateUserMobile(String doneText) async{
    isLoading = true;
    notifyListeners();
    await apiService.updateUserMobile(user.id, txtMobile.text);
    key.currentState.showSnackBar(SnackBar(content: Text('$doneText')));
    isLoading = false;
    notifyListeners();
  }
  void updateUserPassword(String doneText) async{
    isLoading = true;
    notifyListeners();
    await apiService.updateUserPassword(user.id, txtPassword.text);
    key.currentState.showSnackBar(SnackBar(content: Text('$doneText')));
    isLoading = false;
    notifyListeners();
  }
  void updateAboutMe(String doneText) async{
    isLoading = true;
    notifyListeners();
    await apiService.updateUserAbout(user.id, txtAbout.text);
    key.currentState.showSnackBar(SnackBar(content: Text('$doneText')));
    isLoading = false;
    notifyListeners();
  }

  updateProfilePicture(BuildContext context) async {
    var file;
    final picker = ImagePicker();
    var result =  await showCupertinoModalPopup(context: context, builder: (c){
      return CupertinoActionSheet(
        title: Text("Cupertino Action Sheet"),
        message: Text("Select any action "),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text("Camera"),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context,ImageSource.camera);
            },
          ),
          CupertinoActionSheetAction(
            child: Text("Gallery"),
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context,ImageSource.gallery);
            },
          )
        ],
      );
    });
    if(result != null){
      final pickedFile =
      await picker.getImage(source: result);

        if (pickedFile != null) {
          file = File(pickedFile.path);
          Uint8List data = file.readAsBytesSync();
          var result = await locator<AlarafApiService>().saveImage(data, 1, '',isProfilePicture: true,userId: locator<AlarafUser>().id.toString());
          locator<AlarafUser>().pictureUrl = result.id.toString();
          notifyListeners();
        } else {
          print('No image selected.');
        }

    }

  }

  updateCounter(a) {
    counter = a;
    notifyListeners();
  }

  updateVoiceRecord(translate) async {
    isLoading = true;
    notifyListeners();
    Uint8List data = recordSound.readAsBytesSync();
    await apiService.updateUserVoiceRecord(data, locator<AlarafUser>().id);
    key.currentState.showSnackBar(SnackBar(content: Text('$translate')));
    isLoading = false;
    notifyListeners();
  }
}
