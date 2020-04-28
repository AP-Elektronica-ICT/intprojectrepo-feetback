import 'dart:convert';
import 'dart:typed_data';

import 'package:feetback/widgets/feetback_app_bar.dart';
import 'package:flutter/material.dart';

import 'package:feetback/services/service_locator.dart';
import 'package:feetback/services/bluetooth_service.dart';

class StandOnMatPage extends StatefulWidget {

  @override
  _StandOnMatState createState() => new _StandOnMatState();
}

class _StandOnMatState extends State<StandOnMatPage> {
  final BluetoothService _bluetoothService = locator<BluetoothService>();
  bool isStandingOnMat = false;

  @override
  void initState() {
    super.initState();
    asyncInit();    
  }

  void asyncInit() async{
    if(await _bluetoothService.isBluetoothEnabled){
      _bluetoothService.startListening(_onDataReceived);
    }
  } 

  @override
  void dispose(){
    _bluetoothService.cancelConnectionStreamSubsciption();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FeetbackAppBar(
          title: const Text(""),
          height: 92,
          contentAlignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 16, right: 16),
        ),
      floatingActionButton: _getFAB(),
      body: Center(
        child:isStandingOnMat ? Text("Press Jump to start the countdown.") : Text("Please stand on the mat."),
      ),
    );
  }

  Widget _getFAB() {
    if (!isStandingOnMat) {
      return Container();
    } else {
      return RaisedButton(
            onPressed: (){
              Navigator.pushNamed(context, "/jump");
              },
            child: Text("Jump"),
          );
    }
  }

  void _onDataReceived(Uint8List data) {
    String temp = utf8.decode(data);
    temp = temp.substring(temp.length-1); 
    if(temp == "y"){ 
      this.setState(() {
        this.isStandingOnMat = true;
      });
    }
    else{
      this.setState(() {
        this.isStandingOnMat = false;
      });
    }
  }
}