import 'dart:core';
import 'package:feetback/models/jump.dart';
import 'package:flutter/material.dart';

class JumpDetailPage extends StatelessWidget {

  final Jump jump;

  JumpDetailPage({Key key, @required this.jump}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jump Info"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.8),
          child: Container(
            child: Center(
              child: Column(children: <Widget>[
                Text(
                  "Height: " + jump.height.toString() + " cm",
                   style: 
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Theme.of(context).accentColor, )),
                //Text(jump.airtime.toString()),
                Text(jump.date.day.toString() + "/" +
                     jump.date.month.toString() + "/" +
                     jump.date.year.toString()),
              ],)
              ,)          
        ),
      ),
    );
  }
}