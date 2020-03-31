import 'package:flutter/material.dart';

import 'package:feetback/widgets/feetback_app_bar.dart';
import 'package:feetback/screens/settingsPage/widget/setting_option.dart';

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
        actions: <Widget>[
          new IconTheme(
            data: new IconThemeData(
              color: Theme.of(context).primaryColor,
              size: 35
            ), 
            child: new Icon(Icons.refresh),
          )
        ],
      ),
      body: SettingOptions()
      );
  }
}