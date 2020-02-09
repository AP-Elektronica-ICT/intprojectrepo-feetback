import 'package:flutter/material.dart';

import 'package:feetback/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // Color codes for: #33425B
  static Map<int,Color> primaryColorCodes = {
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

  static MaterialColor primaryColor = MaterialColor(0xFF33425B, primaryColorCodes);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feetback',
      theme: ThemeData(
        primarySwatch: primaryColor,
        primaryColorBrightness: Brightness.dark,
        accentColor: const Color(0xFFF33535),
        scaffoldBackgroundColor: Color(0xFFD8E9F0),
      ),
      initialRoute: "/",
      routes: routes,
      debugShowCheckedModeBanner: true,
    );
  }
}