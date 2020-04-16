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
  
  List<Key> _destinationKeys;
  int _currentDestinationIndex = 0;
  Widget _currentNavigator;

  /// This factory is used to lazy load the navigators (pages).
  static Map<String, Widget Function()> _navigatorFactory = <String, Widget Function()>{
    '/home':        () => HomeNavigator(),
    '/jumphistory': () => JumpHistoryNavigator(),
    '/settings':    () => SettingsNavigator()
  };

  /// Destinations matching the items in the bottom navigation bar.
  static List<Destination> _destinations = <Destination>[
    Destination(0, '/home', _navService.homeNavigatorKey),
    Destination(1, '/jumphistory', _navService.jumpHistoryNavigatorKey),
    Destination(2, '/settings', _navService.settingsNavigatorKey)
  ];

  List<Destination> _activeDestinations = <Destination>[
    _destinations[0],
  ];

  @override
  void initState() {
    super.initState();
    print("Init root");
    // Generate keys for each destination, these keys are used to track the state of a page.
    _destinationKeys = List<Key>.generate(_destinations.length, (index) => GlobalKey(debugLabel: "Destination key: $index")).toList();
    // Load the first navigator.
    _currentNavigator = KeyedSubtree(
      key: _destinationKeys[0],
      child: _navigatorFactory[_activeDestinations[0].navigatorRoute](),
    );
    // Select the navigator.
    _navService.selectNavigator(_activeDestinations[0].navigatorKey);
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
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 1000),
            child: _currentNavigator,
          ),
        ),
        bottomNavigationBar: FeetbackBottomNavigationBar(
          currentIndex: _currentDestinationIndex,
          onTap: (index) {
            if (index != _currentDestinationIndex) {

              //Widget navigator;
              
              if (_activeDestinations.length < _destinations.length && !_activeDestinations.contains(_destinations[index])) {
                // Lazy load the navigators
                _activeDestinations.add(_destinations[index]);
              }
              print("Set key: ${_destinationKeys[index]}");
              // Create navigator widget.
              // final navigator = KeyedSubtree(
              //   key: _destinationKeys[index],
              //   child: _navigatorFactory[_activeDestinations.firstWhere((d) => d.index == index).navigatorRoute](),
              // );

              final navigator = _navigatorFactory[_activeDestinations.firstWhere((d) => d.index == index).navigatorRoute]();

              // Select the navigator.
              _navService.selectNavigator(_activeDestinations[index].navigatorKey);

              setState(() {
                _currentNavigator = navigator;
                _currentDestinationIndex = index;
              });
            }
          },
        ),
      ),
    );
  }
}

class Destination {
  final int index;
  /// The string specified in the factory.
  final String navigatorRoute;
  final GlobalKey<NavigatorState> navigatorKey;

  Destination(this.index, this.navigatorRoute, this.navigatorKey);
}