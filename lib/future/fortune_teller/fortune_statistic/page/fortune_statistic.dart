import 'package:alaraf/core/widget/alaraf_background.dart';
import 'package:alaraf/core/widget/alaraf_top_info.dart';
import 'package:alaraf/core/widget/one_typed.dart';
import 'package:alaraf/future/activity/view_model/activity_view_model.dart';
import 'package:alaraf/future/activity/widget/activity_item.dart';
import 'package:alaraf/future/fortune_teller/fortune_home/widget/fortune_home_item.dart';
import 'package:alaraf/future/profile/widget/bar_item.dart';
import 'package:alaraf/future/profile/widget/point_area.dart';
import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/navigator_service.dart';
import 'package:alaraf/service/route.dart';
import 'package:alaraf/service/strings.dart';
import 'package:alaraf/service/translate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FortuneStatistic extends StatefulWidget {
  @override
  _FortuneStatisticState createState() => _FortuneStatisticState();
}

class _FortuneStatisticState extends State<FortuneStatistic> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var navigationService = locator<NavigationService>();
    var translate =
        Provider.of<TranslateService>(context).selectedLanguageValue;
    var serviceList = [
      {
        "image":"assets/images/activity/love.png",
        "title":translate[StringKeys.str_love]
      },
      {
        "image":"assets/images/activity/aura.png",
        "title":translate[StringKeys.str_spiritual]
      },
      {
        "image":"assets/images/activity/dream.png",
        "title":translate[StringKeys.str_dreams]
      },
      {
        "image":"assets/images/activity/face.png",
        "title":translate[StringKeys.str_face]
      },
      {
        "image":"assets/images/activity/hand.png",
        "title":translate[StringKeys.str_hand]
      },
      {
        "image":"assets/images/activity/tarot.png",
        "title":translate[StringKeys.str_tarot]
      },
      {
        "image":"assets/images/activity/cup.png",
        "title":translate[StringKeys.str_cup]
      },
      {
        "image":"assets/images/activity/star.png",
        "title":translate[StringKeys.str_constellations]
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AlarafTopInfo(back: translate[StringKeys.str_back],page: translate[StringKeys.str_statistics],),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(translate[StringKeys.str_comment],style: TextStyle(fontFamily: "Hacen",color: Colors.white),),
                      Text(translate[StringKeys.str_evaluation],style: TextStyle(fontFamily: "Hacen",color: Colors.white),),
                      Text(translate[StringKeys.str_the_service],style: TextStyle(fontFamily: "Hacen",color: Colors.white),)

                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: ListView(
                        children: [
                          for(Map item in serviceList)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(translate[StringKeys.str_excellent],style: TextStyle(fontFamily: "Hacen",color: Color(0xFFad62aa)),),
                                Text("5,67788",style: TextStyle(fontFamily: "Hacen",color: Color(0xFFad62aa)),),
                                Container(
                                    height: size.width * 0.125,
                                    width:  size.width * 0.125,
                                    child: Image.asset("${item['image']}"))

                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                  ),
                ),
                SizedBox(height: 20,),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
