import 'package:flutter/material.dart';

import 'package:feetback/models/jump.dart';
import 'package:feetback/screens/detailedJumpPage/jump_detailed.dart';
import 'package:feetback/screens/jumpHistory/enums/sort_state.dart';
import 'package:feetback/screens/jumpHistory/widgets/date_indicator.dart';

class FeetbackList  extends StatefulWidget {
  final List<Jump> jumpItems;
  final SortState currentSortState;
  final void Function(Jump) onFavorite;
  final void Function(Jump) onDelete;
  final void Function(Jump) onRestate;


  FeetbackList({
    @required this.jumpItems,
    @required this.currentSortState,
    @required this.onFavorite,
    @required this.onDelete,
    @required this.onRestate,
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
          return _buildRow(context, widget.jumpItems[item], widget.onFavorite, widget.onDelete, widget.onRestate);  
        }
    );
  }
}

Widget _buildRow(BuildContext context, Jump jump, Function(Jump) onFavorite, Function(Jump) onDelete, Function(Jump) onRestate) {
    return Container(
    decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 0.04),
        borderRadius: BorderRadius.circular(8.0)),
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: Dismissible(
          direction: DismissDirection.endToStart,
          onDismissed: (DismissDirection direction) {
            final Jump swipedJump = jump;
            Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("Jump deleted"),
            duration: Duration(seconds: 4),
            action: SnackBarAction(
                label: "Undo",
                textColor: Colors.yellow,
                onPressed: () {
                  final tmpJump = Jump.copy(swipedJump);
                  //print(tmpJump);
                  onRestate(tmpJump);
                }),
          ),
        )
        .closed
        .then((reason) {
      if (reason != SnackBarClosedReason.action) {
        // The SnackBar was dismissed by some other means
        // that's not clicking of action button
        // Make API call to backend
      
      }});
            onDelete(jump);
        },    
          key: ValueKey(jump),
          background: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(8.0)),
            alignment: AlignmentDirectional.centerEnd,
            child: Padding(
              padding: EdgeInsets.only(right: 32),
              child: Icon(Icons.delete_forever),
            ),
        ),
          child: ListTile(
            //key: ValueKey(jump),
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
                      onPressed: () => {
                        print(jump),
                        onFavorite(jump),
                      }
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