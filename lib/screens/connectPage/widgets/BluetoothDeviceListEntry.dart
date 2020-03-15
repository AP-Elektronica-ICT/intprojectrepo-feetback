import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothDeviceListEntry extends Center {
  BluetoothDeviceListEntry({
    @required BluetoothDevice device,
    int rssi,
    GestureTapCallback onTap,
    GestureLongPressCallback onLongPress,
    Color background,
    bool enabled = true
  }) : super(
    child: Container(
      width: 311,
      height: 72,
      margin: const EdgeInsets.only(bottom: 8.0,top: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: background,
      ),
      child:ListTile(
        onTap: onTap,
        onLongPress: onLongPress,
        enabled: enabled,
        leading: Icon(Icons.devices), // @TODO . !BluetoothClass! class aware icon
        title: Text(device.name ?? "Unknown device"),
        subtitle: Text(device.address.toString()),
      ),
    ),
  );
}
