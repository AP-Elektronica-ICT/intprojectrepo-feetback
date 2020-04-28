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
                    _service.addJumpWithDate(DateTime.utc(2017, 2, 3), 40.71, 3000),
                    _service.addJumpWithDate(DateTime.utc(2017, 2, 8), 40.90, 3000),
                    _service.addJumpWithDate(DateTime.utc(2017, 2, 11), 41.20, 3000),
                    _service.addJumpWithDate(DateTime.utc(2017, 2, 12), 40.71, 3000),
                    _service.addJumpWithDate(DateTime.utc(2017, 2, 14), 40.5, 3000),

                    _service.addJumpWithDate(DateTime.utc(2017, 3, 20), 41.71, 3000),
                    _service.addJumpWithDate(DateTime.utc(2017, 3, 23), 42, 3000),
                    _service.addJumpWithDate(DateTime.utc(2017, 3, 25), 41.20, 3000),
                    _service.addJumpWithDate(DateTime.utc(2017, 4, 26), 42, 3000),
                    _service.addJumpWithDate(DateTime.utc(2017, 6, 26), 46.2, 3000),
                    _service.addJumpWithDate(DateTime.utc(2017, 9, 28), 50.2, 3000),
                    _service.addJumpWithDate(DateTime.utc(2017, 11, 30), 44, 3000),

                    
                    _service.addJumpWithDate(DateTime.utc(2018, 1, 3), 50.71, 3000),
                    _service.addJumpWithDate(DateTime.utc(2018, 2, 8), 50.90, 3000),
                    _service.addJumpWithDate(DateTime.utc(2018, 4, 11), 51.20, 3000),
                    _service.addJumpWithDate(DateTime.utc(2018, 4, 12), 50.71, 3000),
                    _service.addJumpWithDate(DateTime.utc(2018, 6, 14), 50.5, 3000),

                    _service.addJumpWithDate(DateTime.utc(2018, 9, 14), 51.71, 3000),
                    _service.addJumpWithDate(DateTime.utc(2018, 10, 14), 54, 3000),
                    _service.addJumpWithDate(DateTime.utc(2018, 11, 15), 51.20, 3000),
                    _service.addJumpWithDate(DateTime.utc(2018, 11, 15), 52, 3000),
                    _service.addJumpWithDate(DateTime.utc(2018, 12, 17), 56.2, 3000),
                    _service.addJumpWithDate(DateTime.utc(2018, 12, 18), 60.2, 3000),
                    _service.addJumpWithDate(DateTime.utc(2018, 12, 20), 54, 3000),


                    _service.addJumpWithDate(DateTime.utc(2019, 6, 5), 55.8, 3000),
                    _service.addJumpWithDate(DateTime.utc(2019, 10, 25), 55.3, 3000),
                    _service.addJumpWithDate(DateTime.utc(2019, 9, 14, 12, 40), 58.69, 3000),
                    _service.addJumpWithDate(DateTime.utc(2019, 9, 14, 12, 50), 59.200, 3000),
                    _service.addJumpWithDate(DateTime.utc(2019, 5, 14,), 62.32, 3000),
                    _service.addJumpWithDate(DateTime.utc(2019, 1, 1), 63.3, 3000),
                    _service.addJumpWithDate(DateTime.utc(2019, 7, 2), 63.62, 3000),
                    _service.addJumpWithDate(DateTime.utc(2020, 4, 14), 60.05, 3000),
                    
                    _service.addJumpWithDate(DateTime.utc(2020, 1, 14), 65.3, 3000),
                    _service.addJumpWithDate(DateTime.utc(2020, 4, 11), 68.0, 3000),
                    _service.addJumpWithDate(DateTime.utc(2020, 4, 8), 65.9, 3000),
                    _service.addJumpWithDate(DateTime.utc(2020, 4, 14), 60.0, 3000),
                    _service.addJumpWithDate(DateTime.utc(2020, 4, 21), 55.0, 3000),

                    _service.addJumpWithDate(DateTime.utc(2020, 6, 1), 58.25, 3000),
                    _service.addJumpWithDate(DateTime.utc(2020, 6, 20), 56.05, 3000),
                    _service.addJumpWithDate(DateTime.utc(2020, 6, 19), 55.75, 3000),
                    _service.addJumpWithDate(DateTime.utc(2020, 6, 19,12), 55.55, 3000),
                    _service.addJumpWithDate(DateTime.utc(2020, 6, 18), 60.05, 3000),
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
