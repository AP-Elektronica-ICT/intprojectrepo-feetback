import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text("Jump history"),
          onPressed: () => Navigator.pushNamed(context, "/jump_history")
        ),
      )
    );
  }
}