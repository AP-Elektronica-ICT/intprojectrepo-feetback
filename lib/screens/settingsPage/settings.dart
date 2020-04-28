import 'package:flutter/material.dart';

import 'package:feetback/widgets/feetback_app_bar.dart';
import 'package:feetback/screens/settingsPage/widget/setting_option.dart';

import 'package:feetback/services/service_locator.dart';
import 'package:feetback/services/auth_service.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  AnimationController _aniController;
  Animation<Offset> _offset;

  final AuthService _authService = locator<AuthService>();

  void initState() {
    super.initState();
    _aniController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: false);
    _offset = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _aniController,
      curve: Curves.easeInOutCirc,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _aniController.dispose();
  }

  void _askSignOut() {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text("Sign out"),
              content: Text("Are you sure you want to sign out?"),
              actions: <Widget>[
                new FlatButton(
                    child: new Text("NO"),
                    onPressed: () => {Navigator.of(context).pop()}),
                new FlatButton(
                    child: new Text("YES"),
                    onPressed: () => {
                          _authService.signOut(),
                          Navigator.pushNamed(context, "/signin")
                        })
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: FeetbackAppBar(
          title: Text("Settings"),
          height: 92,
          contentAlignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 16, right: 16),
          automaticallyImplyLeading: false,
        ),
        body: SettingOptions(),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(8),
                  side: BorderSide(color: Theme.of(context).accentColor)),
              color: Theme.of(context).accentColor,
              child: Text("Sign out"),
              onPressed: () => {_askSignOut()},
            )));
  }
}
