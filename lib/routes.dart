import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:feetback/screens/homePage/home.dart';

// final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
//   "/": (BuildContext context) => MyHomePage(
//         title: "hello",
//       ),
// };

Route<dynamic> generateRoutes(RouteSettings settings) {
  //getting arguments passed in while calling Navigator.pushNamed
  final args = settings.arguments;

  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => MyHomePage(title: "Hello",));
      break;
    case '/second':
      if (args is String) {
        return MaterialPageRoute(builder: (_) => MyHomePage(title: "Hello2",));
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
        child: Text('Error this page is not a valid route.'),
      ),
    );
  });
}
