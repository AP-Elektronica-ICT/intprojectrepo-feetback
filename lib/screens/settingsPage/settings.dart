import 'package:flutter/material.dart';

import 'package:feetback/widgets/feetback_app_bar.dart';
import 'package:feetback/screens/settingsPage/widget/setting_option.dart';

import 'package:feetback/services/service_locator.dart';
import 'package:feetback/services/auth_service.dart';
import 'package:feetback/services/notification_service.dart';
import 'package:feetback/services/database_service.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  AnimationController _aniController;
  Animation<Offset> _offset;

  final AuthService _authService = locator<AuthService>();
  final DatabaseService _service = locator<DatabaseService>();
  final NotificationService _notificationService = locator<NotificationService>();

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton(
                child: Text("Add jump data"),
                onPressed: () => {
                    _service.addJumpWithDate(DateTime.utc(2019, 6, 5), 50.3, 3000),
                    _service.addJumpWithDate(DateTime.utc(2019, 10, 25), 50.3, 3000),
                    _service.addJumpWithDate(DateTime.utc(2019, 9, 14, 12, 40), 54.69, 3000),
                    _service.addJumpWithDate(DateTime.utc(2019, 9, 14, 12, 50), 53.200, 3000),
                    _service.addJumpWithDate(DateTime.utc(2019, 5, 14,), 49.32, 3000),
                    _service.addJumpWithDate(DateTime.utc(2018, 10, 29, 14, 24, 2), 60.05, 3000),
                    _service.addJumpWithDate(DateTime.utc(2019, 1, 1), 50.3, 3000),
                    _service.addJumpWithDate(DateTime.utc(2017, 2, 3), 54.71, 3000),
                    _service.addJumpWithDate(DateTime.utc(2019, 9, 14, 14,30), 53.100, 3000),
                    _service.addJumpWithDate(DateTime.utc(2019, 7, 2), 49.32, 3000),
                    _service.addJumpWithDate(DateTime.utc(2020, 4, 14), 55.05, 3000),
                    _service.addJumpWithDate(DateTime.utc(2020, 6, 1), 58.25, 3000),
                    _service.addJumpWithDate(DateTime.utc(2020, 6, 20), 56.05, 3000),
                    _service.addJumpWithDate(DateTime.utc(2020, 6, 19), 55.75, 3000),
                    _service.addJumpWithDate(DateTime.utc(2020, 6, 19,12), 55.55, 3000),
                    _service.addJumpWithDate(DateTime.utc(2020, 6, 18), 54.05, 3000),
                    _service.addJumpWithDate(DateTime.utc(2020, 1, 14), 52.3, 3000),
                    _service.addJumpWithDate(DateTime.utc(2020, 4, 11), 40.0, 3000),
                    _service.addJumpWithDate(DateTime.utc(2020, 4, 8), 41.0, 3000),
                    _service.addJumpWithDate(DateTime.utc(2020, 4, 14), 39.0, 3000),
                    _service.addJumpWithDate(DateTime.utc(2020, 4, 21), 47.0, 3000),
                    _service.addJumpWithDate(DateTime.utc(2020, 4, 21), 60.0, 3000),
                  },
              ),
              RaisedButton(
                child: Text("Show notification"),
                onPressed: () {
                  _notificationService.showNotification();
                },
              ),
              RaisedButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(8),
                    side: BorderSide(color: Theme.of(context).accentColor)),
                color: Theme.of(context).accentColor,
                child: Text("Sign out"),
                onPressed: () => {_askSignOut()},
              ),
            ],
          )
        )
    );
  }
}
