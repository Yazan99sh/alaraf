import 'package:alaraf/core/widget/alaraf_background.dart';
import 'package:alaraf/core/widget/alaraf_generic_textfield.dart';
import 'package:alaraf/core/widget/alaraf_indicator.dart';
import 'package:alaraf/core/widget/alaraf_top_info.dart';
import 'package:alaraf/core/widget/alaraf_voice_widget.dart';
import 'package:alaraf/future/activity/model/alaraf_activity.dart';
import 'package:alaraf/future/fortune_select/model/fortuner_ability.dart';
import 'package:alaraf/future/fortune_teller/fortuner_message/view_model/fortune_message_detail_view_model.dart';
import 'package:alaraf/future/login/model/alaraf_user.dart';
import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/strings.dart';
import 'package:alaraf/service/translate.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

class FortuneMessageDetail extends StatefulWidget {
  final AlarafActivity activity;

  const FortuneMessageDetail({Key key, this.activity}) : super(key: key);

  @override
  _FortuneMessageDetailState createState() => _FortuneMessageDetailState();
}

class _FortuneMessageDetailState extends State<FortuneMessageDetail> {
  var val;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    val = FortuneMessageDetailViewModel(widget.activity);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var translate =
        Provider.of<TranslateService>(context).selectedLanguageValue;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: AlarafBackground(
          child: Padding(
            padding: MediaQuery.of(context).padding,
            child: ChangeNotifierProvider<FortuneMessageDetailViewModel>.value(
              value: val,
              child: Consumer<FortuneMessageDetailViewModel>(
                  builder: (_, model, __) {
                return SingleChildScrollView(
                  child: model.isLoading
                      ? Container(
                          height: size.height,
                          child: Center(
                              child: AlarafIndicator(
                            isDone: model.isDone,
                            isLoading: model.isLoading,
                          )))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AlarafTopInfo(
                              back: translate[StringKeys.str_back],
                              page: translate[StringKeys.str_fortune],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Container(
                                  height: size.height - 100,
                                  width: size.width * .85,
                                  child: ListView(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Color(0xffad62aa)
                                              .withOpacity(0.5),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    translate[StringKeys
                                                        .str_date_of_birth],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "Hacen"),
                                                  ),
                                                  Text(
                                                    model.activity.dateOfBirth
                                                        .toString()
                                                        .substring(0, 10),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "Hacen"),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    translate[StringKeys
                                                        .str_forename],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "Hacen"),
                                                  ),
                                                  Text(
                                                    model.activity.forename,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "Hacen"),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    translate[StringKeys
                                                        .str_mothers_name],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "Hacen"),
                                                  ),
                                                  Text(
                                                    model.activity.motherName,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "Hacen"),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    translate[
                                                        StringKeys.str_sex],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "Hacen"),
                                                  ),
                                                  Text(
                                                    model.activity.sex == 0
                                                        ? translate[
                                                            StringKeys.str_male]
                                                        : translate[StringKeys
                                                            .str_female],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "Hacen"),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    translate[StringKeys
                                                        .str_social_situation],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "Hacen"),
                                                  ),
                                                  Text(
                                                    model.getSocialSituation(
                                                        translate),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "Hacen"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    translate[StringKeys
                                                        .str_written_letter],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "Hacen"),
                                                  ),
                                                  Container(
                                                      constraints:
                                                          BoxConstraints(
                                                              maxWidth:
                                                                  size.width *
                                                                      0.4),
                                                      child: Text(
                                                        model.activity
                                                            .writenLetter,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                "Hacen"),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            if(model.activity.fortuneTypeId == 6)...[
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      translate[StringKeys
                                                          .str_partners_birth_date],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: "Hacen"),
                                                    ),
                                                    Container(
                                                        constraints:
                                                        BoxConstraints(
                                                            maxWidth:
                                                            size.width *
                                                                0.4),
                                                        child: Text(
                                                          model.activity
                                                              .partnerBirthDate.toString()
                                                              .substring(0, 10),
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontFamily:
                                                              "Hacen"),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      translate[StringKeys
                                                          .str_partners_name],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: "Hacen"),
                                                    ),
                                                    Container(
                                                        constraints:
                                                        BoxConstraints(
                                                            maxWidth:
                                                            size.width *
                                                                0.4),
                                                        child: Text(
                                                          model.activity
                                                              .partnerName,
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontFamily:
                                                              "Hacen"),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      translate[StringKeys
                                                          .str_partners_mothers_name],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: "Hacen"),
                                                    ),
                                                    Container(
                                                        constraints:
                                                        BoxConstraints(
                                                            maxWidth:
                                                            size.width *
                                                                0.4),
                                                        child: Text(
                                                          model.activity
                                                              .partnerMotherName,
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontFamily:
                                                              "Hacen"),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ],


                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    translate[
                                                        StringKeys.str_img],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "Hacen"),
                                                  ),
                                                  Container(
                                                      constraints:
                                                          BoxConstraints(
                                                              maxWidth:
                                                                  size.width *
                                                                      0.4),
                                                      child: Wrap(
                                                        children:
                                                            model.activity
                                                                .allImage
                                                                .map(
                                                                    (e) =>
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              InkWell(
                                                                            onTap: () =>
                                                                                showDialogImg("${model.apiService.serverUrl}/image?id=$e"),
                                                                            child:
                                                                                Container(
                                                                              height: size.width * 0.15,
                                                                              width: size.width * 0.15,
                                                                              decoration: BoxDecoration(image: DecorationImage(image: NetworkImage("${model.apiService.serverUrl}/image?id=$e")), borderRadius: BorderRadius.all(Radius.circular(10)), border: Border.all(color: Colors.black54, width: 2)),
                                                                            ),
                                                                          ),
                                                                        ))
                                                                .toList(),
                                                      ))
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    translate[StringKeys
                                                        .str_voice_message],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "Hacen"),
                                                  ),
                                                  Container(
                                                      constraints:
                                                          BoxConstraints(
                                                              maxWidth:
                                                                  size.width *
                                                                      0.4),
                                                      child: VoiceMessage(
                                                        url:
                                                            "${model.apiService.serverUrl}/activity/record?id=${model.activity.id}&isAnswer=false",
                                                      ))
                                                ],
                                              ),
                                            ),
                                            if (locator<AlarafUser>()
                                                    .userType ==
                                                2)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      translate[StringKeys
                                                          .str_voice_response],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: "Hacen"),
                                                    ),
                                                    Container(
                                                      constraints:
                                                          BoxConstraints(
                                                              maxWidth:
                                                                  size.width *
                                                                      0.4),
                                                      child: VoiceMessage(
                                                        recordSaved: (a) {
                                                          model.recordSound = a;
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            if (locator<AlarafUser>()
                                                .userType ==
                                                1 && model.activity.allowedForEXpert)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      translate[StringKeys
                                                          .str_voice_message],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: "Hacen"),
                                                    ),
                                                    Container(
                                                        constraints:
                                                            BoxConstraints(
                                                                maxWidth:
                                                                    size.width *
                                                                        0.4),
                                                        child: VoiceMessage(
                                                          url:
                                                              "${model.apiService.serverUrl}/activity/record?id=${model.activity.id}&isAnswer=true",
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            if (locator<AlarafUser>()
                                                .userType ==
                                                1 && model.activity.allowedForEXpert || locator<AlarafUser>()
                                                .userType == 2)...[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0,
                                                    right: 8.0,
                                                    top: 8),
                                                child: Text(
                                                  translate[
                                                  StringKeys.str_response],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Hacen"),
                                                ),
                                              ),

                                              Container(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 8.0, right: 8),
                                                  child: GenericTextField(
                                                    maxLines: 3,
                                                    controller: model.txtResponse,
                                                    titleVisible: false,
                                                  ),
                                                ),
                                              ),
                                            ],

                                            SizedBox(
                                              height: 40,
                                            )
                                          ],
                                        ),
                                      ),
                                      if (locator<AlarafUser>().userType == 2)
                                        Container(
                                          height: 50,
                                          child: Transform.translate(
                                            offset: Offset(0, -25),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: InkWell(
                                                onTap: () {
                                                  print("hi");
                                                  model.update();
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                    color: Color(0xff7B3D7E),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 12.0,
                                                            right: 12,
                                                            top: 5,
                                                            bottom: 5),
                                                    child: AutoSizeText(
                                                      "${translate[StringKeys.str_reply]}",
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: ScreenUtil()
                                                            .setSp(32),
                                                        fontFamily: "Hacen",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  showDialogImg(url) {
    showDialog(
        context: context,
        builder: (c) => Dialog(
              child: Image.network(url),
            ));
  }
}
