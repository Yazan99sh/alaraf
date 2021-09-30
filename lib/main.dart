import 'package:alaraf/service/locator.dart';
import 'package:alaraf/service/navigator_service.dart';
import 'package:alaraf/service/route.dart';
import 'package:alaraf/service/translate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(!kIsWeb)
  await Firebase.initializeApp();

  InAppPurchaseConnection.enablePendingPurchases();
  setupLocator();
  initOneSignal("3fe18b97-9c96-40eb-94f2-b67781a6f446");

  runApp(HomeApp());
}

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TranslateService>.value(
      value: locator<TranslateService>(),
      child: MaterialApp(
        theme: ThemeData(
          unselectedWidgetColor: Colors.white
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (r) => Routes.generateRoute(r),
        initialRoute: Routes.authLogin,
        navigatorKey: locator<NavigationService>().navigatorKey,
      ),
    );
  }
}
void initOneSignal(oneSignalAppId) {
  var settings = {
    OSiOSSettings.autoPrompt: true,
    OSiOSSettings.inAppLaunchUrl: true
  };
  OneSignal.shared.init(oneSignalAppId, iOSSettings: settings);
  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);
// will be called whenever a notification is received
  OneSignal.shared
      .setNotificationReceivedHandler((OSNotification notification) {
    print('Received: ' + notification?.payload?.body ?? '');
  });
// will be called whenever a notification is opened/button pressed.
  OneSignal.shared
      .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
    print('Opened: ' + result.notification?.payload?.body ?? '');
  });

}
