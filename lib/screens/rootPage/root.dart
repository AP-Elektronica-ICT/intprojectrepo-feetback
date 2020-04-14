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

class _RootPageState extends State<RootPage> with TickerProviderStateMixin<RootPage> {
  static NavigationService _navService = locator<NavigationService>();
  
  List<AnimationController> _faders;
  List<Key> _destinationKeys;
  int _currentDestinationIndex = 0;

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
    // Generate an AnimationController for each destination.
    _faders = _destinations.map<AnimationController>((Destination destination) {
      return AnimationController(vsync: this, duration: Duration(milliseconds: 5000));
    }).toList();
    // Set the opacity of the initial destination.
    _faders[_currentDestinationIndex].value = 1.0;
    // Generate keys for each destination, these keys are used to track the state of a page.
    _destinationKeys = List<Key>.generate(_destinations.length, (index) => GlobalKey()).toList();
  }

  @override
  void dispose() {
    // Clean up the animation controllers.
    for (AnimationController controller in _faders) {
      controller.dispose();
    }
    print("Disposed Root");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Build Root");
    return WillPopScope(
      onWillPop: () async {
        return _navService.goBack();
      },
      child: Scaffold(
        body: SafeArea(
          top: false, // Disable top because the app bar in the screens takes care of that.
          child: Stack(
            fit: StackFit.expand,
            // TODO: Lazy load destinations.
            children: _activeDestinations.map((Destination destination) { // Here the view for each destination is build. (thus destinations are not lazy loaded!)
              final bool active = destination.index == _currentDestinationIndex;
              
              final Widget view = FadeTransition(
                opacity: _faders[destination.index].drive(CurveTween(curve: Curves.fastOutSlowIn)),
                child: KeyedSubtree( // Used in combination with the destination keys to track the state of the children.
                  key: _destinationKeys[destination.index],
                  child: _navigatorFactory[destination.navigatorRoute](),
                ),
              );

              if (active) {
                // Start the fading animation when page is selected.
                print('Animating forward: ${destination.navigatorRoute}');
                _faders[destination.index].forward();
                // Select the navigator.
                _navService.selectNavigator(destination.navigatorKey);
              } else {
                // Otherwise reverse the animation (fade out).
                print('Animating backward: ${destination.navigatorRoute}');
                _faders[destination.index].reverse();
              }

              return Offstage(
                offstage: false,
                child: IgnorePointer(
                  ignoring: _faders[destination.index].isAnimating,
                  child: view,
                )
              );

            }).toList(),
          )
        ),
        bottomNavigationBar: FeetbackBottomNavigationBar(
          currentIndex: _currentDestinationIndex,
          onTap: (index) {
            if (index != _currentDestinationIndex) {
              // Lazy load the navigators
              if (_activeDestinations.length < _destinations.length && !_activeDestinations.contains(_destinations[index])) {
                setState(() {
                  _activeDestinations.add(_destinations[index]);
                });
              }
              setState(() {
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