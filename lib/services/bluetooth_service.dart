import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:feetback/services/service_locator.dart';
import 'package:feetback/services/settings_service.dart';

class BluetoothService {

  FlutterBluetoothSerial _bluetoothSerial = FlutterBluetoothSerial.instance;
  final SettingsService _settingsService = locator<SettingsService>();

  //BluetoothDevice device;
  String nameOfDevice;
  String macOfDevice;
  //bool streamActive = false;
  bool get isConnected => connection != null ? connection.isConnected : false;
  BluetoothConnection connection;
  Future<bool> get isBluetoothEnabled async => await _bluetoothSerial.isEnabled;
  Future<bool> get isBluetoothExists async => await _bluetoothSerial.isAvailable;
  //Future<bool> get isBluetoothConnected async => device.isConnected;
  
  //Stream<BluetoothDiscoveryResult> discoveryStream => _bluetoothSerial.startDiscovery();
  ///StreamSubscription used to discover BluetoothDiscoveryResults
  ///
  ///Make sure you first call the function startListeningForBluetoothDiscoveryResult(). Otherwise this will be null
  StreamSubscription<BluetoothDiscoveryResult> _discoveryStreamSubscription;

  ///StreamSubscription used to listen to incoming data from the Bluetooth Module
  ///
  ///Make sure you first call the function listenToDevice(). Otherwise this will be null
  StreamSubscription<Uint8List> _connectionStreamSubscription;

  Stream<Uint8List> _connectionStream;
  Stream<BluetoothDiscoveryResult> _discoveryStream; 

  Future<void> saveDevice(BluetoothDevice device) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('macOfDevice', device.address);  
    await prefs.setString('nameOfDevice', device.name);
    _settingsService.setDevice(device.name);
    print(prefs.getString("MAC_Bluetooth"));
  }

  Future<String> getSavedDeviceMAC() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("macOfDevice");
  }

  Future<String> getSavedDeviceName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("nameOfDevice");
  }

  
   

  ///Initialize discoveryStream that listens to bluetooth discovery result.
  ///Use dicoveryStream.listen((BluetoothDiscoveryResult){ do something with BluetoothDiscoveryResult});
  ///Check if there is an existing Bluetoothadapter first and if it is enabled
  void startDiscovering(Function onResult(BluetoothDiscoveryResult r)){
    _discoveryStream = _bluetoothSerial.startDiscovery();
    _discoveryStreamSubscription = _discoveryStream.listen((result) {onResult(result);});
  }

  ///Excecutes the given function when the discovery is done
  void onDiscoveryDone(Function onDone){
    _discoveryStreamSubscription.onDone(onDone);
  }

  ///Executes the given function when there is an error while discovering
  void onDiscoveryError(Function onError){
    _discoveryStreamSubscription.onError(onError);
  }

  ///Cancel the current discoveryStreamSubsciption.
  void cancelDiscoveryStreamSubscription(){
    _discoveryStreamSubscription.cancel();
  }

  void disconnect(){
    if(isConnected){
      connection.dispose();
      toast("Disconnected");
      _settingsService.setDevice(null);
    }
  }

  ///asks for activating Bluetooth.
  ///Wil call given function when bluetooth is enabled
  Future<void> enableBluetooth(Function ifBluetoothIsTurnedOn, Function ifBluetoothIsNotTurnedOn) async{
    await _bluetoothSerial.requestEnable();
    if(await _bluetoothSerial.isEnabled){
      ifBluetoothIsTurnedOn();
      toast("Bluetooth succesfully turned on");
    }
    else{
      ifBluetoothIsNotTurnedOn();
      toast("Bluetooth not turned on");
    }
  }

  ///Sets up a connection stream.
  Future<void> setupConnectionStream() async{    
    _connectionStream = connection.input.asBroadcastStream();    
  }

  ///Creates a StreamSubsription that will call the given function when data is recieved.
  void startListening(Function onRecievingData){
    _connectionStreamSubscription = _connectionStream.listen(onRecievingData);    
  }

  ///Executes the given function when listening is done.
  void onListeningDone(Function onDone){
    _connectionStreamSubscription.onDone(onDone);
  }

  ///Executes the given function when there is an error while listening.
  void onListeningError(Function onError){
    _connectionStreamSubscription.onError(onError);
  }

  ///closes the current connectionStreamSubscription that listens to the bluetooth module.
  void cancelConnectionStreamSubsciption(){
    _connectionStreamSubscription.cancel();
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
  Future<void> pairWithDevice(BluetoothDiscoveryResult result,Function onBonded,Function onError(String ex)) async{
    try{
      bool bonded;
      if(result.device.isBonded){
        if(await connect(result.device.address)){
          toast("succesfully connected to "+ result.device.name);
           onBonded();
        }
       
        saveDevice(result.device);
        
      }
      else{
        print('Bonding with ${result.device.address}...');
        bonded = await _bluetoothSerial.bondDeviceAtAddress(result.device.address);
        print('Bonding with ${result.device.address} has ${bonded ? 'succed' : 'failed'}.');
         
        if(bonded){
          if(await connect(result.device.address)){
            toast("succesfully connected to "+ result.device.name);
             onBonded();
          }
        }
        else{
          onError("Unknown error. Make sure you entered the correct PIN.");
        }                             
      }      
    }
    catch(ex){
      toast("Error while pairing");
      onError(ex.toString());
    }
  } 

  void toast(String message) async {
    Fluttertoast.showToast(
              msg: message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0
          );
  }

  Future<bool> connect(String mac) async {
    try {
      connection = await BluetoothConnection.toAddress(mac);
      
      setupConnectionStream();
     // return connection.isConnected;
    } catch (e) {
      print('Error connecting to device, the following exception was thrown.');
      print(e);
      //return false;
    }
    return isConnected;
    
    
  }

  
  void connectWithSavedDevice(Function onConnected) async{
    String mac = await getSavedDeviceMAC(); 
    print('Try connecting with saved device: $mac');
    if(isConnected == false) if (await connect(mac)) {
      print('Connected to saved device: $mac');
      createBluetoothDevice();
      onConnected();
    } else {
      print('Not connected to saved deice: $mac');
    }
  }

  void createBluetoothDevice()async{
    nameOfDevice = await getSavedDeviceName();
    macOfDevice = await getSavedDeviceMAC();
    _settingsService.setDevice(nameOfDevice);
    toast("Succesfully connected with " +nameOfDevice+".");
  }
  
}

