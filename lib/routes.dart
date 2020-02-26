import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:feetback/screens/homePage/home.dart';
import 'package:feetback/screens/signInPage/sign_in.dart';
import 'package:feetback/screens/jumpHistory/jump_history.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => SignInPage(title: "Sign In",),
  "/signin": (BuildContext context) => HomePage(),
  "/jump_history": (BuildContext context) => JumpHistoryPage(),
};

Route<dynamic> generateRoute(RouteSettings settings){
  //getting arguments passed in while calling Navigator.pushNamed
  final args = settings.arguments;

  switch(settings.name){

    case '/' : 
      return MaterialPageRoute(builder: (_) => HomePage());
      break; 
    case '/second' : 
      if(args is String){
        return MaterialPageRoute(builder: (_) => HomePage());
      }

      return _errorRoute();
      break;
    default:
      return _errorRoute();
    break;
    
  }
}

MaterialPageRoute _errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: Text('error'),
      ),
      body: Center(
        child: Text('error'),
      ),
    );
  });
}
