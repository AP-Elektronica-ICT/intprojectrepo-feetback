import 'package:flutter/material.dart';
import 'package:feetback/widgets/feetback_app_bar.dart';

import 'package:feetback/services/service_locator.dart';
import 'package:feetback/services/settings_service.dart';

import 'package:feetback/models/option.dart';
// import 'package:flutter/rendering.dart';

class OptionList extends StatefulWidget {
  final Option option;

  final void Function(String select, String value) onSelect;

  OptionList({Key key, @required this.option, @required this.onSelect})
      : super(key: key);

  @override
  _OptionListState createState() => _OptionListState();
}

class _OptionListState extends State<OptionList> {
  final SettingsService _settingService = locator<SettingsService>();
  List<String> _notifications = ["true"];
  String _selected = "Metric";
  String language = "en";
  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  Future<void> asyncInit() async {
    List<String> temp = await _settingService.getNotifications;
    bool unit = await _settingService.isMetric;
    String lang = await _settingService.getLang;
    setState(() {
      _notifications = temp;
      if (unit == true)
        _selected = "Metric";
      else
        _selected = "Imperial";
      language = lang;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () => handlePop(),
        child: Scaffold(
            appBar: FeetbackAppBar(
              title: Text(widget.option.title),
              height: 92,
              contentAlignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 16, right: 16),
              automaticallyImplyLeading: false,
            ),
            body: contentHandler()));
  }
  Future<bool> handlePop() {
    Navigator.pushNamed(context, "/");
    setState(() {
      
    });
  }
  Widget contentHandler() {
    switch (widget.option.type) {
      case "tick":
        return myTickList();
        break;
      case "route":
        return goToRoute();
        break;
      case "switch":
        return mySwitchList();
        break;
      default:
        return myRadioList();
    }
  }

  String convertToWord(String myVar) {
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
    return temp;
  }

  Widget goToRoute() {
    Navigator.pushNamed(context, widget.option.optionTiles[0]);
  }

  Widget mySwitchList() {
    // _settingService.getNot();
    return ListView.separated(
        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 20),
        itemCount: widget.option.optionTiles.length,
        itemBuilder: (context, int idx) {
          return SwitchListTile(
              title: Text(widget.option.optionTiles[idx]),
              activeColor: Theme.of(context).accentColor,
              value: _notifications[idx] == "true",
              onChanged: (value) {
                _settingService.setNotifications([value.toString()]);
                _settingService.getNot();
                print(value);
                setState(() {
                  _notifications[idx] = value ? "true":"false";
                });
              });

          // ListTile(
          //   title: Text(widget.option.optionTiles[idx]),
          //   trailing: Switch(
          //     value: testje,
          //     activeColor: Colors.white,
          //     activeTrackColor: Theme.of(context).accentColor,
          //     inactiveThumbColor: Theme.of(context).primaryColor,
          //     onChanged: (bool value) {
          //       setState(() {
          //         testje = value;
          //       });
          //     }),
          // );
        },
        separatorBuilder: (context, int index) => const Divider());
  }

  Widget myRadioList() {
    return ListView.separated(
        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 8),
        itemCount: widget.option.optionTiles.length,
        itemBuilder: (context, int idx) {
          return RadioListTile(
            title: Text(widget.option.optionTiles[idx]),
              value: widget.option.optionTiles[idx],
              groupValue: _selected,
              controlAffinity: ListTileControlAffinity.trailing,
              onChanged: (String value) {
                setState(() {
                  _selected = value;
                });
                _settingService.setUnit(value == "Metric");
                Navigator.pushNamed(context, "/");
              },
            );
            
          //   Radio(
          //       value: widget.option.optionTiles[idx],
          //       groupValue: _selected,

          //       onChanged: (String value) {
          //         setState(() {
          //           _selected = value;
          //         });
          //         print("$_selected current selected");
          //         _settingService.setUnit(value == "Metric");
          //         Navigator.pushNamed(context, "/");
          //         // Navigator.pop(context, true);
          //       }),
          // );
        },
        separatorBuilder: (context, int index) => const Divider());
  }

  Widget myTickIcon(String _sel, String _cur) {
    if (_sel == _cur)
      return IconTheme(
          data: IconThemeData(color: Theme.of(context).accentColor),
          child: Icon(Icons.check));
    return Text("");
  }

  Widget myTickList() {
    final SettingsService _settingService = locator<SettingsService>();
    return ListView.separated(
        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 8),
        itemCount: widget.option.optionTiles.length,
        itemBuilder: (context, int idx) {
          return ListTile(
              title: Text(convertToWord(widget.option.optionTiles[idx])),
              trailing: IconTheme(
                  data: IconThemeData(color: Theme.of(context).accentColor),
                  child: myTickIcon(language, widget.option.optionTiles[idx])),
              onTap: () => {
                    _settingService.setLang(widget.option.optionTiles[idx]),
                    Navigator.pushNamed(context, "/"),
                    setState(() {
                      language = widget.option.optionTiles[idx];
                    })
                  });
        },
        separatorBuilder: (context, int index) => const Divider());
  }
}
