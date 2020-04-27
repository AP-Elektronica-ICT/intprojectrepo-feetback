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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: FeetbackAppBar(
          title: Text(widget.option.title),
          height: 92,
          contentAlignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 16, right: 16),
          automaticallyImplyLeading: false,
        ),
        body: contentHandler(context, widget.option, widget.onSelect));
  }
}

Widget contentHandler(
    BuildContext context, Option opt, Function(String, String) onSelect) {
  switch (opt.type) {
    case "tick":
      return myTickList(opt);
      break;
    case "route":
      return goToRoute(context, opt);
      break;
    default:
      return myRadioList(context, opt, onSelect);
  }
}

Widget myRadioList(
    BuildContext context, Option opt, Function(String, String) onSelect) {
  String _selected = opt.current;
  final SettingsService _settingsService = locator<SettingsService>();
  return ListView.separated(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 8),
      itemCount: opt.optionTiles.length,
      itemBuilder: (context, int idx) {
        return ListTile(
          title: Text(opt.optionTiles[idx]),
          trailing: Radio(
              value: opt.optionTiles[idx],
              groupValue: _selected,
              onChanged: (String value) {
                onSelect(_selected, value);
                print("$_selected current selected");
                _settingsService.setUnit(value == "Metric");
                Navigator.pop(context,true);
              }),
        );
      },
      separatorBuilder: (context, int index) => const Divider());
}

Widget myTickIcon(String _sel, String _cur, BuildContext ctx) {
  if (_sel == _cur)
    return IconTheme(
        data: IconThemeData(color: Theme.of(ctx).accentColor),
        child: Icon(Icons.check));
  return Text("");
}

Widget myTickList(Option opt) {
  String _selected = opt.current;
  final SettingsService _settingService = locator<SettingsService>();
  return ListView.separated(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 8),
      itemCount: opt.optionTiles.length,
      itemBuilder: (context, int idx) {
        return ListTile(
            title: Text(convertToWord(opt.optionTiles[idx])),
            trailing: IconTheme(
                data: IconThemeData(color: Theme.of(context).accentColor),
                child: myTickIcon(_selected, opt.optionTiles[idx], context)),
            onTap: () => {
                  _settingService.setLang(opt.optionTiles[idx]),
                  print("Da werkt"),
                  (context as Element).reassemble()
                });
      },
      separatorBuilder: (context, int index) => const Divider());
}

Widget goToRoute(BuildContext context, Option opt) {
  Navigator.pushNamed(context, opt.optionTiles[0]);
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
