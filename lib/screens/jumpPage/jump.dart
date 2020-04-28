import 'dart:convert';
import 'dart:typed_data';

import 'package:feetback/services/database_service.dart';
import 'package:flutter/material.dart';

import 'package:feetback/services/service_locator.dart';
import 'package:feetback/services/bluetooth_service.dart';

import 'package:feetback/screens/jumpPage/widgets/count_down_timer.dart';
import 'package:feetback/screens/jumpPage/widgets/result_screen.dart';

class JumpPage extends StatefulWidget {
  final bool start;
  const JumpPage({this.start = true});

  @override
  _JumpState createState() => new _JumpState();
}

class _JumpState extends State<JumpPage> {
  final BluetoothService _bluetoothService = locator<BluetoothService>();
  final DatabaseService _databaseService = locator<DatabaseService>();

  bool isConnecting = true;
  bool isDisconnecting = false;
  bool endMessage = false;
  String resultaat = "";

  @override
  void initState() {
    super.initState();
    asyncInit();    
  }

  void asyncInit() async{
    if(await _bluetoothService.isBluetoothEnabled){
      _bluetoothService.cancelConnectionStreamSubsciption();
        _bluetoothService.startListening(_onDataReceived);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        endMessage = false;
        resultaat = "";          
        print("back");
        return true;
      },
      
      child:  Scaffold(
        floatingActionButton: _getFAB(),
        body: Center(
          child:endMessage ? ResultScreen(resultaat): CountDownTimer(),
        ),
      )
    );
  }

  Widget _getFAB() {
    if (!endMessage) {
      return Container();
    } else {
      return RaisedButton(
        onPressed: (){
          //Navigator.pushNamed(context, "/");
          Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
          
          },
        child: Text("Next"),
      );
    }
  }
  
  void _onDataReceived(Uint8List data) {
    print("data recieved");
    String temp = utf8.decode(data);
    print(temp);
    resultaat = resultaat+temp;    
    if(temp.substring(temp.length-1)== "e") {    
      setState(() {
        resultaat = resultaat.substring(0,resultaat.length-1);
        endMessage = true;
        _databaseService.addJump(double.parse(resultaat.substring(0,resultaat.length)), 0, false);
        _bluetoothService.cancelConnectionStreamSubsciption();
      });      
      print("end message");
      print(resultaat);
    }    
  }
}