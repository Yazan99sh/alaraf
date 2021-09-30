import 'package:flutter/material.dart';
import 'package:alaraf/core/widget/alaraf_activity_info.dart';
import 'package:alaraf/core/widget/alaraf_background.dart';
import 'package:alaraf/core/widget/alaraf_generic_textfield.dart';
import 'package:alaraf/core/widget/alaraf_image_upload.dart';
import 'package:alaraf/core/widget/alaraf_indicator.dart';
import 'package:alaraf/core/widget/alaraf_multi_image_uplad.dart';
import 'package:alaraf/core/widget/alaraf_segmented.dart';
import 'package:alaraf/core/widget/alaraf_voice_widget.dart';
import 'package:alaraf/core/widget/bottom_picker.dart';
import 'package:alaraf/core/widget/two_type_button.dart';
import 'package:alaraf/future/alaraf_user_activity_view_model.dart';
import 'package:alaraf/future/user/shared/widget/social_situation_selector.dart';
import 'package:alaraf/service/route.dart';
import 'package:alaraf/service/strings.dart';
import 'package:alaraf/service/translate.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';

class AlarafAcitvityForm extends StatelessWidget {
  final AlarafUserActivityViewModel model;
  final int acitivtyType;
  final Map translate;

  const AlarafAcitvityForm({Key key, this.model, this.translate,this.acitivtyType}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return  Expanded(
        child: ListView(
          children: [
            Center(
              child: Container(
                width: size.width * 0.85,
                decoration: BoxDecoration(
                    color: Color(0xffad62aa).withOpacity(0.5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(3),
                    )),
                child: Column(
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    if([1,3,4].contains(acitivtyType))...[
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [

                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ImageUpload(
                              multiplier: 10,
                              onChanged: (a)=>model.uploadImage(a),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ImageUpload(
                              multiplier: 10,
                              onChanged: (a)=>model.uploadImage(a),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ImageUpload(
                              multiplier: 10,
                              onChanged: (a)=>model.uploadImage(a),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ImageUpload(
                              multiplier: 10,
                              onChanged: (a)=>model.uploadImage(a),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: size.width * 0.2,
                              child: Text(
                                "${translate[StringKeys.str_cup_photo]}",
                                style: TextStyle(
                                  fontSize:
                                  ScreenUtil().setSp(32),
                                  fontFamily: "Hacen",
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],

                    GenericTextField(
                      title:
                      translate[StringKeys.str_forename],
                      controller: model.txtForeName,


                      titleVisible: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GenericTextField(
                      title:
                      translate[StringKeys.str_mothers_name],
                      controller: model.txtMotherName,


                      titleVisible: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GenericTextField(
                      title:
                      translate[StringKeys.str_birth_place],
                      controller: model.txtBirthPlace,


                      titleVisible: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    GenericTextField(
                      title: translate[
                      StringKeys.str_date_of_birth],
                      hintText: model.dtBirth == null ? null : model.dtBirth.toString().substring(0,10),
                      onTap: (){
                        model.selectDate(context);
                      },
                      titleVisible: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "${translate[StringKeys.str_sex]}",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(32),
                            fontFamily: "Hacen",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Segmented(
                      optionOne:
                      translate[StringKeys.str_male],
                      optionTwo:
                      translate[StringKeys.str_female],
                      onChanged: (a) {
                        model.changeGender(a);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GenericTextField(
                      title: translate[
                      StringKeys.str_social_situation],
                      hintText: model.socialSituation == -1 ? null : model.socialSituations[model.socialSituation],
                      onTap: (){
                        model.selectdSituation();
                        openSocialSituationSelector(context, model);
                        //showModalBottomSheet(context: context, builder: (_)=>bottomPicker(0, model.socialSituations, (a)=>model.changeSocialSituation(a),context));

                      },
                      titleVisible: true,
                    ),
                    if(acitivtyType == 6)...[
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, left: 8.0),
                        child: Divider(
                          thickness: 1,
                          color: Colors.white,
                        ),
                      ),
                      GenericTextField(
                        title: translate[
                        StringKeys.str_partners_name],
                        controller: model.txtPartnerName,

                        titleVisible: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GenericTextField(
                        controller: model.txtPartnerMotherName,
                        title: translate[StringKeys
                            .str_partners_mothers_name],
                        titleVisible: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GenericTextField(
                        hintText: model.dtBirthPartner == null ? null : model.dtBirthPartner.toString().substring(0,10),
                        onTap: (){
                          model.selectDate(context,isPartnerDate: true);
                        },

                        title: translate[StringKeys
                            .str_partners_birth_date],
                        titleVisible: true,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, left: 8.0),
                        child: Divider(
                          thickness: 1,
                          color: Colors.white,
                        ),
                      ),
                    ],
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GenericTextField(
                        maxLines: 3,
                        controller: model.txtWrittenLetter,
                        hintText:
                        "${translate[StringKeys.str_written_letter]}",
                        titleVisible: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, left: 8.0),
                      child: Divider(
                        thickness: 1,
                        color: Colors.white,
                      ),
                    ),
                    VoiceMessage(
                      counter: (a)=>model.updateCounter(a),
                      recordSaved: (a){
                        print("Kayıt Bitti");
                        model.recordSound = a;
                      },

                      title:
                      "${model.counter == -1 ? translate[StringKeys.str_voice_message] : '${(model.counter/60).floor()}:${model.counter%60 >=10 ? '':'0'}${model.counter%60}'}",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(model.fortunerAbility != null) ...[
                  InkWell(
                    onTap: () {
                      model.save();

                    },
                    child: Transform.translate(
                      offset: Offset(0, -15),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(5)),
                            color: Color(0xff7B3D7E),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 12.0,
                                right: 12,
                                top: 5,
                                bottom: 5),
                            child: AutoSizeText(
                              "${translate[StringKeys.str_send]}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(32),
                                fontFamily: "Hacen",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5,),
                ],
                InkWell(
                  onTap: () {
                    model.checkField(acitivtyType);
                  },
                  child: Transform.translate(
                    offset: Offset(0, -15),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(5)),
                          color: Color(0xff7B3D7E),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12.0,
                              right: 12,
                              top: 5,
                              bottom: 5),
                          child: AutoSizeText(
                            "${translate[StringKeys.str_fortune_teller]}",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(32),
                              fontFamily: "Hacen",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
