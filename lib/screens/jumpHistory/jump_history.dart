import 'dart:core';

import 'package:flutter/material.dart';

import 'package:feetback/models/jump.dart';
import 'package:feetback/widgets/feetback_app_bar.dart';
import 'package:feetback/screens/jumpHistory/widgets/feetback_list.dart';
import 'package:feetback/screens/jumpHistory/enums/sort_state.dart';
import 'package:feetback/screens/jumpHistory/widgets/jump_history_popup.dart';



class JumpHistoryPage extends StatefulWidget {
  @override
  _JumpHistoryPageState createState() => _JumpHistoryPageState();
}

class _JumpHistoryPageState extends State<JumpHistoryPage> {
  final List<Jump> jumps = new List();
  SortState _selection = SortState.date;

  _JumpHistoryPageState() {
    jumps.add(Jump(DateTime.utc(2019, 9, 14), 50.3, 3000));
    jumps.add(Jump(DateTime.utc(2019, 9, 14), 54.69, 3000));
    jumps.add(Jump(DateTime.utc(2019, 9, 14), 53.200, 3000));
    jumps.add(Jump(DateTime.utc(2019, 9, 14), 49.32, 3000));
    jumps.add(Jump(DateTime.utc(2018, 10, 29), 60.05, 3000));
    jumps.add(Jump(DateTime.utc(2019, 1, 1), 50.3, 3000));
    jumps.add(Jump(DateTime.utc(2017, 2, 3), 54.71, 3000));
    jumps.add(Jump(DateTime.utc(2019, 9, 14), 53.100, 3000));
    jumps.add(Jump(DateTime.utc(2019, 2, 2), 49.32, 3000));
    jumps.add(Jump(DateTime.utc(2020, 4, 14), 40.05, 3000));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: FeetbackAppBar(
          title: Text("Jump history"),
          height: 92,
          contentAlignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 16, right: 16),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            JumpHistoryPopup(
              onSelected: (SortState selected) => {
                this.setState(() {
                  _selection = selected;
                })
              }
            )
          ],
        ),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                margin:
                    new EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),
                child: _graph()),
            Expanded(child: FeetbackList(currentSortState: _selection, jumpItems: jumps),),
          ],
        )
    );
  }

  Widget _graph() {
    return Image.asset('assets/chart.png');
  }
}