import 'dart:core';
import 'package:feetback/models/jump.dart';
import 'package:feetback/screens/detailedJumpPage/jump_detailed.dart';
import 'package:flutter/material.dart';

enum SequenceState { date, height, dayHeight }

class JumpHistoryPage extends StatefulWidget {
  @override
  _JumpHistoryPageState createState() => _JumpHistoryPageState();
}

class _JumpHistoryPageState extends State<JumpHistoryPage> {
  final List<Jump> jumps = new List();
  SequenceState _selection = SequenceState.date;

  _JumpHistoryPageState() {
    jumps.add(Jump(DateTime.utc(2019, 9, 14), 50.3, 3000));
    jumps.add(Jump(DateTime.utc(2019, 9, 14), 54.71, 3000));
    jumps.add(Jump(DateTime.utc(2019, 9, 14), 53.200, 3000));
    jumps.add(Jump(DateTime.utc(2019, 9, 14), 49.32, 3000));
    jumps.add(Jump(DateTime.utc(2018, 10, 29), 60.05, 3000));
    jumps.add(Jump(DateTime.utc(2019, 1, 1), 50.3, 3000));
    jumps.add(Jump(DateTime.utc(2017, 2, 3), 54.71, 3000));
    jumps.add(Jump(DateTime.utc(2019, 9, 14), 53.100, 3000));
    jumps.add(Jump(DateTime.utc(2019, 2, 2), 49.32, 3000));
    jumps.add(Jump(DateTime.utc(2020, 4, 14), 60.05, 3000));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Jump history"),
          actions: <Widget>[
            PopupMenuButton<SequenceState>(
              onSelected: (SequenceState result) {
                setState(() {
                  _selection = result;
                });
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<SequenceState>>[
                const PopupMenuItem<SequenceState>(
                  value: SequenceState.date,
                  child: Text('By date'),
                ),
                const PopupMenuItem<SequenceState>(
                  value: SequenceState.height,
                  child: Text('By height'),
                ),
                const PopupMenuItem<SequenceState>(
                  value: SequenceState.dayHeight,
                  child: Text('By day and height'),
                ),
              ], icon:  Icon(Icons.sort, color: Colors.white,)
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
            Expanded(child: _buildList()),
          ],
        ));
  }

  Widget _graph() {
    return Image.asset('assets/chart.png');
  }

  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(0.0),
        itemCount: jumps.length,
        itemBuilder: (context, item) {
          if(_selection == SequenceState.date){
            jumps.sort((b, a) => a.date.compareTo(b.date));
          }
          else if(_selection == SequenceState.height){
            jumps.sort((b, a) => a.height.compareTo(b.height));
          }
          else if(_selection == SequenceState.dayHeight){
            jumps.sort((b, a) => a.height.compareTo(b.height));
            jumps.sort((b, a) => a.date.day.compareTo(b.date.day));
            jumps.sort((b, a) => a.date.month.compareTo(b.date.month));
            jumps.sort((b, a) => a.date.year.compareTo(b.date.year));
          }
          return _buildRow(context, jumps[item], item);
            
        });
  }

  Widget _buildRow(BuildContext context, Jump jump, int item) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 0.04),
          //color: Colors.red,
          borderRadius: BorderRadius.circular(8.0)),
      margin: new EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      child: ListTile(
          leading: FlutterLogo(size: 48.0),
          subtitle: Text(jump.date.day.toString() +
              "/" +
              jump.date.month.toString() +
              "/" +
              jump.date.year.toString()),
          title: Text(jump.height.toString() + " cm",
              style: TextStyle(fontWeight: FontWeight.bold)),
          onTap: () {
            pushJump(context, item);
          }),
    );
  }

  void pushJump(BuildContext context, int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => JumpDetailPage(jump: jumps[index]),
        ));
  }
}
