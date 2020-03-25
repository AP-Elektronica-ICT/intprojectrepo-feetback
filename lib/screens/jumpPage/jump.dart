import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';


import 'package:feetback/screens/jumpPage/widgets/result_screen.dart';
import 'package:feetback/services/service_locator.dart';
import 'package:flutter/material.dart';

import 'package:feetback/services/bluetooth_service.dart';

import 'package:feetback/screens/homePage/home.dart';
import 'package:feetback/screens/jumpPage/widgets/count_down_timer.dart';
import 'package:feetback/widgets/feetback_app_bar.dart';

class JumpPage extends StatefulWidget {
  final bool start;
  const JumpPage({this.start = true});

  @override
  _JumpState createState() => new _JumpState();
}

class _JumpState extends State<JumpPage> {
bool isConnecting = true;
bool isDisconnecting = false;
bool endMessage = false;
String resultaat = "";
String _textString = "";
final BluetoothService _bluetoothService = locator<BluetoothService>();
StreamSubscription _streamSubscription;

@override
  void initState() {
    super.initState();
    asyncInit();    
  }

  void asyncInit() async{
    if(await _bluetoothService.isBluetoothEnabled){
        _bluetoothService.listenToDevice(_onDataReceived);
    }
  }

 

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async {
          endMessage = false;
          resultaat = "";
          
          print("back");
          return true;
        },
        child:  Scaffold( 
        body: Center(
          child:MaterialApp(
              home:endMessage ? ResultScreen(resultaat): CountDownTimer(),
            )
          ),
        )
    );
  }

  

  void _onDataReceived(Uint8List data) {
        
    print("data recieved");
    String temp = utf8.decode(data);
    resultaat = resultaat+temp;
    
    if(temp.substring(temp.length-1)== "e") {    

      
      this.setState(() {
        this._textString = resultaat.substring(0,resultaat.length-1);
        this.endMessage = true;
      });      
      print("end message");
      print(resultaat);
    }    
  }
}