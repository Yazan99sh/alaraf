import 'package:alaraf/core/widget/alaraf_activity_info.dart';
import 'package:alaraf/core/widget/alaraf_background.dart';
import 'package:alaraf/core/widget/alaraf_generic_textfield.dart';
import 'package:alaraf/core/widget/alaraf_image_upload.dart';
import 'package:alaraf/core/widget/alaraf_indicator.dart';
import 'package:alaraf/core/widget/alaraf_segmented.dart';
import 'package:alaraf/core/widget/alaraf_top_info.dart';
import 'package:alaraf/core/widget/alaraf_voice_widget.dart';
import 'package:alaraf/core/widget/bottom_picker.dart';
import 'package:alaraf/core/widget/one_typed.dart';
import 'package:alaraf/core/widget/text_field_general.dart';
import 'package:alaraf/core/widget/two_type_button.dart';
import 'package:alaraf/data/alaraf_api_service.dart';
import 'package:alaraf/future/alaraf_user_activity_view_model.dart';
import 'package:alaraf/future/fortune_teller/fortune_home/widget/fortune_home_item.dart';
import 'package:alaraf/future/login/model/alaraf_user.dart';
import 'package:alaraf/future/user/profile_update/view_model/profile_update_view_model.dart';
import 'package:alaraf/future/user/shared/widget/social_situation_selector.dart';
import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/route.dart';
import 'package:alaraf/service/strings.dart';
import 'package:alaraf/service/translate.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

class ProfileUpdate extends StatelessWidget {
  final val = ProfileUpdateViewModel();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var isRtl =
        Provider.of<TranslateService>(context).selectedLanguage ==
            Language.arabic;
    var translate =
        Provider.of<TranslateService>(context).selectedLanguageValue;
    return ChangeNotifierProvider<ProfileUpdateViewModel>.value(
      value: val,
      child: Consumer<ProfileUpdateViewModel>(
        builder: (_,model,__){
          return  Scaffold(
              key:model.key,
              body: Builder(
                builder: (c) => GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: SingleChildScrollView(
                    child: AlarafBackground(
                      child: Padding(
                        padding: MediaQuery.of(context).padding,
                        child:Stack(
                          children: [
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               AlarafTopInfo(
                                 back: translate[StringKeys.str_back],
                                 page: translate[
                                 StringKeys.str_profile_personally],
                               ),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:26.0),
                                    child: Container(
                                      height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Color(0xffA367A6), width: 3),
                                          borderRadius: BorderRadius.all(Radius.circular(50)),
                                          image: DecorationImage(image: NetworkImage(
                                            '${locator<AlarafApiService>().serverUrl}/image?id=${locator<AlarafUser>().pictureUrl}',
                                          ),fit: BoxFit.cover))
                                        ),

                                  ),
                                  Expanded(child: SizedBox()),
                                  OneTypedButton(
                                    onPressed: ()=>model.updateProfilePicture(context),
                                    title: translate[StringKeys.str_update],
                                  ),
                                  SizedBox(width: 5,),
                                ],
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: TextFieldGeneral(
                                      label: translate[StringKeys.str_name],
                                      isRtl: isRtl,
                                      textEditingController: model.txtName,
                                    ),
                                  ),
                                  OneTypedButton(
                                    onPressed: ()=>model.updateUserName(translate[StringKeys.str_done]),
                                    title: translate[StringKeys.str_update],
                                  ),
                                  SizedBox(width: 5,),
                                ],
                              ),
                               Row(
                                 children: [
                                   Flexible(
                                     child:   TextFieldGeneral(

                                       textEditingController: model.txtMobile,
                                       label: translate[StringKeys.str_mobile],
                                       isRtl: isRtl,
                                     ),
                                   ),
                                   OneTypedButton(
                                     onPressed: ()=>model.updateUserMobile(translate[StringKeys.str_done]),

                                     title: translate[StringKeys.str_update],
                                   ),
                                   SizedBox(width: 5,),
                                 ],
                               ),
                               Row(
                                 children: [
                                   Flexible(
                                     child: TextFieldGeneral(
                                       label: translate[StringKeys.str_password],
                                       isRtl: isRtl,
                                       textEditingController: model.txtPassword,
                                       isObsecure: true,
                                     ),
                                   ),
                                   OneTypedButton(
                                     onPressed: ()=>model.updateUserPassword(translate[StringKeys.str_done]),
                                     title: translate[StringKeys.str_update],
                                   ),
                                   SizedBox(width: 5,),
                                 ],
                               ),
                               if(locator<AlarafUser>().userType == 2)...[
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: GenericTextField(
                                     maxLines: 3,
                                     controller: model.txtAbout,
                                     hintText:
                                     "${translate[StringKeys.str_about_expert]}",
                                     titleVisible: false,
                                   ),
                                 ),
                                 Center(
                                   child: OneTypedButton(
                                     onPressed: ()=>model.updateAboutMe(translate[StringKeys.str_done]),
                                     title: translate[StringKeys.str_update],
                                   ),
                                 ),
                                 SizedBox(width: 5,),

                                 VoiceMessage(
                                   counter: (a)=>model.updateCounter(a),
                                   recordSaved: (a){
                                     print("Kayıt Bitti");
                                     model.recordSound = a;
                                   },
                                   title:
                                   "${model.counter == -1 ? translate[StringKeys.str_voice_message] : '${(model.counter/60).floor()}:${model.counter%60 >=10 ? '':'0'}${model.counter%60}'}",
                                 ),
                                 if(model.recordSound != null)
                                 Center(
                                   child: OneTypedButton(
                                     onPressed: ()=>model.updateVoiceRecord(translate[StringKeys.str_done]),
                                     title: translate[StringKeys.str_update],
                                   ),
                                 ),
                                 SizedBox(width: 5,),
                               ]



                             ],
                           ),
                            if(model.isLoading)
                              AlarafIndicator(isLoading: model.isLoading,)



                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ));
        },

      ),
    );
  }
}

