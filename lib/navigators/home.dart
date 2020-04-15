import 'package:feetback/screens/connectPage/discovery_page.dart';
import 'package:feetback/screens/homePage/home.dart';
import 'package:feetback/screens/jumpPage/jump.dart';
import 'package:feetback/screens/standOnMatPage/stand_on_mat.dart';
import 'package:flutter/material.dart';

import 'package:feetback/routes.dart';

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
    return Navigator(
      key: new GlobalKey<NavigatorState>(),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch(settings.name) {
              case '/':
                return HomePage();
              break;
              case '/standonmat':
                return StandOnMatPage();
              break;
              case '/connect':
                return DiscoveryPage();
              break;
              case '/jump':
                return JumpPage();
              break;
            }

            return HomePage();
          },
        );
      },
      initialRoute: '/',
    );
  }
}