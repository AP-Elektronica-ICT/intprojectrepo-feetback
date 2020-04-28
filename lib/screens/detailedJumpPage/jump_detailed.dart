import 'dart:core';
import 'package:feetback/models/jump.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class JumpDetailPage extends StatelessWidget {

  final Jump jump;

  JumpDetailPage({Key key, @required this.jump}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jump Info"),
      ),
      body: Column(
        children:[
          ListTile(
            leading: Icon(Icons.directions_run),
            title: Text("Height"),
            subtitle: Text(jump.height.toString() + " cm"),
          ),
          ListTile(
            leading: Icon(Icons.timelapse),
            title: Text("Airtime"),
            subtitle: Text("${jump.airtime.toString()} ms"),
          ),
           ListTile(
            leading: Icon(Icons.date_range),
            title: Text("Date"),
            subtitle: Text(Jiffy(jump.date).format("EEEE [the] do [of] MMMM [\n at] h:mm:ss a"),),
          ),
        ]
      )
    );
  }
}

/*Padding(
        padding: EdgeInsets.all(16.8),
          child: Container(
              child: Column(children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text(
                      "Height",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Theme.of(context).accentColor)
                    ), 
                    Text(
                      jump.height.toString() + " cm",
                    style: 
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Theme.of(context).accentColor)
                    )
                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text("${jump.airtime.toString()} ms")
                  ]
                ),
                Row(),
                Text("${jump.airtime.toString()} ms"),
                Text(Jiffy(jump.date).format("EEEE [the] do [of] MMMM [\n at] h:mm:ss a"), textAlign: TextAlign.center,)
              ],
            ),
          )          
        ),*/