import 'dart:async';
import 'package:feetback/screens/homePage/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'widgets/BluetoothDeviceListEntry.dart';
import '../../services/bluetooth_service.dart';

class DiscoveryPage extends StatefulWidget {
  /// If true, discovery starts on page start, otherwise user must press action button.
  final bool start;

  const DiscoveryPage({this.start = true});

  @override
  _DiscoveryPage createState() => new _DiscoveryPage();
}

class _DiscoveryPage extends State<DiscoveryPage> {
  StreamSubscription<BluetoothDiscoveryResult> _streamSubscription;
  List<BluetoothDiscoveryResult> results = List<BluetoothDiscoveryResult>();
  bool isDiscovering;
  _DiscoveryPage();

  @override
  void initState() {
    super.initState();
    _startApp();
  }

  Future<void> _startApp() async {
    await Session.shared.checkBluetoothAdapter(this);
    isDiscovering = widget.start;
    if(Session.shared.isBluetoothEnabled){
      isDiscovering = true;      
      if (isDiscovering) {
        _startDiscovery();
      }
    }
    else{
      isDiscovering = false;
    }
  }

  void _restartDiscovery() {
    setState(() {
      results.clear();
      isDiscovering = true;
    });
    _startDiscovery();
  }

  void _startDiscovery() {
    _streamSubscription = FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        bool check = true;
        for(int i = 0 ; i < results.length ; i++){
            if(results[i].device.address == r.device.address) check = false;
        } 
          if(check == true) results.add(r);         
        });
    });

    _streamSubscription.onDone(() {
      setState(() { isDiscovering = false; });
    });
  }

  Future<void> _enableBluetooth() async {                   
    await Session.shared.enableBluetooth();
    if(Session.shared.isBluetoothEnabled) _restartDiscovery();
    
                
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    _streamSubscription?.cancel();

    super.dispose();
  }

 
  @override
  Widget build(BuildContext context) {
     return Scaffold(
            appBar: AppBar(
              title: isDiscovering ? Text('Discovering devices') : Text('Connect'),
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
            body:Stack(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  
                  children: <Widget>[
                    Container(
                      child:Image(image: AssetImage("assets/connect_illustration.png"), height: 160),
                      padding: EdgeInsets.all(16.0),
                    ),
                  ],
                ),

                Session.shared.isBluetoothEnabled == false ? 
                Container(
                  margin: const EdgeInsets.only(top: 240.0),
                  
                  child:Center(
                    child : MaterialButton(
                      child: Text("Enable Bluetooth"),
                      onPressed:(){_enableBluetooth();},
                    ),              
                    ),
                  )
                :
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
                                  
                                  //title: Text('Pairing with ${result.device.name}'),
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
                          try {
                            bool bonded = false;
                            if (result.device.isBonded) {
                                Session.shared.connect(result.device);
                                Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomePage()));
                              
                            }
                            else {
                              print('Bonding with ${result.device.address}...');
                              bonded = await FlutterBluetoothSerial.instance.bondDeviceAtAddress(result.device.address);
                              print('Bonding with ${result.device.address} has ${bonded ? 'succed' : 'failed'}.');
                              if(bonded){
                                Session.shared.connect(result.device);
                                Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomePage()));
                              }
                              
                            }
                            setState(() {
                              results[results.indexOf(result)] = BluetoothDiscoveryResult(
                                device: BluetoothDevice(
                                  name: result.device.name ?? '',
                                  address: result.device.address,
                                  type: result.device.type,
                                  bondState: bonded ? BluetoothBondState.bonded : BluetoothBondState.none,
                                ), 
                                rssi: result.rssi
                              );
                            });
                          }
                          catch (ex) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Error occured while bonding'),
                                  content: Text("${ex.toString()}"),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: new Text("Close"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
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
