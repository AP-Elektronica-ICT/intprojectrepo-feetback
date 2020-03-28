import 'package:feetback/models/standardization.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:jiffy/jiffy.dart';

import 'package:feetback/models/jump.dart';

class JumpGraph extends StatefulWidget {
  final List<Jump> jumpItems;

  JumpGraph({
    @required List<Jump> this.jumpItems,
  });

  @override
  _JumpGraphState createState() => _JumpGraphState();
}

class _JumpGraphState extends State<JumpGraph> {

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Container(
            decoration: BoxDecoration( //can be deleted
                borderRadius: const BorderRadius.all(
                  Radius.circular(0),
                ),
                color: Colors.transparent),
            child: Padding(
              padding: const EdgeInsets.only(right: 32, left: 18, top: 8, bottom: 18),
              child: LineChart(
                showAvg ? avgData() : mainData(),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 60,
          height: 34,
          child: FlatButton(
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
              });
            },
            child: Text(
              'avg',
              style: TextStyle(
                fontSize: 12,
                color: showAvg ? Theme.of(context).accentColor.withOpacity(0.5) : Theme.of(context).accentColor,
                fontWeight: FontWeight.w100),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData( //Draws helping lines
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.grey,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.grey,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22, //smaller value increases size of graph along y-axis
          textStyle:
              //TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 12),
              TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.normal, fontSize: 14),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '40 cm';
              case 2:
                return '60 cm';
              case 3:
                return '80 cm';
            }
            return '';
          },
          reservedSize: 32,
          margin: 12,
        ),
      ),
      borderData:
          FlBorderData(show: true, border: Border.all(color: Colors.grey, width: 1)),
      minX: 0, //gives values 0->11 = Jan ->Dec
      maxX: 11,
      minY: 0,
      maxY: 4,
      lineBarsData: [
        LineChartBarData(
          spots: getLastYearSpots()
          /*const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ]*/,
          isCurved: true,
          colors: [Theme.of(context).accentColor],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
            colors: [Theme.of(context).accentColor],
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.grey,
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.grey,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle:
              TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR1';
              case 5:
                return 'JUN1';
              case 8:
                return 'SEP1';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData:
          FlBorderData(show: true, border: Border.all(color: Colors.grey, width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: makeSpotList(),
           /* [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ], */
          isCurved: true,
          colors: [
            Theme.of(context).primaryColor
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true, //set false for cleaner result
          ),
          belowBarData: BarAreaData(show: true, colors: [
           Theme.of(context).primaryColor
          ]),
        ),
      ],
    );
  }
  
  List<FlSpot> makeSpotList(){
    List<FlSpot> spots = new List();
    for (var item in widget.jumpItems) {
      //spots.add(item.getSpot());
    }

    return spots;
  }

  List<FlSpot> getLastYearSpots(){
    widget.jumpItems.sort((b, a) => a.date.compareTo(b.date));
    List<FlSpot> spots = new List();
    var lastJump = widget.jumpItems[0].date;

    DateTime dateBoundary = Jiffy(lastJump).subtract(years: 1);
    Standardization standX = Standardization(
      dateBoundary.millisecondsSinceEpoch.toDouble(),
      lastJump.millisecondsSinceEpoch.toDouble(),
      11);
    Standardization standY = Standardization(20, 100, 4);

    for (var item in widget.jumpItems) {
      if (item.date.compareTo(dateBoundary)>=0) {
        spots.add(item.getSpot(standX, standY)); 
        print(item.getSpot(standX, standY).y); 
      }
    }
    //spots.add(FlSpot(0,0));
    return spots;
  }
}