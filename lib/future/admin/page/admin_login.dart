import 'package:alaraf/core/widget/alaraf_loading.dart';
import 'package:alaraf/core/widget/alaraf_voice_widget.dart';
import 'package:alaraf/core/widget/one_typed.dart';
import 'package:alaraf/core/widget/text_field_general.dart';
import 'package:alaraf/core/widget/title_text.dart';
import 'package:alaraf/future/login/view_model/login_view_model.dart';
import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/navigator_service.dart';
import 'package:alaraf/service/route.dart';
import 'package:alaraf/service/strings.dart';
import 'package:alaraf/service/translate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
class AdminLogin extends StatelessWidget {
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    var translate =
        Provider.of<TranslateService>(context).selectedLanguageValue;
    var isRtl =
        Provider.of<TranslateService>(context).selectedLanguage ==
            Language.arabic;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body:                       Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    "assets/images/background.png"),
                fit: BoxFit.cover)),
        child: Transform.scale(
          scale: 0.7,
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "assets/images/shadow.png",
                width: size.height / 5,
              ),
              TitleText(
                isWeb: true,
                label:
                "${translate[StringKeys.str_sign_in]}",
              ),
              Column(
                children: [
                  TextFieldGeneral(
                    isWeb: true,
                    textEditingController: txtUsername,
                    label: translate[StringKeys.str_name],
                    isRtl: isRtl,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFieldGeneral(
                    isWeb: true,
                    textEditingController: txtPassword,
                    isObsecure: true,
                    label:
                    translate[StringKeys.str_password],
                    isRtl: isRtl,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OneTypedButton(
                    isWeb: true,
                    title: translate[StringKeys.str_login],
                    onPressed: (){
                      if(txtUsername.text == 'admin' && txtPassword.text == 'alaraf123.'){
                        locator<NavigationService>().navigateTo(Routes.adminDashboard);
                      }
                    },
                  ),



                ],
              ),

            ],

          ),
        ),
      ),
    );
  }
}
