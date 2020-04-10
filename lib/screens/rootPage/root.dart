import 'package:flutter/material.dart';

import 'package:feetback/navigators/home.dart';
import 'package:feetback/navigators/jump_history.dart';
import 'package:feetback/navigators/settings.dart';

import 'package:feetback/widgets/feetback_bottom_navigation_bar.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> with TickerProviderStateMixin<RootPage> {
  List<AnimationController> _faders;
  List<Key> _destinationKeys;
  int _currentDestinationIndex = 0;

  List<Destination> _destinations = <Destination>[
    Destination(0, HomeNavigator()),
    Destination(1, JumpHistoryNavigator()),
    Destination(2, SettingsNavigator())
  ];

  @override
  void initState() {
    super.initState();

    // Generate an AnimationController for each destination.
    _faders = _destinations.map<AnimationController>((Destination destination) {
      return AnimationController(vsync: this, duration: Duration(milliseconds: 250));
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

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          fit: StackFit.expand,
          children: _destinations.map((Destination destination) {
            final Widget view = FadeTransition(
              opacity: _faders[destination.index].drive(CurveTween(curve: Curves.fastOutSlowIn)),
              child: KeyedSubtree(
                key: _destinationKeys[destination.index],
                child: destination.navigator,
              ),
            );

            if (destination.index == _currentDestinationIndex) {
              _faders[destination.index].forward();
              return view;
            } else {
              _faders[destination.index].reverse();
              if (_faders[destination.index].isAnimating) {
                return IgnorePointer(child: view);
              }
              return Offstage(child: view);
            }
          }).toList(),
        )
      ),
      bottomNavigationBar: FeetbackBottomNavigationBar(
        currentIndex: _currentDestinationIndex,
        onTap: (index) {
          setState(() {
            _currentDestinationIndex = index;
          });
        },
      ),
    );
  }
}

class Destination {
  final int index;
  final Widget navigator;

  Destination(this.index, this.navigator);
}