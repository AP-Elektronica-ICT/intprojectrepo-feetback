import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:feetback/services/bluetooth_service.dart';

import 'package:feetback/screens/homePage/home.dart';

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

@override
  void initState() {
    super.initState();

          if(!BluetoothService.getBluetoothService.streamActive){
            BluetoothService.getBluetoothService.connection.input.listen(_onDataReceived).onDone(() {
                print("Listen done");
              if (isDisconnecting) {
                print('Disconnecting locally!');
              }
              else {
                print('Disconnected remotely!');
              }
              if (this.mounted) {
                setState(() {});
              }
            });
            BluetoothService.getBluetoothService.streamActive = true;
          }      
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
        body: Center(
          child: Container(
            height: 500,
            child: Column(
              children: <Widget>[
                this.endMessage == false ? RaisedButton(
                  child: Text("Start"),
                  onPressed: _sendMessage,
                  )
                :Text(""),                
                Text(this._textString),
                this.endMessage == true ? RaisedButton(
                  child: Text("Next"),
                  onPressed: () { 
                    resultaat = "";
                    endMessage = false;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()));},
                )
                :Text(""),                
              ],)
          )
        ),
    );
  }

  void _sendMessage() async {
      
      try {
        BluetoothService.getBluetoothService.connection.output.add(utf8.encode("s"));
        await BluetoothService.getBluetoothService.connection.output.allSent;
        print("sended");
        
      }
      catch (e) {
        // Ignore error, but notify state
        setState(() {});
        print("error" +e);
        return null;
      }

  }

  

  void _onDataReceived(Uint8List data) {
        
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