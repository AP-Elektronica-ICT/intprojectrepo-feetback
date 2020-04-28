import 'package:flutter/material.dart';

import 'package:feetback/services/navigation_service.dart';
import 'package:feetback/services/settings_service.dart';
import 'package:feetback/services/service_locator.dart';

import 'package:feetback/widgets/feetback_app_bar.dart';
import 'package:feetback/widgets/privacy_policy.dart';

class OptInPage extends StatelessWidget {
  final NavigationService _navService = locator<NavigationService>();
  final SettingsService _settingsService = locator<SettingsService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FeetbackAppBar(
        title: Text("Privacy Policy"),
        height: 92,
        contentAlignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 0, right: 16),
      ),
      body: PrivacyPolicy(
        onAccepted: () {
          _settingsService.setPrivacyPolicyAcceptance(true);
          _navService.clearStackTo('/');
        },
      ),
    );
  }
}