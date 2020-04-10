import 'package:feetback/screens/rootPage/root.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:feetback/screens/homePage/home.dart';
import 'package:feetback/screens/startupPage/startup.dart';
import 'package:feetback/screens/optInPage/opt_in.dart';
import 'package:feetback/screens/signInPage/sign_in.dart';
import 'package:feetback/screens/jumpPage/jump.dart';
import 'package:feetback/screens/jumpHistory/jump_history.dart';
import 'package:feetback/screens/connectPage/discovery_page.dart';
import 'package:feetback/screens/detailedJumpPage/jump_detailed.dart';


Route<dynamic> generateRoute(RouteSettings settings){
  //getting arguments passed in while calling Navigator.pushNamed
  final args = settings.arguments;

  switch(settings.name){

    case '/' : 
      return MaterialPageRoute(builder: (_) => RootPage());
    break;

    case '/home' : 
      return MaterialPageRoute(builder: (_) => HomePage());
    break;

    case '/startup':
      return MaterialPageRoute(builder: (_) => StartUpPage());
    break;

    case '/optin':
      return MaterialPageRoute(builder: (_) => OptInPage());
    break;
  
    case '/signin' : 
      return MaterialPageRoute(builder:  (_) => SignInPage());
    break;
      
    case '/connect' : 
      return MaterialPageRoute(builder:  (_) => DiscoveryPage());
    break;

    case '/jumpdetails' :
      return MaterialPageRoute(builder: (_) => JumpDetailPage(jump : args ));
    break;

    case '/jumphistory' :
      return MaterialPageRoute(builder: (_) => JumpHistoryPage());
    break;

    default :
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
        child: Text('Error this page is not a valid route.'),
      ),
    );
  });
}
