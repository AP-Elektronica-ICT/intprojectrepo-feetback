import 'package:flutter/material.dart';

import 'package:feetback/models/option.dart';

import 'package:feetback/services/service_locator.dart';
import 'package:feetback/services/settings_service.dart';

import 'package:feetback/screens/settingsPage/widget/optionList.dart';

class SettingOptions extends StatefulWidget {
  @override
  _SettingOptionsState createState() => _SettingOptionsState();
}

class _SettingOptionsState extends State<SettingOptions> {
  List<Option> options = new List<Option>();
  final _settingService = locator<SettingsService>();
  
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
        await _settingService.getDevice ?? "Not conneted", ["/connect"]));
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
    if (temp == "Not Connected")
      fontSt = FontStyle.italic;
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
          onSelect: 
        (String selected, String value) {
          print("$value");
                      setState(() => selected = value);
                      
                      print("Test : $selected");
                    },
        ),
      )
    );
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
            pushSetting(context, options[idx]),
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
// ListTile(

//         title: Text(
//           'Unit',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         trailing: Wrap(
//           crossAxisAlignment: WrapCrossAlignment.center,
//           children: <Widget>[
//             Text("Metric"),
//             IconTheme(
//               data: IconThemeData(
//                 color: Theme.of(context).primaryColor,
//               ),
//               child:
//                 Icon(Icons.chevron_right))
//           ],
//         ),
//         onTap: () => print('Unit'),
//       ),
