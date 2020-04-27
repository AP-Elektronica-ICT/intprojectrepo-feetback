import 'package:flutter/material.dart';

import 'package:feetback/models/jump.dart';
import 'package:feetback/screens/detailedJumpPage/jump_detailed.dart';
import 'package:feetback/screens/jumpHistory/enums/sort_state.dart';
import 'package:feetback/screens/jumpHistory/widgets/date_indicator.dart';


class FeetbackList  extends StatefulWidget {
  final List<Jump> jumpItems;
  final SortState currentSortState;
  final void Function(Jump) onFavorite;

  FeetbackList({
    @required this.jumpItems,
    @required this.currentSortState,
    @required this.onFavorite,
  });

  @override
  _FeetbackListState createState() => _FeetbackListState();
}

class _FeetbackListState extends State<FeetbackList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(0.0),
        itemCount: widget.jumpItems.length,
        itemBuilder: (context, item) {
          if(widget.currentSortState == SortState.date){
            widget.jumpItems.sort((b, a) => a.date.compareTo(b.date));
          }
          else if(widget.currentSortState == SortState.height){
            widget.jumpItems.sort((b, a) => a.height.compareTo(b.height));
          }
          else if(widget.currentSortState == SortState.dayHeight){
            widget.jumpItems.sort((b, a) => a.height.compareTo(b.height));
            widget.jumpItems.sort((b, a) => a.date.day.compareTo(b.date.day));
            widget.jumpItems.sort((b, a) => a.date.month.compareTo(b.date.month));
            widget.jumpItems.sort((b, a) => a.date.year.compareTo(b.date.year));
          }
          else if(widget.currentSortState == SortState.favorite){
            widget.jumpItems.sort((b, a) => compareBool(a.favorite, b.favorite));
          }
          return _buildRow(context, widget.jumpItems[item], widget.onFavorite);  
        }
    );
  }
}

Widget _buildRow(BuildContext context, Jump jump, Function(Jump) onFavorite) {
    return Dismissible(
        onDismissed: (DismissDirection direction) {
          print("removing");
        },
        key: Key(jump.jid),
        background: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(8.0)),
          margin: new EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
          alignment: AlignmentDirectional.centerEnd,
          child: Padding(
            padding: EdgeInsets.only(right: 32),
            child: Icon(Icons.delete_forever),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            borderRadius: BorderRadius.circular(8.0)),
          margin: new EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
          child: ListTile(
              leading: Padding(child: DateIndicator(date: jump.date,), padding: EdgeInsets.only(top: 5),),
              subtitle: Text(jump.date.day.toString() +
                  "/" +
                  jump.date.month.toString() +
                  "/" +
                  jump.date.year.toString()),
              title: Text(jump.height.toString() + " cm",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: 
                    IconButton(
                      icon:Icon(
                        jump.favorite ? Icons.favorite : 
                        Icons.favorite_border,
                        color: jump.favorite ? Theme.of(context).accentColor: null,
                        ),
                        onPressed: () => onFavorite(jump),
                    ),
              onTap: () {
                pushJump(context, jump);
              },
          ),
        ) 
    );
  }

  void pushJump(BuildContext context, Jump jump) { //int index
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => JumpDetailPage(jump: jump),
        )
    );
  }

  int compareBool(bool a, bool b){
    if(a && !b) return 1;
    else if(!a && b) return -1;
    else return 0;
  }