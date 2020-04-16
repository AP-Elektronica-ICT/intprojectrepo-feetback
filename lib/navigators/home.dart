import 'package:flutter/material.dart';

import 'package:feetback/services/navigation_service.dart';
import 'package:feetback/services/service_locator.dart';

import 'package:feetback/screens/homePage/home.dart';
import 'package:feetback/screens/standOnMatPage/stand_on_mat.dart';
import 'package:feetback/screens/connectPage/discovery_page.dart';
import 'package:feetback/screens/jumpPage/jump.dart';

class HomeNavigator extends StatefulWidget {
  HomeNavigator({
    Key key
  }) : super(key: key);

  @override
  _HomeNavigatorState createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator>
  with AutomaticKeepAliveClientMixin  {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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