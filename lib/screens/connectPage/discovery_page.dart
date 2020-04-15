import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:feetback/screens/homePage/home.dart';

import 'package:feetback/services/bluetooth_service.dart';
import 'package:feetback/services/service_locator.dart';

import 'widgets/BluetoothDeviceListEntry.dart';


class DiscoveryPage extends StatefulWidget {
  /// If true, discovery starts on page start, otherwise user must press action button.
  final bool start;
  
  const DiscoveryPage({this.start = true});

  @override
  _DiscoveryPage createState() => new _DiscoveryPage();
}

class _DiscoveryPage extends State<DiscoveryPage> {
  List<BluetoothDiscoveryResult> results = List<BluetoothDiscoveryResult>();
  bool isDiscovering;
  _DiscoveryPage();
  final BluetoothService _bluetoothService = locator<BluetoothService>();


  @override
  void initState() {
    super.initState();
    
    isDiscovering = false;
    _initStateAsync();
  }

  Future<void> _initStateAsync() async {   

      if(await _bluetoothService.isBluetoothEnabled){
        isDiscovering = true;
        try{
          _startDiscovery();
        }
        on Exception catch (exception){}
        catch (error){

        }
      }
      else
      _bluetoothService.enableBluetooth((){
        
        isDiscovering = true;
          _restartDiscovery();
      },
      (){
        Navigator.pop(context);
      }
      );   
    
  }
  void _restartDiscovery() {
    setState(() {
      results.clear();
      isDiscovering = true;
    });
    _startDiscovery();
  }

  void _startDiscovery(){
    _bluetoothService.startDiscovering((r){
      setState(() { 
        bool check = true;
        for(int i = 0 ; i < results.length ; i++){
            if(results[i].device.address == r.device.address) check = false;
        } 
          if(check == true) results.add(r); });
    });

    _bluetoothService.onDiscoveryDone((){setState(() { isDiscovering = false; });});

  }
  Future<void> _pairWithDevice(BluetoothDiscoveryResult result) async{ 
    
    _bluetoothService.pairWithDevice(result, 
    //Already bonded
    (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()));}, 
    //error
    (ex){showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error occured while bonding'),
              content: Text("${ex.toString()}"),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("Close"),
                  onPressed: () {
                    Navigator.pushNamed(context, "/connect");
                  },
                ),
              ],
            );
          },
        );});
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    _bluetoothService.cancelDiscoveryStreamSubscription();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
      
     return Scaffold(
            appBar: AppBar(
              title: isDiscovering ? Text('Discovering') : Text('Connect'),
              actions: <Widget>[
                (
                  isDiscovering ?
                    FittedBox(child: Container(
                      margin: new EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                    ))
                  :
                    IconButton(
                      icon: Icon(Icons.replay),
                      onPressed: _restartDiscovery
                    )
                )
              ],
            ),
            body: Stack(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  
                  children: <Widget>[
                    Container(
                      child:Image(image: AssetImage("lib/images/connect_illustration.png"), height: 160),
                      padding: EdgeInsets.all(16.0),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 240.0),
                  
                  child:ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (BuildContext context, index) {
                      BluetoothDiscoveryResult result = results[index];
                      return BluetoothDeviceListEntry(
                        device: result.device,
                        rssi: result.rssi,
                        background: Color.fromRGBO(0,0,0,0.04),
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(                                  
                                  content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[                                        
                                      SpinKitDoubleBounce(
                                        color: Theme.of(context).primaryColor,
                                        size: 120.0,                                        
                                      ),                                      
                                      Text('Pairing with ${result.device.name}'),
                                    ],
                                  ),
                                );
                              },
                            );
                          _pairWithDevice(result);
                        },                        
                      );
                    },
                  ),
                ),
              ],
              
            ),
            
     );
  }
}