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
                onPressed: () => {_service.addJump(20.0, 1.67, false)},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}