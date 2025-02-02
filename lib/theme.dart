import 'package:flutter/material.dart';

// Color codes for: #33425B (primaryColor)
const Map<int,Color> _primaryColorCodes = const {
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

const MaterialColor _primaryColor = const MaterialColor(0xFF33425B, _primaryColorCodes);
const Color _accentColor = const Color(0xFFF33535);
const Color _backgroundColor = const Color(0xFFEEEEEE);

ThemeData getFeetbackTheme(BuildContext context) => ThemeData(
  fontFamily: 'Product Sans',
  textTheme: Theme.of(context).textTheme.copyWith(
    button: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ).apply(
    bodyColor: _primaryColor,
    displayColor: _primaryColor,
  ),
  primarySwatch: _primaryColor,
  primaryColorBrightness: Brightness.dark,
  accentColor: _accentColor,
  canvasColor: Colors.transparent, // To avoid white background with for example rounded corners. (Can be removed if bad behaviour)
  scaffoldBackgroundColor: _backgroundColor,
  appBarTheme: AppBarTheme(
    brightness: Brightness.light,
    color: _backgroundColor,
    elevation: 0,
    textTheme: TextTheme(
      headline6: TextStyle(
        color: _primaryColor,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: IconThemeData(
      color: _primaryColor
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: _accentColor,
    textTheme: ButtonTextTheme.primary,
    shape: StadiumBorder(),
  ),
);