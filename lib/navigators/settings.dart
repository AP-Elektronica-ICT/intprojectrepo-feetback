import 'package:flutter/material.dart';

import 'package:feetback/services/navigation_service.dart';
import 'package:feetback/services/service_locator.dart';

import 'package:feetback/screens/signInPage/sign_in.dart';

class SettingsNavigator extends StatefulWidget {
  SettingsNavigator({
    Key key
  }) : super(key: key);

  @override
  _SettingsNavigatorState createState() => _SettingsNavigatorState();
}

class _SettingsNavigatorState extends State<SettingsNavigator> {

  @override
  Widget build(BuildContext context) {
    print("Build Settings Navigator");
    
    return Navigator(
      key: locator<NavigationService>().settingsNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch(settings.name) {
              case '/':
                return SignInPage();
              break;
            }

            return Center(
              child: Text('Route not found in HomeNavigator.')
            );
          },
        );
      },
      initialRoute: '/',
    );
  }
}