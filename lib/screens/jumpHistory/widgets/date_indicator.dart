import 'package:flutter/material.dart';

class DateIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: Container(
        height: 32,
        width: 32,
        color: Color.fromRGBO(0, 0, 0, 0.08),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 2.0,
            ),
            Expanded(
              child: Center(
                child: Text(
                  "12",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            Container(
              height: 8,
              width: double.infinity,
              color: Theme.of(context).accentColor,
              child: Center(
                child: Text(
                  "okt.",
                  style: TextStyle(
                    fontSize: 6.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                 ),
                ),
              ),
            )
          ]
        ),
      ),
    );
  }
}