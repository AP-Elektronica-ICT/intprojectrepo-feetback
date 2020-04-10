import 'package:flutter/material.dart';

// https://medium.com/flutter/getting-to-the-bottom-of-navigation-in-flutter-b3e440b9386

class FeetbackBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  FeetbackBottomNavigationBar({
    @required this.currentIndex,
    @required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.show_chart),
          title: Text('chart'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text('settings'),
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Theme.of(context).accentColor,
      backgroundColor: Colors.white,
      elevation: 0,
      iconSize: 24.0,
      onTap: onTap,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }
}