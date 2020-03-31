import 'package:flutter/material.dart';

class SettingOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _settingView(context);
  }
}

Widget _settingView(BuildContext context) {
  return ListView(
    children: ListTile.divideTiles(context: context, tiles: [
      ListTile(
        title: Text(
          'Unit',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Row(
          children: <Widget>[
            Text("Dutch"),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
        onTap: () => print('Unit'),
      ),
      ListTile(
        title: Text(
          'Language',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Row(
          children: <Widget>[
            Text("Dutch"),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
        onTap: () => print('Language'),
      ),
      ListTile(
        title: Text(
          'Connected mat',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Row(
          children: <Widget>[
            Text("Dutch"),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
        onTap: () => print('Connected mat'),
      ),
    ]),
  );
}
