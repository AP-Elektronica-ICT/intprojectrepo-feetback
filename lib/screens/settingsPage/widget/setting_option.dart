import 'package:flutter/material.dart';

import 'package:feetback/models/option.dart';

import 'package:feetback/services/service_locator.dart';
import 'package:feetback/services/settings_service.dart';
import 'package:feetback/services/bluetooth_service.dart';

import 'package:feetback/screens/settingsPage/widget/optionList.dart';


class SettingOptions extends StatefulWidget {
  @override
  _SettingOptionsState createState() => _SettingOptionsState();
}

class _SettingOptionsState extends State<SettingOptions> {
  List<Option> options = new List<Option>();
  final _settingService = locator<SettingsService>();
  final _btService = locator<BluetoothService>();
  @override
  void initState() {
    super.initState();
    handleStartup();
  }

  void handleStartup() async {
    List<Option> _options = new List<Option>();
    _options.add(Option(
        "Units",
        "radio",
        await _settingService.isMetric ? "Metric" : "Imperial" ?? "Metric",
        ["Metric", "Imperial"]));
    _options.add(Option("Language", "tick",
        await _settingService.getLang ?? "English", ["en", "nl", "sm"]));
    _options.add(Option("Connected mat", "route",
        await _settingService.getDevice ?? "Not Connected", ["/connect"]));
    _options.add(Option("Notifications", "switch", "",  ["Notifications"]));
    setState(() {
      options = _options;
    });
  }

  Widget _currentSetting(BuildContext context, String myVar) {
    String temp;
    switch (myVar) {
      case "en":
        temp = "English";
        break;
      case "nl":
        temp = "Nederlands";
        break;
      case "sm":
        temp = "Suomi";
        break;
      default:
        temp = myVar;
    }
    FontStyle fontSt;
    if (temp == "Not Connected") fontSt = FontStyle.italic;
    return Text(
      temp,
      style: TextStyle(fontStyle: fontSt),
    );
  }

  void pushSetting(BuildContext context, Option opt) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OptionList(
            option: opt,
          
          ),
        ));
  }

  void refresh(){
    Navigator.pushNamed(context, "/");
  }

  void askToConnect() {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
              //title: new Text(""),
              content: Container(
                height: 112,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("Connect a new device"),
                      trailing: IconTheme(
                        data: IconThemeData(color: Theme.of(context).primaryColor), 
                        child: Icon(Icons.chevron_right)),
                        onTap: () => {
                          _btService.disconnect(),
                          Navigator.pushNamed(context, "/connect")
                        },
                    ),
                    ListTile(
                      title: Text("Disconnect"),
                      trailing: IconTheme(
                        data: IconThemeData(color: Theme.of(context).primaryColor), 
                        child: Icon(Icons.chevron_right)),
                        onTap: () => {
                          _btService.disconnect(),
                          _settingService.setDevice("Not Connected"),
                          // Navigator.pushNamed(context, "/setting")
                           Navigator.pop(context),
                           refresh(),
                        },
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                new FlatButton(
                    child: new Text("BACK"),
                    onPressed: () => {Navigator.of(context).pop()}),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 8),
      itemCount: options.length,
      itemBuilder: (BuildContext context, int idx) {
        return ListTile(
          title: Text(
            options[idx].title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              _currentSetting(context, options[idx].current),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: IconTheme(
                    data: IconThemeData(color: Theme.of(context).primaryColor),
                    child: Icon(Icons.chevron_right)),
              )
            ],
          ),
          onTap: () => {
            if (options[idx].optionTiles[0] == "/connect" &&
                options[idx].current != "Not Connected")
              {askToConnect()}
            else
              {pushSetting(context, options[idx])}
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
