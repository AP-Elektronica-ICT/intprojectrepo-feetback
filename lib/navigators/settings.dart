import 'package:feetback/screens/connectPage/discovery_page.dart';
import 'package:feetback/screens/settingsPage/settings.dart';
import 'package:flutter/material.dart';

import 'package:feetback/services/navigation_service.dart';
import 'package:feetback/services/service_locator.dart';

import 'package:feetback/screens/settingsPage/settings.dart';

class SettingsNavigator extends StatefulWidget {
  SettingsNavigator({
    Key key
  }) : super(key: key);

  @override
  _SettingsNavigatorState createState() => _SettingsNavigatorState();
}

class _SettingsNavigatorState extends State<SettingsNavigator>
  with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("Build Settings Navigator");

    return Navigator(
      key: locator<NavigationService>().settingsNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch(settings.name) {
              case '/':
                return SettingsPage();
              break;
              
              case '/connect':
                return DiscoveryPage();
              break;
            }

            return Center(
              child: Text('Route not found in SettingsNavigator.')
            );
          },
        );
      },
      initialRoute: '/',
    );
  }
}