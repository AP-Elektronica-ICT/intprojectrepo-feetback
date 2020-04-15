import 'package:feetback/screens/connectPage/discovery_page.dart';
import 'package:feetback/screens/signInPage/sign_in.dart';
import 'package:flutter/material.dart';

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
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch(settings.name) {
              case '/':
                return SignInPage();
              break;
            }

            return SignInPage();
          },
        );
      },
      initialRoute: '/',
    );
  }
}