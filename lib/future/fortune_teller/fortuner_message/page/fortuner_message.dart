import 'package:alaraf/core/widget/alaraf_background.dart';
import 'package:alaraf/core/widget/alaraf_top_info.dart';
import 'package:alaraf/core/widget/bottom_picker.dart';
import 'package:alaraf/core/widget/title_text.dart';
import 'package:alaraf/data/alaraf_api_service.dart';
import 'package:alaraf/data/util_data.dart';
import 'package:alaraf/future/activity/model/alaraf_activity.dart';
import 'package:alaraf/future/fortune_teller/fortuner_message/view_model/fortuner_message_view_model.dart';
import 'package:alaraf/future/login/model/alaraf_user.dart';
import 'package:alaraf/future/profile/widget/point_area.dart';
import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/route.dart';
import 'package:alaraf/service/strings.dart';
import 'package:alaraf/service/translate.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:alaraf/future/activity/page/activity.dart';
import 'package:alaraf/future/login/model/alaraf_user.dart';
import 'package:alaraf/future/profile/widget/bar_item.dart';
import 'package:alaraf/future/profile/widget/point_area.dart';
import 'package:alaraf/future/profile/widget/profile_image.dart';
import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/route.dart';
import 'package:alaraf/service/translate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FortunerMessage extends StatefulWidget {
  @override
  _FortunerMessageState createState() => _FortunerMessageState();
}

class _FortunerMessageState extends State<FortunerMessage> {
  var user = locator<AlarafUser>();
  var val = locator<FortunerMessageViewModel>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var translate =
        Provider.of<TranslateService>(context).selectedLanguageValue;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: AlarafBackground(
          child: Padding(
            padding: MediaQuery.of(context).padding,
            child: ChangeNotifierProvider<FortunerMessageViewModel>.value(
              value: val,
              child:
                  Consumer<FortunerMessageViewModel>(builder: (_, model, __) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AlarafTopInfo(
                      back: translate[StringKeys.str_dashboard],
                      page: translate[StringKeys.str_message],
                      customBackRoute: Routes.fortuneTellerHome,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              var result = await showDialog<bool>(
                                context: context,
                                builder: (BuildContext dialogContext) {
                                  return AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        for (String title in UtilData.status)
                                          ListTile(
                                            onTap: () {
                                              model.updateStatus(UtilData.status
                                                  .indexOf(title));
                                              Navigator.pop(context, true);
                                            },
                                            leading: CircleAvatar(
                                              backgroundColor: UtilData.status
                                                          .indexOf(title) ==
                                                      0
                                                  ? Colors.grey
                                                  : UtilData.status
                                                              .indexOf(title) ==
                                                          1
                                                      ? Colors.green
                                                      : Colors.redAccent,
                                            ),
                                            title: Text(translate[title]),
                                          )
                                      ],
                                    ),
                                  );
                                },
                              );

                              if (result != null) {
                                model.updateRemote();
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: Color(0xff7B3D7E),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 12, top: 5, bottom: 5),
                                child: AutoSizeText(
                                  "${translate[UtilData.status[model.userStatusIndex]]}",
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
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff7B3D7E),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.video_call,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff7B3D7E),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.phone,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff7B3D7E),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.message,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Center(
                              child: Image.asset("assets/images/ribbon.png")),
                          Transform.scale(
                            scale: 0.75,
                            child: Container(
                              transform: Matrix4.translationValues(
                                  -size.width / 10, -size.height * 0.28, 0),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ProfileImage(
                                    imgSrc:
                                        '${locator<AlarafApiService>().serverUrl}/image?id=${locator<AlarafUser>().pictureUrl}',
                                  ),
                                  SizedBox(height: 4,),
                                  TitleText(
                                    label: "${user.name}",
                                    isPurple: true,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: size.height / 3.5,
                            width: size.width,
                            child: Center(
                                child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                if (model.isLoading)
                                  Container(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                else ...[
                                  Container(
                                      alignment: Alignment.topRight,
                                      padding: EdgeInsets.only(top:40),
                                      child: Stack(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [

                                              FilterChip(
                                                  avatar: model.messageType == MessageTypeExpert.waiting ?  Icon(Icons.circle,color: Color(0xffad62aa)  ): null ,
                                                  showCheckmark:false,label: Text(translate[StringKeys.str_waiting]), onSelected: (a){
                                                model.updateMessageType(MessageTypeExpert.waiting);
                                              },selected: model.messageType == MessageTypeExpert.waiting ? true : false),

                                              FilterChip(
                                                  avatar:  model.messageType == MessageTypeExpert.rejected ?  Icon(Icons.circle,color: Color(0xffad62aa),) : null ,
                                                  showCheckmark:false,label: Text(translate[StringKeys.str_rejected]), onSelected: (a){
                                                model.updateMessageType(MessageTypeExpert.rejected);
                                              },selected: model.messageType == MessageTypeExpert.rejected ? true : false),




                                            ],
                                          ),

                                          if (model.allActivity
                                                  .where((element) =>
                                                      element.isAnswered ==
                                                      false)
                                                  .length >
                                              0)
                                            Positioned(
                                                bottom: 0,
                                                child: Container(
                                                  transform:
                                                      Matrix4.translationValues(
                                                          -15, 15, 0),
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Text(
                                                      "${model.allActivity.where((element) => element.isAnswered == false).length}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: "Hacen"),
                                                    ),
                                                  ),
                                                )),
                                        ],
                                      )),
                                  Container(
                                    height: size.height * 0.6,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Color(0xffad62aa)
                                                .withOpacity(0.5),
                                          ),
                                          width: size.width * .85,
                                          child: ListView.builder(
                                              itemCount:
                                                  model.allActivity.length,
                                              itemBuilder: (c, i) {
                                                AlarafActivity activity =
                                                    model.allActivity[i];
                                                return Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          size.width * 0.05),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "${activity.alarafUser.name} ${activity.alarafUser.surname}",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                "Hacen"),
                                                      ),
                                                      InkWell(
                                                        onTap: () => model
                                                            .goDetail(activity),
                                                        child: Container(
                                                          height:
                                                              size.height * .15,
                                                          width:
                                                              size.width * .80,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                          ),
                                                          child: Stack(
                                                            children: [
                                                              if (!activity
                                                                  .isAnswered)
                                                                Container(
                                                                    transform: Matrix4
                                                                        .translationValues(
                                                                            -20,
                                                                            -10,
                                                                            0),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .red,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          12.0),
                                                                      child:
                                                                          Text(
                                                                        translate[
                                                                            StringKeys.str_new],
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    )),
                                                              Positioned(
                                                                left: 0,
                                                                right: 0,
                                                                top: 0,
                                                                bottom: 0,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Container(
                                                                          height: size.height *
                                                                              0.1,
                                                                          child:
                                                                              Image.asset(UtilData.activityImgSrc[activity.fortuneTypeId - 1])),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Text(
                                                                          translate[
                                                                              StringKeys.str_reply],
                                                                          style:
                                                                              TextStyle(fontFamily: "Hacen"),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      if (model.allActivity
                                                                  .length -
                                                              1 ==
                                                          i)
                                                        SizedBox(
                                                          height: 100,
                                                        ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]
                              ],
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
