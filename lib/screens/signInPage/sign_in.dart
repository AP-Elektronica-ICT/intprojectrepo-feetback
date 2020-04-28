import 'package:feetback/services/auth_service.dart';
import 'package:feetback/services/navigation_service.dart';
import 'package:feetback/services/service_locator.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import '../signInPage/widgets/google_sign_in_button.dart';

import'package:feetback/services/database_service.dart';


class SignInPage extends StatelessWidget {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navService = locator<NavigationService>();
  DatabaseService _service = locator<DatabaseService>();

  void _handleSignIn() async {
    await _authService.signInWithGoogle();
    
    if (await _authService.isUserSignedIn()) {
      // Navigate to root.
      _navService.clearStackTo('/root');
    }
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light
        ),
        child: Container(
          color: Theme.of(context).primaryColor,      
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage("lib/images/logo.png"), height: 320.0),
                SignInButton(
                  onPressed: () => _handleSignIn(),
                ),
                RaisedButton(
                  child: Text("Sign out"),
                  onPressed: _authService.signOut,
                ),
                RaisedButton(
                child: Text("Add jump"),
                  onPressed: () => {
                    _service.addJumpWithDate(DateTime.utc(2019, 6, 5), 50.3, 3000);
                    _service.addJumpWithDate(DateTime.utc(2019, 10, 25), 50.3, 3000);
                    _service.addJumpWithDate(DateTime.utc(2019, 9, 14, 12, 40), 54.69, 3000);
                    _service.addJumpWithDate(DateTime.utc(2019, 9, 14, 12, 50), 53.200, 3000);
                    _service.addJumpWithDate(DateTime.utc(2019, 5, 14,), 49.32, 3000);
                    _service.addJumpWithDate(DateTime.utc(2018, 10, 29), 60.05, 3000);
                    _service.addJumpWithDate(DateTime.utc(2019, 1, 1), 50.3, 3000);
                    _service.addJumpWithDate(DateTime.utc(2017, 2, 3), 54.71, 3000);
                    _service.addJumpWithDate(DateTime.utc(2019, 9, 14, 14,30), 53.100, 3000);
                    _service.addJumpWithDate(DateTime.utc(2019, 7, 2), 49.32, 3000);
                    _service.addJumpWithDate(DateTime.utc(2020, 4, 14), 55.05, 3000);
                    _service.addJumpWithDate(DateTime.utc(2020, 6, 1), 58.25, 3000);
                    _service.addJumpWithDate(DateTime.utc(2020, 6, 20), 56.05, 3000);
                    _service.addJumpWithDate(DateTime.utc(2020, 6, 19), 55.75, 3000);
                    _service.addJumpWithDate(DateTime.utc(2020, 6, 19,12), 55.55, 3000);
                    _service.addJumpWithDate(DateTime.utc(2020, 6, 18), 54.05, 3000);
                    _service.addJumpWithDate(DateTime.utc(2020, 1, 14), 52.3, 3000);
                    _service.addJumpWithDate(DateTime.utc(2020, 4, 11), 40.0, 3000);
                    _service.addJumpWithDate(DateTime.utc(2020, 4, 8), 30.0, 3000);
                    _service.addJumpWithDate(DateTime.utc(2020, 4, 14), 39.0, 3000);
                    _service.addJumpWithDate(DateTime.utc(2020, 4, 21), 47.0, 3000);
                    _service.addJumpWithDate(DateTime.utc(2020, 4, 21), 70.0, 3000);      
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}