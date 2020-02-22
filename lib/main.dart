import 'package:flutter/material.dart';

import 'package:feetback/routes.dart';

void main() => runApp(FeetBackApp());

class FeetBackApp extends StatelessWidget {

  // Color codes for: #33425B (primaryColor)
  static const Map<int,Color> _primaryColorCodes = const {
    50 : Color.fromRGBO(51, 66, 91, .1),
    100 : Color.fromRGBO(51, 66, 91, .2),
    200 : Color.fromRGBO(51, 66, 91, .3),
    300 : Color.fromRGBO(51, 66, 91, .4),
    400 : Color.fromRGBO(51, 66, 91, .5),
    500 : Color.fromRGBO(51, 66, 91, .6),
    600 : Color.fromRGBO(51, 66, 91, .7),
    700 : Color.fromRGBO(51, 66, 91, .8),
    800 : Color.fromRGBO(51, 66, 91, .9),
    900 : Color.fromRGBO(51, 66, 91, 1),
  };

  static const MaterialColor _primaryColor = const MaterialColor(0xFF33425B, _primaryColorCodes);
  static const Color _accentColor = const Color(0xFFF33535);
  static const Color _backgroundColor = const Color(0xFFD8E9F0);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feetback',
      theme: ThemeData(
        primarySwatch: _primaryColor,
        primaryColorBrightness: Brightness.dark,
        accentColor: _accentColor,
        scaffoldBackgroundColor: _backgroundColor,
        buttonTheme: ButtonThemeData(
          buttonColor: _accentColor,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      initialRoute: "/",
      routes: routes,
      debugShowCheckedModeBanner: true,
    );
  }
}