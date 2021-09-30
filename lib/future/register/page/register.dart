import 'package:alaraf/core/widget/alaraf_generic_textfield.dart';
import 'package:alaraf/core/widget/alaraf_loading.dart';
import 'package:alaraf/core/widget/one_typed.dart';
import 'package:alaraf/core/widget/text_field_general.dart';
import 'package:alaraf/core/widget/title_text.dart';
import 'package:alaraf/future/register/view_model/register_view_model.dart';
import 'package:alaraf/service/translate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../service/strings.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var val = RegisterViewModel();

  @override
  Widget build(BuildContext context) {
    var translate =
        Provider.of<TranslateService>(context).selectedLanguageValue;
    var isRtl =
        Provider.of<TranslateService>(context).selectedLanguage ==
            Language.arabic;

    var size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<RegisterViewModel>.value(
      value: val,
      child: Consumer<RegisterViewModel>(
        builder: (_,model,__){
          return SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
            key:model.key,
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      width: size.width,
                      height: size.height,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/background.png"),
                              fit: BoxFit.cover)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "assets/images/shadow.png",
                            width: size.width / 5,
                          ),
                          TitleText(
                            label: "${translate[StringKeys.str_register]}",
                          ),
                          Column(
                            children: [
                              //TODO: Profile Picture Section
                              TextFieldGeneral(


                                label: translate[StringKeys.str_name],
                                isRtl: isRtl,
                                textEditingController: model.txtName,
                              ),

                              SizedBox(
                                height: 20,
                              ),
                              TextFieldGeneral(
                                label: translate[StringKeys.str_mail],
                                isRtl: isRtl,
                                textEditingController: model.txtMail,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFieldGeneral(
                                label: translate[StringKeys.str_password],
                                isRtl: isRtl,
                                textEditingController: model.txtPassword,
                                isObsecure: true,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFieldGeneral(

                                textEditingController: model.txtPasswordRe,
                                label: translate[StringKeys.str_password_conf],
                                isRtl: isRtl,
                                isObsecure: true,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFieldGeneral(

                                textEditingController: model.txtPhone,
                                label: translate[StringKeys.str_mobile],
                                isRtl: isRtl,
                                isObsecure: true,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              OneTypedButton(
                                onPressed: ()=>model.showPickerCountry(context),
                                title: model.country == null ? translate[StringKeys.str_birth_place] : model.country.name,
                              ),

                            ],
                          ),
                          OneTypedButton(
                            onPressed: ()=>model.save(),
                            title: translate[StringKeys.str_register],
                          ),
                        ],
                      ),
                    ),
                  ),
                  model.isLoading ? AlarafLoading() : SizedBox()
                ],
              ),
            ),
          );
        },
      )
    );
  }
}
