import 'package:flutter/material.dart';

/// https://medium.com/flutter-community/navigate-without-context-in-flutter-with-a-navigation-service-e6d76e880c1c
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  String _currentRoutePath;
  String get currentRoutePath => _currentRoutePath;

  Future<dynamic> navigateTo(String routeName) {
    _currentRoutePath = routeName;
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> replaceTo(String routeName) {
    _currentRoutePath = routeName;
    return navigatorKey.currentState.pushReplacementNamed(routeName);
  }

  Future<dynamic> clearStackTo(String routeName) {
    _currentRoutePath = routeName;
    return navigatorKey.currentState.pushNamedAndRemoveUntil(routeName, (route) => false);
  }
}