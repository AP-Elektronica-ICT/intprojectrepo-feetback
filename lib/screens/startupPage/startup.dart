import 'package:flutter/material.dart';

import 'package:feetback/services/service_locator.dart';
import 'package:feetback/services/auth_service.dart';
import 'package:feetback/services/navigation_service.dart';
import 'package:feetback/services/settings_service.dart';

class StartUpPage extends StatefulWidget {
  @override
  _StartUpPageState createState() => _StartUpPageState();
}

class _StartUpPageState extends State<StartUpPage> {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navService = locator<NavigationService>();
  final SettingsService _settingsService = locator<SettingsService>();

  @override
  void initState() {
    super.initState();
    handleStartUp();
  }

  void handleStartUp() async {
    if (await _settingsService.isPrivacyPolicyAccepted) {
      bool isSignedIn = await _authService.isUserSignedIn();

      if (isSignedIn) {
        print('Go to root');
        _navService.clearStackTo('/');
      } else {
        print('Go to sign in');
        _navService.clearStackTo('/signin');
      }
    } else {
      print('Go to optin');
      _navService.clearStackTo('/optin');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Image.asset(
          'lib/images/logo.png',
          height: 320.0,
        ),
      ),
    );
  }
}