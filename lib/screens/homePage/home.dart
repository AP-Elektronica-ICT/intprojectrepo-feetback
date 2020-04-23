import 'package:feetback/services/database_service.dart';
import 'package:flutter/material.dart';

import 'package:feetback/models/jump.dart';
import 'package:feetback/screens/jumpPage/jump.dart';
import 'package:feetback/services/bluetooth_service.dart';
import 'package:feetback/widgets/feetback_app_bar.dart';
import 'package:feetback/services/service_locator.dart';

class HomePage extends StatelessWidget {
  var temp;
  DatabaseService _service = locator<DatabaseService>();
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
              // RaisedButton(
              //   child: Text("Jump Details"),

              //   // onPressed: () => Navigator.pushNamed(context, "/jumpdetails" , arguments: Jump(DateTime.now(), 177, 4, )), //dummy data to test arguments passing

              // ),
              RaisedButton(
                child: Text("SignIn"),
                onPressed: () => Navigator.pushNamed(context, "/signin"),
              ),
              // RaisedButton(
              //   child: Text("Jump History"),
              //   // onPressed: () => Navigator.pushNamed(context, "/jumphistory" ),
              // ),
              // Text("Perform a jump only works if already connected. These buttons are for testing purpose and may be removed."),
              // RaisedButton(
              //   child: Text("Connect to a mat"),
              //   onPressed: () => Navigator.pushNamed(context, "/connect"),
              // ),
              // RaisedButton(
              //   child: Text("Perform a jump"),
              //   onPressed: () => Navigator.push(
              //               context,
              //               MaterialPageRoute(builder: (context) => JumpPage())),
              // ),
              RaisedButton(
                child: Text("Add jump"),
                onPressed: () => {_service.addJump(20.0, 1.67, false)},
              ),
              RaisedButton(
                child: Text("Get Highest"),
                onPressed: () => {print(_service.getHighestJump().toString())},
              ),
              RaisedButton(
                child: Text("Print jump id"),
                onPressed: () =>{
                  temp = _service.getHighestJump(),
                  print (temp as Jump),
                  // print (temp.jid.toString())
                }
              ),
              RaisedButton(
                child: Text("Remove jump"),
                onPressed: ()=> {
                  _service.delJump("-M5b1ouiJ5dxycpaBAHD")
                },
              ),

            ],
          ),
        ));
  }
}
