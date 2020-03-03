import 'package:feetback/models/jump.dart';
import 'package:flutter/material.dart';

import 'package:feetback/widgets/feetback_app_bar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FeetbackAppBar(
        title: Text("Home"),
        height: 92,
        contentAlignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 16, right: 16),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text("Logged in as: "),
            RaisedButton(
              child: Text("Jump Details"),
          
              onPressed: () => Navigator.pushNamed(context, "/jumpdetails" , arguments: Jump(DateTime.now(), 177, 4)), //dummy data to test arguments passing
              
            ),
            RaisedButton(
              child: Text("SignIn"),
              onPressed: () => Navigator.pushNamed(context, "/signin"),
            ),
            RaisedButton(
              child: Text("Jump History"),
              onPressed: () => Navigator.pushNamed(context, "/jumphistory" ), 
            ),
          ],
        ),
      )
    );
  }
}