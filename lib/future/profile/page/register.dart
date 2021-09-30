import 'package:alaraf/core/widget/title_text.dart';
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

import '../../../service/strings.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var user = locator<AlarafUser>();
  @override
  Widget build(BuildContext context) {
    print('hi');
    var translate =
        Provider.of<TranslateService>(context).selectedLanguageValue;
    var isRtl =
        Provider.of<TranslateService>(context).selectedLanguage ==
            Language.arabic;

    var size = MediaQuery.of(context).size;
    return SafeArea(
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
          child: Stack(
            children: [
              Positioned(
                left: 10,
                top: 30,
                child: PointArea(translate, user.balance),
              ),
              Center(child: Image.asset("assets/images/ribbon.png")),
              Container(
                transform: Matrix4.translationValues(
                    -size.width / 10, -size.height * 0.16, 0),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProfileImage(
                      imgSrc:
                          "${user.pictureUrl}",
                    ),
                    TitleText(
                      label: "${user.name} ${user.surname}",
                      isPurple: true,
                    )
                  ],
                ),
              ),
              Positioned(
                top: size.height / 2 + size.height / 8,
                width: size.width,
                child: Center(
                    child: Image.asset(
                  "assets/images/shadow.png",
                  width: size.width / 5,
                )),
              ),
              Positioned(
                bottom: 0,
                width: size.width,
                height: size.height * 0.1,
                child: Container(
                  color: Color(0xFF853782).withOpacity(0.7),
                  child: Transform.translate(
                    offset: Offset(0, -15),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        BarItem(
                          label: translate[StringKeys.str_service],
                          image: "assets/images/service.png",
                          onTap: ()=>Navigator.pushNamed(context, Routes.allActivity),
                        ),
                        BarItem(
                          label: translate[StringKeys.str_profile],
                          image: "assets/images/settings.png",
                          onTap: ()=>Navigator.pushNamed(context, Routes.profileDetail),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
