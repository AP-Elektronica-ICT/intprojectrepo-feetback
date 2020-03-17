import 'package:feetback/models/jump.dart';
import 'package:feetback/screens/detailedJumpPage/jump_detailed.dart';

import 'package:flutter/material.dart';

import 'package:feetback/widgets/feetback_app_bar.dart';

class HomePage extends StatefulWidget {
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Index 0 : Home'),
    Text('Index 1 : other'),
    Text('Index 2 : also other')
  ];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      switch (index) {
        case 0:
          Navigator.pushNamed(context, "/jumphistory");
          break;
        case 1:
          Navigator.pushNamed(context, "/signin");
          break;
        case 2:
          Navigator.pushNamed(context, "/jumpdetails",
              arguments: Jump(DateTime.now(), 177, 4));
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FeetbackAppBar(
        title: const Text("Home"),
        height: 92,
        contentAlignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 16, right: 16),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.8),
        child: Container(
          child : Center(
            child: Column(
              children: <Widget>[
                Image(image: AssetImage("assets/home.png"),height: 320.0),
                Text('Maximal jump heigt'),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.brightness_auto),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility_new),
            title: Text(''),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).accentColor,
        backgroundColor: Colors.white,
        iconSize: 20.0,
        onTap: _onItemTapped,
      ),
    );
  }
}
