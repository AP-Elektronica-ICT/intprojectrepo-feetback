import 'package:flutter/material.dart';

class SettingOptions extends StatefulWidget {
  @override
  _SettingOptionsState createState() => _SettingOptionsState();
}

class _SettingOptionsState extends State<SettingOptions> {
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
        trailing: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Text("Metric"),
            IconTheme(
              data: IconThemeData(
                color: Theme.of(context).primaryColor,
              ), 
              child: 
                Icon(Icons.chevron_right))
          ],
        ),
        onTap: () => print('Unit'),
      ),

      ListTile(
        title: Text(
          'Language',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Text("Dutch"),
            IconTheme(
              data: IconThemeData(
                color: Theme.of(context).primaryColor,
              ), 
              child: 
                Icon(Icons.chevron_right))
          ],
        ),
        onTap: () => print('Language'),
      ),

      ListTile(
        title: Text(
          'Connected mat',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Text("Not Connected", style: TextStyle(fontStyle: FontStyle.italic),),
            IconTheme(
              data: IconThemeData(
                color: Theme.of(context).primaryColor,
              ), 
              child: 
                Icon(Icons.chevron_right))
          ],
        ),
        onTap: () => print('Connected mat'),
      ),

    ]).toList(),
  );
}
