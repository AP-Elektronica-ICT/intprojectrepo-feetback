import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';





class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
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
          
              onPressed: () => Navigator.pushNamed(context, "/jumpdetails"),
              
            ),
            RaisedButton(
              child: Text("SignIn"),
              onPressed: () => Navigator.pushNamed(context, "/signin"),
            ),
            RaisedButton(
              child: Text("Jump History"),
              onPressed: () => Navigator.pushNamed(context, "/jumphistory"),
            ),
          ],
        ),
      )
    );
  }
}