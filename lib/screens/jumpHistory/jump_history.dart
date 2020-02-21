import 'dart:core';
import 'package:feetback/models/jump.dart';
import 'package:feetback/screens/detailedJumpPage/jump_detailed.dart';
import 'package:flutter/material.dart';

class JumpHistoryPage extends StatelessWidget {

  final List<Jump> jumps = new List();

JumpHistoryPage(){
    jumps.add(Jump(DateTime.utc(2019, 9, 14), 50.3, 3000, 913.66275));
    jumps.add(Jump(DateTime.utc(2019, 10, 5), 54.71, 3000, 913.66275));
    jumps.add(Jump(DateTime.utc(2019, 12, 21), 53.100, 3000, 913.66275));
    jumps.add(Jump(DateTime.utc(2019, 10, 22), 49.32, 3000, 913.66275));
    jumps.add(Jump(DateTime.utc(2018, 10, 29), 60.05, 3000, 913.66275));
    jumps.add(Jump(DateTime.utc(2019, 1, 1), 50.3, 3000, 913.66275));
    jumps.add(Jump(DateTime.utc(2017, 2, 3), 54.71, 3000, 913.66275));
    jumps.add(Jump(DateTime.utc(2019, 6, 7), 53.100, 3000, 913.66275));
    jumps.add(Jump(DateTime.utc(2019, 2, 2), 49.32, 3000, 913.66275));
    jumps.add(Jump(DateTime.utc(2019, 4, 14), 60.05, 3000, 913.66275));
}

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text("Jump history")),
        body: _buildList()
        );
  }

  Widget _buildList(){
    return ListView.builder(
      padding: const EdgeInsets.all(0.0),
      itemCount: jumps.length,
      itemBuilder: (context, item){
        jumps.sort((b, a) => a.date.compareTo(b.date));
          return _buildRow(context, jumps[item], item);
      }
    );
  }

  Widget _buildRow(BuildContext context, Jump jump, int item){
    return ListTile(
      subtitle: Text(jump.date.day.toString() + "/" +
                     jump.date.month.toString() + "/" +
                     jump.date.year.toString()), 
      title: Text(jump.height.toString() + " cm", style: TextStyle(fontWeight: FontWeight.bold)),
      trailing: Icon(
         Icons.arrow_right,
          //color: Theme.of(context).accentColor,
                    ),
      onTap: () {
                  pushJump(context, item);
                }
                    );
  }

  void pushJump(BuildContext context, int index){
   Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JumpDetailPage(jump: jumps[index]),));
  }
}