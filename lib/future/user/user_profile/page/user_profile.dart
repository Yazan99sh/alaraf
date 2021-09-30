import 'package:alaraf/core/widget/alaraf_background.dart';
import 'package:alaraf/core/widget/alaraf_top_info.dart';
import 'package:alaraf/core/widget/one_typed.dart';
import 'package:alaraf/data/alaraf_api_service.dart';
import 'package:alaraf/future/fortune_teller/fortune_home/widget/fortune_home_item.dart';
import 'package:alaraf/future/login/model/alaraf_user.dart';
import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/navigator_service.dart';
import 'package:alaraf/service/route.dart';
import 'package:alaraf/service/strings.dart';
import 'package:alaraf/service/translate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var navigationService = locator<NavigationService>();
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AlarafTopInfo(
                  back: translate[StringKeys.str_back],
                  page: translate[StringKeys.str_dashboard],
                ),
                Column(
                  children: [
                    FortuneHomeItem(
                      onTap: () =>
                          navigationService.navigateTo(Routes.profileUpdate),
                      title: translate[StringKeys.str_profile_personally],
                      isProfile: true,
                      image:
                          '${locator<AlarafApiService>().serverUrl}/image?id=${locator<AlarafUser>().pictureUrl}',
                    ),
                    FortuneHomeItem(
                        onTap: () =>
                            navigationService.navigateTo(Routes.buyGold),
                        title: translate[StringKeys.str_buy_gold],
                        image: "assets/images/coin.png"),
                    FortuneHomeItem(
                        onTap: () =>
                            navigationService.navigateTo(Routes.fortuneExperts),
                        title: translate[StringKeys.str_experts],
                        image: "assets/images/fortune_icon/social.png"),
                    FortuneHomeItem(
                        onTap: () =>
                            navigationService.navigateTo(Routes.userMessage),
                        title: translate[StringKeys.str_message],
                        image: "assets/images/fortune_icon/messages.png"),
                    FortuneHomeItem(
                      onTap: () async {
                        final Uri params = Uri(
                            scheme: 'mailto',
                            path: 'alarafapp@gmail.com',
                            query: 'subject=Alaraf Support');
                        String url = params.toString();
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          print('Could not launch $url');
                        }
                      },
                      title: translate[StringKeys.str_support],
                      icon: Icon(
                        Icons.support_agent,
                        size: 50,
                        color: Color(0xFFA367A6),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: OneTypedButton(
                        title: translate[StringKeys.str_sign_out],
                        onPressed: () async {
                          var shared = await SharedPreferences.getInstance();
                          shared.remove('id');
                          navigationService.navigateToHome();
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
