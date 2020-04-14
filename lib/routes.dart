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
    // Normally this route was assigned to RootPage. This isn't possible because the default initial route of a navigator is '/'.
    // Apparently flutter builds the widget of this route by default. When we build RootPage we execute code that can't be executed before
    // the startup initialization is done. That's why we swapped StartUpPage to the '/' route and gave RootPage it's own dedicated route.
    case '/' : 
      return MaterialPageRoute(builder: (_) => StartUpPage());
    break;

    case '/home' : 
      return MaterialPageRoute(builder: (_) => HomePage());
    break;

    case '/root':
      return MaterialPageRoute(builder: (_) => RootPage());
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
