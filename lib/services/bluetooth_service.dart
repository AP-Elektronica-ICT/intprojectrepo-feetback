import 'package:flutter/widgets.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class Session {
  // singleton
  static final Session _singleton = Session._internal();
  factory Session() => _singleton;
  Session._internal();
  static Session get shared => _singleton;

  BluetoothDevice device;
  bool streamActive = false;
  bool isConnected = false;
  bool isBluetoothEnabled = false;
  BluetoothConnection connection;

  Future<bool> checkBluetoothAdapter(State state) async{   
      Session.shared.isBluetoothEnabled =  await FlutterBluetoothSerial.instance.isEnabled;
      state.setState((){});
      return await FlutterBluetoothSerial.instance.isEnabled;
      
  }

  Future<void> enableBluetooth() async {                   
    await FlutterBluetoothSerial.instance.requestEnable();
    if(await FlutterBluetoothSerial.instance.isEnabled)Session.shared.isBluetoothEnabled = true;   
    
  }

  connect(BluetoothDevice _device) => {
    BluetoothConnection.toAddress(Session.shared.device.address).then((_connection) {
          print('Connected to the device');
          connection = _connection;
          device = _device;
          isConnected = true;
          return true;
        }).catchError((error) {
          print('Cannot connect, exception occured');
          print(error);
          return false;
        })
  };
}

