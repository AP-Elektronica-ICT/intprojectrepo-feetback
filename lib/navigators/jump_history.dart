import 'package:flutter/material.dart';

import 'package:feetback/services/navigation_service.dart';
import 'package:feetback/services/service_locator.dart';

import 'package:feetback/screens/jumpHistory/jump_history.dart';
import 'package:feetback/screens/detailedJumpPage/jump_detailed.dart';

class JumpHistoryNavigator extends StatefulWidget {
  JumpHistoryNavigator({
    Key key
  }) : super(key: key);

  @override
  _JumpHistoryNavigatorState createState() => _JumpHistoryNavigatorState();
}

class _JumpHistoryNavigatorState extends State<JumpHistoryNavigator>
  with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("Build Jump History Navigator");

    return Navigator(
      key: locator<NavigationService>().jumpHistoryNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch(settings.name) {
              case '/':
                return JumpHistoryPage();
              break;

              case '/jumpdetails':
                return JumpDetailPage(jump: settings.arguments);
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