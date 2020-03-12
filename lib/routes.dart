import 'package:feetback/screens/jumpPage/jump.dart';
import 'package:flutter/widgets.dart';
import 'package:feetback/screens/homePage/home.dart';
import 'package:feetback/screens/signInPage/sign_in.dart';
import 'package:feetback/screens/jumpHistory/jump_history.dart';
import 'package:feetback/screens/connectPage/connect.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => SignInPage(title: "Sign In",),
  "/signin": (BuildContext context) => HomePage(),
  "/connect": (BuildContext context) => DiscoveryPage(),
  "/jump_history": (BuildContext context) => JumpHistoryPage(),
  "/jump": (BuildContext context) => JumpPage(),
};
