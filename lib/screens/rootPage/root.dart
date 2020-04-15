import 'package:flutter/material.dart';

import 'package:feetback/services/navigation_service.dart';
import 'package:feetback/services/service_locator.dart';

import 'package:feetback/navigators/home.dart';
import 'package:feetback/navigators/jump_history.dart';
import 'package:feetback/navigators/settings.dart';

import 'package:feetback/widgets/feetback_bottom_navigation_bar.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  static NavigationService _navService = locator<NavigationService>();

  final _navigators = [
    HomeNavigator(),
    JumpHistoryNavigator(),
    SettingsNavigator()
  ];

  final _navigatorController = PageController(
    keepPage: true
  );
  
  int _currentNavigatorIndex = 0;

  @override
  void initState() {
    super.initState();
    print("Init root");

  }

  @override
  void dispose() {
    print("Disposed Root");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Build Root");
    return WillPopScope(
      onWillPop: () async {
        _navService.goBack();
        // Return false so that the root navigator doesn't pop.
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          top: false, // Disable top because the app bar in the screens takes care of that.
          child: PageView(
            controller: _navigatorController,
            onPageChanged: (index) {
              setState(() {
                _currentNavigatorIndex = index;
              });
            },
            children: _navigators,
            physics: NeverScrollableScrollPhysics(), // No left, right sliding to change page.
          ),
        ),

        bottomNavigationBar: FeetbackBottomNavigationBar(
          currentIndex: _currentNavigatorIndex,
          onTap: (index) {
            //_navigatorController.jumpToPage(index);
            _navigatorController.animateToPage(index, duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
            if (index == 0) {
              _navService.selectNavigator(_navService.homeNavigatorKey);
            }
            if (index == 1) {
              _navService.selectNavigator(_navService.jumpHistoryNavigatorKey);
            }
            if (index == 2) {
              _navService.selectNavigator(_navService.settingsNavigatorKey);
            }
          },
        ),
      ),
    );
  }
}