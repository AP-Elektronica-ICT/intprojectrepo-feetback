import 'dart:core';
import 'package:feetback/models/jump.dart';
import 'package:feetback/screens/detailedJumpPage/jump_detailed.dart';
import 'package:flutter/material.dart';

enum SequenceState { date, height }

class JumpHistoryPage extends StatelessWidget {
  final List<Jump> jumps = new List();

  JumpHistoryPage() {
    jumps.add(Jump(DateTime.utc(2019, 9, 14), 50.3, 3000));
    jumps.add(Jump(DateTime.utc(2019, 10, 5), 54.71, 3000));
    jumps.add(Jump(
      DateTime.utc(2019, 12, 21),
      53.100,
      3000,
    ));
    jumps.add(Jump(DateTime.utc(2019, 10, 22), 49.32, 3000));
    jumps.add(Jump(DateTime.utc(2018, 10, 29), 60.05, 3000));
    jumps.add(Jump(DateTime.utc(2019, 1, 1), 50.3, 3000));
    jumps.add(Jump(DateTime.utc(2017, 2, 3), 54.71, 3000));
    jumps.add(Jump(DateTime.utc(2019, 6, 7), 53.100, 3000));
    jumps.add(Jump(DateTime.utc(2019, 2, 2), 49.32, 3000));
    jumps.add(Jump(DateTime.utc(2019, 4, 14), 60.05, 3000));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Jump history"),
          actions: <Widget>[
           
            /*IconButton(
              icon: Icon(Icons.sort, color: Colors.white,),
              //onPressed: ,)*/
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
          jumps.sort((b, a) => a.date.compareTo(b.date));
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
