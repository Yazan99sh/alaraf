import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName,{args}) {
    return navigatorKey.currentState.pushNamed(routeName,arguments: args);
  }

  bool goBack() {
    navigatorKey.currentState.pop();
    return true;
  }

  void navigateToHome() {
    return navigatorKey.currentState.popUntil((f) => f.isFirst);
  }
}
