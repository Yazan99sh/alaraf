import 'package:alaraf/core/widget/alaraf_loading.dart';
import 'package:alaraf/core/widget/alaraf_voice_widget.dart';
import 'package:alaraf/core/widget/one_typed.dart';
import 'package:alaraf/core/widget/text_field_general.dart';
import 'package:alaraf/core/widget/title_text.dart';
import 'package:alaraf/future/login/view_model/login_view_model.dart';
import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/route.dart';
import 'package:alaraf/service/strings.dart';
import 'package:alaraf/service/translate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var theColor = Colors.white;
  var val = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    var translate =
        Provider.of<TranslateService>(context).selectedLanguageValue;
    var isRtl =
        Provider.of<TranslateService>(context).selectedLanguage ==
            Language.arabic;

    var size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<LoginViewModel>.value(
      value: val,
      child: Consumer<LoginViewModel>(
          builder: (_, model, __) => SafeArea(
                top: false,
                bottom: false,
                child: Scaffold(
                  key: model.key,
                  body: model.isRememberChecked ? Stack(
                    children: [

                      SingleChildScrollView(
                        child: Container(
                          width: size.width,
                          height: size.height,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/background.png"),
                                  fit: BoxFit.cover)),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                "assets/images/shadow.png",
                                width: size.width / 5,
                              ),
                              TitleText(
                                label:
                                "${translate[StringKeys.str_sign_in]}",
                              ),
                              Column(
                                children: [
                                  TextFieldGeneral(
                                    textEditingController: model.username,
                                    label: translate[StringKeys.str_mail],
                                    isRtl: isRtl,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFieldGeneral(

                                    textEditingController: model.password,
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
                                  Checkbox(value: model.isRemember, onChanged: (a){
                                    model.changeIsRemeber(a);
                                  },),
                                  SizedBox(width: 5,),
                                  Text(translate[StringKeys.str_remember],style: TextStyle(fontFamily: 'Hacen',color: Colors.white),)
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  OneTypedButton(
                                    title: translate[StringKeys.str_login],
                                    onPressed: () => model.login(),
                                  ),
                                  SizedBox(width: size.width * 0.05),
                                  OneTypedButton(
                                    title:
                                    translate[StringKeys.str_register],
                                    onPressed: () => model.goRegister(),
                                  ),


                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: ()=>Provider.of<TranslateService>(context,listen: false).goEnglish(),
                                    child: Image.asset("assets/images/en-flag.png",width: 50,),
                                  ),
                                  SizedBox(width: 10,),
                                  InkWell(
                                    onTap: ()=>Provider.of<TranslateService>(context,listen: false).goArabic(),
                                    child: Image.asset("assets/images/ar-flag.png",width: 50,),
                                  ),
                                ],
                              )

                            ],

                          ),
                        ),
                      ),
                      if(model.isLoading)
                        AlarafLoading()
                    ],
                  ) : SizedBox(),
                ),
              )),
    );
  }
}
