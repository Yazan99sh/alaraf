import 'package:alaraf/future/activity/view_model/activity_view_model.dart';
import 'package:alaraf/future/activity/widget/activity_item.dart';
import 'package:alaraf/future/login/model/alaraf_user.dart';
import 'package:alaraf/future/profile/widget/bar_item.dart';
import 'package:alaraf/future/profile/widget/point_area.dart';
import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/route.dart';
import 'package:alaraf/service/strings.dart';
import 'package:alaraf/service/translate.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';


class Activity extends StatefulWidget {
  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  @override
  Widget build(BuildContext context) {
    var translate =
        Provider.of<TranslateService>(context).selectedLanguageValue;

    var size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<ActivityViewModel>.value(
      value: ActivityViewModel(),
      child: Consumer<ActivityViewModel>(
          builder: (_, model, __) => SafeArea(
                top: false,
                bottom: false,
                child: Scaffold(
                  body: Container(
                    width: size.width,
                    height: size.height,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/background.png"),
                            fit: BoxFit.cover)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0, left: 10),
                          child: Row(
                            children: [
                              PointArea(
                                  translate, locator<AlarafUser>().balance),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Container(
                            width: size.width * 0.80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: ListView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0.0, left: 20.5, right: 20.5),
                                  child: InkWell(
                                    onTap: ()=> model.navigatorService.navigateTo(Routes.fortuneTeller,args: -1),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 3,
                                              color: Color(0xFF403D66))),
                                      child: Stack(
                                        children: [
                                          Positioned(

                                              left: 20,
                                              bottom: size.width *0.3 /4,
                                              child: AutoSizeText(
                                            translate[StringKeys.str_live_call],
                                            maxLines: 2 ,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontFamily: "Hacen",
                                                fontSize: ScreenUtil().setSp(60)),
                                          )),
                                          Positioned(
                                              right: 10,
                                              top: 0,
                                              bottom: 0,
                                              child: Opacity(
                                                  opacity: 0.2,
                                                  child: Image.asset(
                                                    'assets/images/activity/live_call.png',
                                                    color: Color(0xFF403D66),
                                                    width: size.width * 0.3,
                                                  ))),
                                          Positioned(
                                              right: size.width * 0.15,
                                              bottom: 5,
                                              child: Image.asset(
                                                'assets/images/activity/live_call.png',
                                                color: Color(0xFF403D66),
                                                width: size.width * 0.2,
                                              ))
                                        ],
                                      ),
                                      width: size.width * 0.35,
                                      height: size.width * 0.35,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ActivityItem(
                                        dTop: true,
                                        title: translate[StringKeys.str_cup],
                                        imageUrl:
                                            "assets/images/activity/cup.png",
                                        onTap: () async {
                                          await model.navigateTo(Routes.theCup);
                                        },
                                      ),
                                      ActivityItem(
                                        title: translate[StringKeys.str_tarot],
                                        imageUrl:
                                            "assets/images/activity/tarot.png",
                                        dLeft: true,
                                        dTop: true,
                                        onTap: () {
                                          model.navigateTo(Routes.theTarot);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ActivityItem(
                                        dTop: true,
                                        title: translate[StringKeys.str_hand],
                                        imageUrl:
                                            "assets/images/activity/hand.png",
                                        onTap: () {
                                          model.navigateTo(Routes.thePalmistry);
                                        },
                                      ),
                                      ActivityItem(
                                        dTop: true,
                                        title: translate[StringKeys.str_face],
                                        imageUrl:
                                            "assets/images/activity/face.png",
                                        dLeft: true,
                                        onTap: () {
                                          model.navigateTo(Routes.theFace);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ActivityItem(
                                        dTop: true,
                                        title: translate[StringKeys.str_dreams],
                                        imageUrl:
                                            "assets/images/activity/dream.png",
                                        onTap: () {
                                          model.navigateTo(Routes.theDreams);
                                        },
                                      ),
                                      ActivityItem(
                                        dTop: true,
                                        title: translate[StringKeys.str_love],
                                        imageUrl:
                                            "assets/images/activity/love.png",
                                        dLeft: true,
                                        onTap: () {
                                          model.navigateTo(
                                              Routes.theLoveHarmony);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ActivityItem(
                                        dTop: true,
                                        title: translate[StringKeys.str_constellations],
                                        imageUrl:
                                            "assets/images/activity/star.png",
                                        onTap: () {
                                          model.navigateTo(Routes.theConstellation);
                                        },
                                      ),
                                      ActivityItem(
                                        dTop: true,
                                        title: translate[StringKeys.str_spiritual],
                                        imageUrl:
                                            "assets/images/activity/aura.png",
                                        dLeft: true,
                                        onTap: () {
                                          model.navigateTo(
                                              Routes.theMySoulRevealed);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: size.width,
                          color: Color(0xFF853782).withOpacity(0.7),
                          child: Transform.translate(
                            offset: Offset(0, -15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BarItem(
                                  label: translate[StringKeys.str_profile],
                                  image: "assets/images/settings.png",
                                  onTap: () => Navigator.pushNamed(
                                      context, Routes.profileDetail),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )),
    );
  }
}
