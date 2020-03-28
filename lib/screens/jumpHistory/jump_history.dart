import 'dart:core';

import 'package:feetback/screens/jumpHistory/widgets/jump_graph.dart';
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
    jumps.add(Jump(DateTime.utc(2019, 6, 5), 50.3, 3000));
    jumps.add(Jump(DateTime.utc(2019, 10, 25), 50.3, 3000));
    jumps.add(Jump(DateTime.utc(2019, 9, 14), 54.69, 3000));
    jumps.add(Jump(DateTime.utc(2019, 9, 14), 53.200, 3000));
    jumps.add(Jump(DateTime.utc(2019, 5, 14), 49.32, 3000));
    jumps.add(Jump(DateTime.utc(2018, 10, 29), 60.05, 3000));
    jumps.add(Jump(DateTime.utc(2019, 1, 1), 50.3, 3000));
    jumps.add(Jump(DateTime.utc(2017, 2, 3), 54.71, 3000));
    jumps.add(Jump(DateTime.utc(2019, 9, 14), 53.100, 3000));
    jumps.add(Jump(DateTime.utc(2019, 2, 2), 49.32, 3000));
    jumps.add(Jump(DateTime.utc(2020, 4, 14), 55.05, 3000));
    jumps.add(Jump(DateTime.utc(2020, 6, 1), 58.25, 3000));
    jumps.add(Jump(DateTime.utc(2020, 6, 20), 56.05, 3000));
    jumps.add(Jump(DateTime.utc(2020, 1, 14), 52.3, 3000));
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
            _graph(),
            Expanded(child: FeetbackList(
              currentSortState: _selection,
              jumpItems: jumps, 
              onFavorite: (Jump jump) => setState(() => jump.favorite = !jump.favorite)
              ),),
          ],
        )
    );
  }

  Widget _graph() {
    return JumpGraph(jumpItems: jumps,);
    //return Image.asset('assets/chart.png');
  }
}  