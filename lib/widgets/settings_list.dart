import 'package:flutter/material.dart';
class SettingsList extends StatefulWidget {
  /// The list of the settings to display.
  final List<String> settingsList;
  final String initialSetting;
  final Function(String) onSettingChanged;

  SettingsList({
    @required this.initialSetting,
    @required this.settingsList,
    this.onSettingChanged
  }) : assert(initialSetting != null && settingsList.contains(initialSetting)),
       assert(settingsList != null && settingsList.length > 0);

  @override
  _SettingsListState createState() => _SettingsListState();
}

class _SettingsListState extends State<SettingsList> {
  // final List<String> languages = <String>["English", "Nederlands", "Suomi"];
  // final List<String> units = <String>["Metric", "Imperial"];

  // String test = "Metric";

  String _selectedSetting;

  @override
  void initState() {
    super.initState();
    _selectedSetting = widget.initialSetting;
  }
  

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: widget.settingsList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          child: RadioListTile(
            title: Text(widget.settingsList[index]), 
            onChanged: (value) {
              setState(() {
                _selectedSetting = value;
              });
              widget.onSettingChanged(value);
            }, 
            value: widget.settingsList[index], 
            groupValue: _selectedSetting,
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}