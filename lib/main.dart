import 'package:feetback/screens/homePage/home.dart';
import 'package:flutter/material.dart';

import 'package:feetback/routes.dart';
import 'package:feetback/theme.dart';

import 'package:feetback/services/service_locator.dart';
import 'package:feetback/services/navigation_service.dart';

void main() {
  setupLocator();
  runApp(FeetBackApp());
}

class FeetBackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feetback',
      theme: getFeetbackTheme(context),
      navigatorKey: locator<NavigationService>().navigatorKey,
      initialRoute: "/startup",
      onGenerateRoute: (RouteSettings settings) => generateRoute(settings),
      debugShowCheckedModeBanner: true,
    );
  }
}