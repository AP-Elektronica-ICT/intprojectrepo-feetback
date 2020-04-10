import 'package:feetback/screens/detailedJumpPage/jump_detailed.dart';
import 'package:feetback/screens/jumpHistory/jump_history.dart';
import 'package:flutter/material.dart';

import 'package:feetback/routes.dart';

class JumpHistoryNavigator extends StatefulWidget {
  JumpHistoryNavigator({
    Key key
  }) : super(key: key);

  @override
  _JumpHistoryNavigatorState createState() => _JumpHistoryNavigatorState();
}

class _JumpHistoryNavigatorState extends State<JumpHistoryNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
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

            return JumpHistoryPage();
          },
        );
      },
      initialRoute: '/jumphistory',
    );
  }
}