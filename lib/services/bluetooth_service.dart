import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothService {

  FlutterBluetoothSerial _bluetoothSerial = FlutterBluetoothSerial.instance;

  BluetoothDevice device;
  bool streamActive = false;
  bool isConnected = false;
  BluetoothConnection connection;
  Future<bool> get isBluetoothEnabled async => await _bluetoothSerial.isEnabled;
  Future<bool> get isBluetoothExists async => await _bluetoothSerial.isAvailable;

  ///StreamSubscription used to discover BluetoothDiscoveryResults
  ///
  ///Make sure you first call the function startListeningForBluetoothDiscoveryResult(). Otherwise this will be null
  StreamSubscription<BluetoothDiscoveryResult> discoveryStreamSubscription;

  ///StreamSubscription used to listen to incoming data from the Bluetooth Module
  ///
  ///Make sure you first call the function listenToDevice(). Otherwise this will be null
  StreamSubscription<Uint8List> connectionStreamSubscription;

  Stream<Uint8List> connectionStream;
  
  

  ///Initialize discoveryStream that listens to bluetooth discovery result.
  ///Use dicoveryStream.listen((BluetoothDiscoveryResult){ do something with BluetoothDiscoveryResult});
  ///Check if there is an existing Bluetoothadapter first and if it is enabled
  void startListeningForBluetoothDiscoveryResults(Function onResult(BluetoothDiscoveryResult r)){
    discoveryStreamSubscription = _bluetoothSerial.startDiscovery().asBroadcastStream().listen((result) {onResult(result);});
  }

  

  ///
  void cancelDiscoveryStreamSubscription(){
    discoveryStreamSubscription.cancel();
  }


  ///closes the current connectionStreamSubscription that listens to the bluetooth module.
  void cancelConnectionStreamSubsciption(){
    connectionStreamSubscription.cancel();
  }

  ///asks for activating Bluetooth.
  ///Wil call given function when bluetooth is enabled
  Future<void> enableBluetooth(Function ifBluetoothIsTurnedOn) async{
    await FlutterBluetoothSerial.instance.requestEnable();
    if(await FlutterBluetoothSerial.instance.isEnabled){
      ifBluetoothIsTurnedOn();
    }

  }

  ///Creates a StreamSubsription that will call the given function when data is recieved
  void listenToDevice(Function onRecievingData){
    connectionStreamSubscription = connectionStream.listen(onRecievingData);
    
  }

  ///sendMessage to the current connection.
  ///This will only send data if a connection is available
  Future<void> sendMessage(String message) async {
    if(connection.isConnected){
      connection.output.add(utf8.encode(message));
      connection.output.allSent;
      print("sended");
    }

    
  }

  ///The app will pair and connect to the device given as a BluetoothDiscoveryResult.
  ///onAlreadyBonded will be called when the device is already paired with the device
  ///onNotBonded will be called when the device is not already bonden. The function wil pair with the device before calling this function
  ///onError will be called if there where any errors
  ///
  ///This function will also automatically connect with the given device!
  Future<void> pairWithDevice(BluetoothDiscoveryResult result,Function onAlreadyBonded,Function onNotBonded,Function onError(String ex)) async{
    try{
      bool bonded;
      if(result.device.isBonded){
        onAlreadyBonded();
        connect(result.device);
        setupConnectionStream();
      }
      else{
        print('Bonding with ${result.device.address}...');
        bonded = await FlutterBluetoothSerial.instance.bondDeviceAtAddress(result.device.address);
        print('Bonding with ${result.device.address} has ${bonded ? 'succed' : 'failed'}.');
        if(bonded){
          onNotBonded();
        }
        connect(result.device);
        setupConnectionStream();                              
      }      
    }
    catch(ex){
        onError(ex);
    }
  }

  Future<void> setupConnectionStream() async{
    connectionStream = connection.input.asBroadcastStream();
  }

  ///Connects with a given BluetoothDevice
  connect(BluetoothDevice _device) => {
    BluetoothConnection.toAddress(_device.address).then((_connection) {
          print('Connected to the device');
          connection = _connection;
          device = _device;
          connectionStream = connection.input.asBroadcastStream();
          isConnected = true;          
          return true;
        }).catchError((error) {
          print('Cannot connect, exception occured');
          print(error);
          return false;
        })
  };
}

