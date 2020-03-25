import 'package:flutter/material.dart';

import 'package:feetback/services/service_locator.dart';
import 'package:feetback/services/auth_service.dart';
import 'package:feetback/services/navigation_service.dart';

class StartUpPage extends StatefulWidget {
  @override
  _StartUpPageState createState() => _StartUpPageState();
}

class _StartUpPageState extends State<StartUpPage> {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navService = locator<NavigationService>();

  @override
  void initState() {
    super.initState();
    
    handleStartUp();
  }

  void handleStartUp() async {
    bool isSignedIn = await _authService.isUserSignedIn();

    if (isSignedIn) {
      _navService.clearStackTo('/optin');
    } else {
      _navService.clearStackTo('/signin');
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