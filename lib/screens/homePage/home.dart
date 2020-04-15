import 'dart:io';

import 'package:feetback/services/permission_service.dart';
import 'package:flutter/material.dart';

import 'package:feetback/models/jump.dart';

import 'package:feetback/widgets/feetback_app_bar.dart';

import 'package:feetback/services/database_service.dart';
import 'package:feetback/services/service_locator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  DatabaseService _dbs = locator<DatabaseService>();
  final PermissionService _permissionService = locator<PermissionService>();
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      switch (index) {
        case 0:
          Navigator.pushNamed(context, "/jumphistory");
          break;
        case 1:
          Navigator.pushNamed(context, "/jumphistory");
          break;
        case 2:
          Navigator.pushNamed(context, "/connect",
              arguments: Jump(DateTime.now(), 177, 4));
          break;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    asyncInit();
  }

  Future<void> asyncInit() async{        
      _permissionService.requestLocationPermission((){exit(0);});    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FeetbackAppBar(
        title: const Text("Home"),
        height: 92,
        contentAlignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 16, right: 16),
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                  child: Image(
                      image: AssetImage("lib/images/jump-illustration.png"))),
              Row(
                children: <Widget>[
                  Image(
                      image:
                          AssetImage("lib/images/Icon-material-history.png")),
                  SizedBox(width: 16),
                  FutureBuilder<Jump>(
                    future: _dbs.getHighestJump(),
                    builder: (BuildContext context, AsyncSnapshot<Jump> snapshot) {
                      String highestJump;

                      if (snapshot.hasData) {
                        highestJump= snapshot.data.height.toString();
                      } else {
                        highestJump= "--";
                      }

                      return Text(
                        highestJump,
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(fontWeight: FontWeight.bold)
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 32),
              Text('Instructions',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              Text('1. Stand on the mat, align your feet to the pads',
                  style: Theme.of(context).textTheme.subtitle1),
              SizedBox(height: 32),
              Text(
                  '2. When you press JUMP we will start counting down form 3, jump on GO.',
                  style: Theme.of(context).textTheme.subtitle1),
              SizedBox(height: 32),
              Text('3. Try to land with both feet on the pads.',
                  style: Theme.of(context).textTheme.subtitle1),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, "/standonmatpage",
              arguments: Jump(DateTime.now(), 177, 4));
          },
          label: const Text('JUMP'),
          backgroundColor: Colors.red),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).accentColor,
        backgroundColor: Colors.white,
        elevation: 0,
        iconSize: 24.0,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      )
    );
  }
}
