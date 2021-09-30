import 'package:alaraf/core/widget/alaraf_background.dart';
import 'package:alaraf/core/widget/alaraf_top_info.dart';
import 'package:alaraf/future/login/model/alaraf_user.dart';
import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/strings.dart';
import 'package:alaraf/service/translate.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

var textE =
    "عندما يريد العالم أن ‪يتكلّم ‬ ، فهو يتحدّث بلغة يونيكود. تسجّل الآن لحضور المؤتمر الدولي العاشر ليونيكود (Unicode Conference)، الذي سيعقد في 10-12 آذار 1997 بمدينة مَايِنْتْس، ألمانيا. و سيجمع المؤتمر بين خبراء من كافة قطاعات الصناعة على الشبكة العالمية انترنيت ويونيكود، حيث ستتم، على الصعيدين الدولي والمحلي على حد سواء مناقشة سبل استخدام يونكود في النظم القائمة وفيما يخص التطبيقات الحاسوبية، الخطوط ";

class FortuneProfilePersonally extends StatefulWidget {
  @override
  _FortuneProfilePersonallyState createState() =>
      _FortuneProfilePersonallyState();
}

class _FortuneProfilePersonallyState
    extends State<FortuneProfilePersonally> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var translate =
        Provider.of<TranslateService>(context).selectedLanguageValue;
    var serviceList = [
      {
        "image": "assets/images/activity/love.png",
        "title": translate[StringKeys.str_love]
      },
      {
        "image": "assets/images/activity/aura.png",
        "title": translate[StringKeys.str_spiritual]
      },
      {
        "image": "assets/images/activity/dream.png",
        "title": translate[StringKeys.str_dreams]
      },
      {
        "image": "assets/images/activity/face.png",
        "title": translate[StringKeys.str_face]
      },
      {
        "image": "assets/images/activity/hand.png",
        "title": translate[StringKeys.str_hand]
      },
      {
        "image": "assets/images/activity/tarot.png",
        "title": translate[StringKeys.str_tarot]
      },
      {
        "image": "assets/images/activity/cup.png",
        "title": translate[StringKeys.str_cup]
      },
      {
        "image": "assets/images/activity/star.png",
        "title": translate[StringKeys.str_constellations]
      },
    ];
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: AlarafBackground(
          child: Padding(
            padding: MediaQuery.of(context).padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size.height * 0.29,
                  width: size.width,
                  color: Colors.white,
                  child: Stack(
                    children: [
                      Center(
                          child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "${locator<AlarafUser>().pictureUrl}"),
                                fit: BoxFit.cover)),
                        alignment: Alignment.bottomRight,
                        width: size.width * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "${locator<AlarafUser>().name} ${locator<AlarafUser>().surname}",
                                style: TextStyle(
                                    fontFamily: "Hacen",
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.end,
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      child: Text(
                                    "5.0",
                                    style: TextStyle(
                                        fontFamily: "Hacen",
                                        color: Color(0xFFedb462)),
                                  )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  for (int i = 0; i < 4; i++)
                                    Icon(
                                      Icons.star,
                                      color: Color(0xFFedb462),
                                      size: 18,
                                    )
                                ],
                              )
                            ],
                          ),
                        ),
                      )),
                      AlarafTopInfo(
                        back: translate[StringKeys.str_back],
                        page: translate[
                            StringKeys.str_profile_personally],
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: size.height * 0.175,
                  width: size.width,
                  color: Color(0xFFad62aa),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (Map item in serviceList) ...[
                        Container(
                          width:
                              size.width * 0.9 / serviceList.length,
                          child: Column(
                            children: [
                              Expanded(
                                  child: Image.asset(
                                "${item['image']}",
                                color: Colors.white,
                              )),
                              AutoSizeText(
                                "${item['title']}",
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Hacen"),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        if (item != serviceList.last)
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 2.0, right: 2, bottom: 30),
                            child: Center(
                              child: Container(
                                width: 1,
                                height: size.width *
                                    0.9 /
                                    serviceList.length,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ]
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 14.0, bottom: 14),
                      child: Container(
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Color(0xffad62aa).withOpacity(0.5),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            )),
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    translate[
                                        StringKeys.str_about_expert],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Hacen"),
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    textE,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Colors.white
                                            .withOpacity(0.7),
                                        fontFamily: "Hacen"),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    translate[StringKeys.str_comment],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Hacen"),
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    textE,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Colors.white
                                            .withOpacity(0.7),
                                        fontFamily: "Hacen"),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
