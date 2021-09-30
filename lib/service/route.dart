import 'package:alaraf/future/activity/page/activity.dart';
import 'package:alaraf/future/admin/page/admin_dashboard.dart';
import 'package:alaraf/future/admin/page/admin_login.dart';
import 'package:alaraf/future/fortune_select/page/fortune_select.dart';
import 'package:alaraf/future/fortune_teller/fortune_ability/page/fortune_ability.dart';
import 'package:alaraf/future/fortune_teller/fortune_experts/page/fortune_experts.dart';
import 'package:alaraf/future/fortune_teller/fortune_home/page/fortune_home.dart';
import 'package:alaraf/future/fortune_teller/fortune_profile_personally/page/fortune_profile_personally.dart';
import 'package:alaraf/future/fortune_teller/fortune_statistic/page/fortune_statistic.dart';
import 'package:alaraf/future/fortune_teller/fortuner_message/page/fortune_message_detail.dart';
import 'package:alaraf/future/fortune_teller/fortuner_message/page/fortuner_message.dart';
import 'package:alaraf/future/fortune_teller/fortuner_receive_call/page/expert_receive_call.dart';
import 'package:alaraf/future/login/page/login.dart';
import 'package:alaraf/future/profile/page/register.dart';
import 'package:alaraf/future/register/page/register.dart';
import 'package:alaraf/future/user/constellation/page/the_constellation.dart';
import 'package:alaraf/future/user/dreams/page/the_dreams.dart';
import 'package:alaraf/future/user/face/page/the_face.dart';
import 'package:alaraf/future/user/gold_buy/page/gold_buy.dart';
import 'package:alaraf/future/user/love_harmony/page/love_harmony.dart';
import 'package:alaraf/future/user/my_soul_revealed/page/my_soul_revealed.dart';
import 'package:alaraf/future/user/palmistry/page/the_palmistry.dart';
import 'package:alaraf/future/user/phone_call/page/phone_call.dart';
import 'package:alaraf/future/user/profile_update/page/profile_update.dart';
import 'package:alaraf/future/user/tarot/page/the_tarot.dart';
import 'package:alaraf/future/user/the_cup/page/the_cup.dart';
import 'package:alaraf/future/user/user_message/page/user_message.dart';
import 'package:alaraf/future/user/user_profile/page/user_profile.dart';
import 'package:alaraf/future/welcome/page/welcome_page.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  static const root = '/';

  // auth
  static const authWelcome = '/auth/welcome';
  static const authLogin = '/auth/login';
  static const authRegister = '/auth/register';

  static const profile = '/user/profile';
  static const profileUpdate = '/user/profile-update';
  static const buyGold = '/user/buy*gold';
  static const voiceCall = '/user/voice-call';
  static const userMessage = '/user/message';
  static const profileDetail = '/user/profile-detail';
  static const allActivity = 'activity';
  static const theCup = 'activity/cup';
  static const theConstellation = 'activity/constellation';
  static const fortuneTeller = 'activity/fortune_teller';
  static const thePalmistry = 'activity/palmistry';
  static const theTarot = 'activity/tarot';
  static const theDreams = 'activity/dreams';
  static const theFace = 'activity/face';
  static const theLoveHarmony = 'activity/love';
  static const theMySoulRevealed = 'activity/mySoulRevealed';

  //fortuner
  static const fortuneTellerHome = 'fortune_teller/home';
  static const fortuneProfilePage = 'fortune_teller/profile';
  static const fortuneStatistic = 'fortune_teller/statistic';
  static const fortuneExperts = 'fortune_teller/experts';
  static const fortuneMessage = 'fortune_teller/message';
  static const fortuneMessageDetail = 'fortune_teller/message/detail';
  static const fortuneAbility = 'fortune_teller/ability';
  static const fortuneReceiveCall = 'fortune_teller/receive_call';

  //admin
  static const adminLogin = 'admin/login';
  static const adminDashboard = 'admin/dashboard';

  static MaterialPageRoute generateRoute(RouteSettings routeSettings,
      {Widget root}) {
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (context) => _buildPage(
          routeSettings.name, routeSettings.arguments, root),
    );
  }

  static Widget _buildPage(
      String name, Object arguments, Widget newRoot) {
    switch (name) {
      case root:
        return LoginPage();

      case authLogin:
        return LoginPage();
      case authRegister:
        return RegisterPage();
      case allActivity:
        return Activity();
      case userMessage:
        return UserMessage();
      case profile:
        return ProfilePage();
      case profileDetail:
        return UserProfile();
      case theCup:
        return TheCup();
      case theConstellation:
        return TheConstellation();
      case fortuneTeller:
        return FortuneSelect(activityId: arguments,);
      case thePalmistry:
        return ThePalmistry();
      case theTarot:
        return TheTarot();
      case theDreams:
        return TheDreams();
      case buyGold:
        return GoldBuy();
      case theFace:
        return TheFace();
      case theLoveHarmony:
        return TheLoveHarmony();
      case theMySoulRevealed:
        return TheMySoulRevealed();
      case fortuneTellerHome:
        return FortuneTellerHome();
      case fortuneProfilePage:
        return FortuneProfilePersonally();
      case fortuneStatistic:
        return FortuneStatistic();
      case fortuneExperts:
        return FortuneExperts();
      case fortuneMessage:
        return FortunerMessage();
      case fortuneMessageDetail:
        return FortuneMessageDetail(activity: arguments);
      case adminLogin:
        return AdminLogin();
      case adminDashboard:
        return AdminDashboard();
        case voiceCall:
        return VoiceCallPage(expert: arguments,);
      case fortuneAbility:
        return FortuneAbility();
      case fortuneReceiveCall:
        return ExpertReceiveCall(receivedCall: arguments);
      case profileUpdate:
        return ProfileUpdate();


      default:
        return Container(); // TODO: CREATE NOT FOUND PAGE
    }
  }
}
