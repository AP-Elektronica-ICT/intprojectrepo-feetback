import 'package:flutter/material.dart';

import 'package:feetback/utils/date_utils.dart';

class DateIndicator extends StatelessWidget {
  final DateTime date;

  DateIndicator({@required this.date});

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
                  DateUtils.dayOfMonth(date),
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
                  DateUtils.monthNameShort(date),
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