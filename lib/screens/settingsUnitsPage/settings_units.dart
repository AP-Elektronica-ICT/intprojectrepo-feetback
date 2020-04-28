import 'package:flutter/material.dart';

import 'package:feetback/services/service_locator.dart';
import 'package:feetback/services/settings_service.dart';

import 'package:feetback/widgets/settings_list.dart';


class SettingsUnitsPage extends StatefulWidget {
  @override
  _SettingsUnitsPageState createState() => _SettingsUnitsPageState();
}

class _SettingsUnitsPageState extends State<SettingsUnitsPage> {
  final SettingsService _settingsService = locator<SettingsService>();

  List<String> _units = <String>['Metric', 'Imperial'];
  String _initialUnit;

  @override
  void initState() {
    super.initState();
    _initialUnit = _units[0];
    initStateAsync();
  }

  void initStateAsync() async {
    String settingsUnit = await _settingsService.isMetric ? 'Metric' : 'Imperial';
    setState(() {
      _initialUnit = settingsUnit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      initialSetting: _initialUnit,
      settingsList: _units,
      onSettingChanged: (newSetting) async {
        _settingsService.setUnit(newSetting == 'Metric');
      },
    );
  }
}