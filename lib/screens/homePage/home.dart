import 'package:feetback/screens/jumpPage/jump.dart';
import 'package:feetback/services/bluetooth_service.dart';
import 'package:flutter/material.dart';

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
              child: Text("Jump history"),
              onPressed: () => Navigator.pushNamed(context, "/jump_history")
            ),
            Text("Perform a jump only works if already connected. These buttons are for testing purpose and may be removed."),
            RaisedButton(
              child: Text("Connect to a mat"),
              onPressed: () => Navigator.pushNamed(context, "/connect"),
            ),
            RaisedButton(
              child: Text("Perform a jump"),
              onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => JumpPage())),
            )
          ],
        ),
      )
    );
  }
}