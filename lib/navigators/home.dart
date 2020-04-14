import 'package:flutter/material.dart';

import 'package:feetback/services/navigation_service.dart';
import 'package:feetback/services/service_locator.dart';

import 'package:feetback/screens/homePage/home.dart';

class HomeNavigator extends StatefulWidget {
  HomeNavigator({
    Key key
  }) : super(key: key);

  @override
  _HomeNavigatorState createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {

  @override
  Widget build(BuildContext context) {
    print("Build Home Navigator");

    return Navigator(
      key: locator<NavigationService>().homeNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch(settings.name) {
              case '/':
                return HomePage();
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