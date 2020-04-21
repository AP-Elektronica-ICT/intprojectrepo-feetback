//import 'package:flutter/cupertino.dart';
//import 'dart:html';

import 'package:feetback/main.dart';
import 'package:feetback/screens/settingsPage/settings.dart';
import 'package:feetback/widgets/feetback_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:feetback/screens/animationTest/widget2.dart';
import 'package:feetback/screens/settingsPage/widget/setting_option.dart';

class Widget1 extends StatefulWidget {
  const Widget1({Key key}) : super(key: key);
  @override
  _Widget1State createState() => _Widget1State();
}

class _Widget1State extends State<Widget1> {
  int _count = 0;
  bool switched = false;
  Animation<Offset> _offset;
  Widget _myWidget = Text("test", key: ValueKey(1));
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (
                Widget child,
                Animation<double> animation,
              ) {
                _offset = Tween<Offset>(
                        end: Offset.zero, begin: Offset(4.0, 0.0))
                    .animate(
                        CurvedAnimation(parent: animation, curve: Curves.ease));
                return FadeTransition(opacity: animation, child: child);
              },
              child:  _myWidget
            ),
            RaisedButton(
              child: Text("Do it"),
              onPressed:()=> setState(() {
                switched = !switched;
                if 
                _myWidget = Widget2();
              }),
            )
          ],
        ),
      ),
    );
  }
}
