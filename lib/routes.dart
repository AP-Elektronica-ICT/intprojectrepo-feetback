
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:feetback/screens/homePage/home.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => MyHomePage(title: "hello",),
};


class RouteGenerator {
    static Route<dynamic> generateRoute(RouteSettings settings){
      //getting arguments passed in while calling Navigator.pushNamed
      final args = settings.arguments;

      switch(settings.name){

        case '/' : 
          return MaterialPageRoute(builder: (_) => MyHomePage());
          break; 
        case '/second' : 
          if(args is String){
            return MaterialPageRoute(builder: (_) => MyHomePage());
          }

          return _errorRoute();
          break;
        default:
          return _errorRoute();
        break;
        
      }
    }

    static Route<dynamic> _errorRoute(){
      return MaterialPageRoute(builder: (_) {
        return Scaffold(
        appBar: AppBar (
          title : Text('error'),
          ),
        body: Center(
          child: Text('error'),
          ),

        );
      });
      
    }
}

