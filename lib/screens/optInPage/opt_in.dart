import 'package:flutter/material.dart';

import 'package:feetback/services/navigation_service.dart';
import 'package:feetback/services/service_locator.dart';

import 'package:feetback/widgets/privacy_policy.dart';

class OptInPage extends StatelessWidget {
  final NavigationService _navService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PrivacyPolicy(
        onAccepted: () {
          _navService.clearStackTo('/home');
        },
      ),
    );
  }
}