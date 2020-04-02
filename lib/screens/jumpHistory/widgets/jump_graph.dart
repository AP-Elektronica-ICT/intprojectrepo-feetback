import 'package:feetback/models/standardization.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:jiffy/jiffy.dart';

import 'package:feetback/models/jump.dart';

class JumpGraph extends StatefulWidget {
  final List<Jump> jumpItems;

  JumpGraph({
    @required this.jumpItems,
  });

  @override
  _JumpGraphState createState() => _JumpGraphState();
}

class _JumpGraphState extends State<JumpGraph> {

  bool showAvg = false;
  DateTime beginDate = DateTime.now();
  double referanceHeight = 0;

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
        checkToShowHorizontalLine: (double value) {
              return value == 45 || value == 50 || value == 55 || value == 60 || value == 65;
        },
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
            List<String> months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
            int offset = Jiffy(beginDate).month-1;
            List<int> titlesToDisplay = [2 , 6, 9];
            
            if (titlesToDisplay.contains(value.toInt())) {
              if(value.toInt()+offset > 11){
                return months[value.toInt()+offset-12].toUpperCase();
              }
              return months[value.toInt()+offset].toUpperCase();
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
            List<double> titlesToDisplay = [referanceHeight-5, referanceHeight, referanceHeight+5];
            if (titlesToDisplay.contains(value)) {
              return "${value.toInt()} cm";
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
      minY: 45,
      maxY: 65,
      lineBarsData: [
        LineChartBarData(
          spots: getLastYearSpots(),
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
          spots: //makeSpotList(),
            [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ], 
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

  List<FlSpot> getLastYearSpots(){
    widget.jumpItems.sort((b, a) => a.date.compareTo(b.date));
    List<FlSpot> spots = new List();
    List<FlSpot> tmp = new List();
    var lastJump = widget.jumpItems[0].date;

    setState(() {
                beginDate = Jiffy(lastJump).subtract(years: 1);
              });
    Standardization standX = Standardization(
      beginDate.millisecondsSinceEpoch.toDouble(),
      lastJump.millisecondsSinceEpoch.toDouble(),
      11);

    for (var item in widget.jumpItems) {
      if (item.date.compareTo(beginDate)>=0) {
        spots.add(item.getSpot(standX)); 
        //print(item.getSpot(standX).y); 
      }
      else{
        tmp.add(item.getSpot(standX));
      }
    }

    if(tmp != null){
      tmp.sort((b, a) => a.x.compareTo(b.x));
      spots.add(FlSpot(standX.getStandard(beginDate.millisecondsSinceEpoch.toDouble()), tmp[0].y));
    }

    setState(() {
               referanceHeight = roundTo5or0(averageHeight(spots));
              });

    return spots;
  }

  double averageHeight(List<FlSpot> list){
    double sum = 0;
    for (var item in list) {
      sum += item.y;
    }
    return sum/list.length;
  }

  double roundTo5or0(double nr){
    if(nr%5<= 2.5) {
      nr=nr-(nr%5);
    }
    else if(nr%5>2.5) {
      nr=nr+(5-nr%5);
    }
    return nr;
  }
}