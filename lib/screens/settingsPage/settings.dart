import 'dart:core';
import 'dart:html';

import 'package:flutter/material.dart';

import 'package:feetback/widgets/feetback_app_bar.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FeetbackAppBar(
        title: Text("Settings"),
        height: 92,
        contentAlignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left:16, right:16),
        automaticallyImplyLeading: false,
      ),
      
      body: Column (
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: new EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),
            child: Text("hallo"),
            
          ),
          
        ],
      ),);
  }
}