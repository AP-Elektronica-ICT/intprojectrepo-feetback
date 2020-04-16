import 'dart:io';

import 'package:flutter/material.dart';

import 'package:feetback/models/jump.dart';

import 'package:feetback/widgets/feetback_app_bar.dart';

import 'package:feetback/services/database_service.dart';
import 'package:feetback/services/service_locator.dart';
import 'package:feetback/services/bluetooth_service.dart';
import 'package:feetback/services/permission_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseService _dbs = locator<DatabaseService>();
  final PermissionService _permissionService = locator<PermissionService>();
  final BluetoothService _bluetoothService = locator<BluetoothService>();

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  Future<void> asyncInit() async{
    if (!await _permissionService.requestLocationPermission()) {
      exit(0);
    }
    _bluetoothService.connectWithSavedDevice();
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
                    builder:
                        (BuildContext context, AsyncSnapshot<Jump> snapshot) {
                      String highestJump;

                      if (snapshot.hasData) {
                        highestJump = snapshot.data.height.toString();
                      } else {
                        highestJump = "--";
                      }

                      return Text(highestJump,
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(fontWeight: FontWeight.bold));
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
             Navigator.pushNamed(context, "/standonmat",
              arguments: Jump(DateTime.now(), 177, 4));
              
          },
          label:Text("Jump"),
          backgroundColor: Colors.red
      ),
    );
  }
}
