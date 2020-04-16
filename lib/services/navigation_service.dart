import 'package:flutter/material.dart';

/// https://medium.com/flutter-community/navigate-without-context-in-flutter-with-a-navigation-service-e6d76e880c1c
class NavigationService {
  // All navigators get registered here.
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>(debugLabel: "Root Navigator");
  final GlobalKey<NavigatorState> homeNavigatorKey = new GlobalKey<NavigatorState>(debugLabel: "Home Navigator");
  final GlobalKey<NavigatorState> jumpHistoryNavigatorKey = new GlobalKey<NavigatorState>(debugLabel: "Jump History Navigator");
  final GlobalKey<NavigatorState> settingsNavigatorKey = new GlobalKey<NavigatorState>(debugLabel: "Settings Navigator");

  GlobalKey<NavigatorState> _currentNavigator;
  GlobalKey<NavigatorState> get currentNavigator => _currentNavigator;

  String _currentRoutePath;
  String get currentRoutePath => _currentRoutePath;

  NavigationService() {
    selectNavigator(navigatorKey);
  }

  void selectNavigator(GlobalKey<NavigatorState> key) {
    print("Selected navigator: $key");
    _currentNavigator = key;
  }

  bool goBack() {
    print("Try popping: $_currentNavigator");
    if (_currentNavigator.currentState.canPop()) {
      _currentNavigator.currentState.pop();
      return true;
    }

    return false;
  }

  Future<dynamic> navigateTo(String routeName) {
    print("Pushing $routeName in $_currentNavigator");
    _currentRoutePath = routeName;
    return _currentNavigator.currentState.pushNamed(routeName);
  }

  Future<dynamic> replaceTo(String routeName) {
    print("Replacing $routeName in $_currentNavigator");
    _currentRoutePath = routeName;
    return _currentNavigator.currentState.pushReplacementNamed(routeName);
  }

  Future<dynamic> clearStackTo(String routeName) {
    print("Clearing $_currentNavigator to $routeName");
    _currentRoutePath = routeName;
    return _currentNavigator.currentState.pushNamedAndRemoveUntil(routeName, (route) => false);
  }
}