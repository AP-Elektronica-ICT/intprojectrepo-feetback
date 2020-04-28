import 'dart:core';

import 'package:feetback/screens/jumpHistory/widgets/jump_graph.dart';
import 'package:flutter/material.dart';

import 'package:feetback/models/jump.dart';
import 'package:feetback/widgets/feetback_app_bar.dart';
import 'package:feetback/screens/jumpHistory/widgets/feetback_list.dart';
import 'package:feetback/screens/jumpHistory/enums/sort_state.dart';
import 'package:feetback/screens/jumpHistory/widgets/jump_history_popup.dart';
import 'package:feetback/services/database_service.dart';



class JumpHistoryPage extends StatefulWidget {
  @override
  _JumpHistoryPageState createState() => _JumpHistoryPageState();
}

class _JumpHistoryPageState extends State<JumpHistoryPage> {
  List<Jump> jumps;
  final DatabaseService databaseService = new DatabaseService();
  SortState _selection = SortState.date;
  
  @override
  void initState() {
    super.initState();

    print("Init Jump History");
  }

  @override
  Widget build(BuildContext context) {
    print("Building Jump History");
    return Scaffold(
      appBar: FeetbackAppBar(
        title: Text("Jump history"),
        height: 92,
        contentAlignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 16, right: 16),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                
              });
            },
          ),
          JumpHistoryPopup(
            onSelected: (SortState selected) => {
              this.setState(() {
                _selection = selected;
              })
            }
          ),
        ],
      ),

      body: FutureBuilder<List<Jump>>(
        future: databaseService.getAllJumps(),
        builder: (BuildContext context, AsyncSnapshot<List<Jump>> snapshot) {
          if (snapshot.hasData) {
            jumps = snapshot.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                JumpGraph(jumpItems: jumps),
                Expanded(
                  child: FeetbackList(
                    currentSortState: _selection,
                    jumpItems: jumps, 
                    onFavorite: (Jump jump) async{
                      setState(() => jump.favorite = !jump.favorite);
                      databaseService.toggleFavorite(jump.jid, jump.favorite);
                    },
                    onDelete: (Jump jump) async{
                      databaseService.delJump(jump.jid);
                      setState(() {
                        jumps.remove(jump);
                      });
                      print("removing Jump: ${jump.jid}");
                    },
                    onRestate: (Jump jump) {
                      setState(() {
                        jumps.add(jump);
                      });
                      
                     databaseService.addJumpWithJump(jump);
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("Error while getting your data.");
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}  