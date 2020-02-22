import 'package:flutter/widgets.dart';

import 'package:feetback/screens/homePage/home.dart';
import 'package:feetback/screens/signInPage/sign_in.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => SignInPage(title: "Sign In",),
  "/signin": (BuildContext context) => MyHomePage(title: "Sign In",),
};