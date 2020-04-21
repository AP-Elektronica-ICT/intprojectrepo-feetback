import 'package:feetback/services/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:feetback/models/option.dart';
import 'package:feetback/services/service_locator.dart';
class SettingOptions extends StatefulWidget {

  @override
  _SettingOptionsState createState() => _SettingOptionsState();
}

class _SettingOptionsState extends State<SettingOptions> {
  List<Option> options = new List<Option>();
  final _settingService = locator<SettingsService>();
  Option test = new Option(_title, _type, _current) {
    this.
  }
  @override
  void initState() {
    super.initState();
    options.add(Option("Unit", "radio", _settingService.isMetric.toString()){
       
    });
  }
  @override
  Widget build(BuildContext context) {
    return 
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