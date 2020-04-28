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

  bool showWeek = false;
  DateTime beginDate = DateTime.now();
  double referanceHeight = 0;
  int counterX = 0;
  int counterY = 0;
  String dateLabel = "";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Dismissible(
            direction: DismissDirection.vertical,
            onDismissed: (DismissDirection direction) {
                counterY += direction == DismissDirection.endToStart ? 1 : -1;
                print("ondismissed");
                showWeek ? weekData() : yearData();
            },
            key: ValueKey(counterY),
            child: Dismissible(
              onDismissed: (DismissDirection direction) {
                counterX += direction == DismissDirection.endToStart ? 1 : -1;
                counterY = 0;
                showWeek ? weekData() : yearData();
              },
              key: ValueKey(counterX),
              child: Padding(
                padding: const EdgeInsets.only(right: 32, left: 18, top: 8, bottom: 18),
                child: showWeek ? weekData() : yearData(),
              ),
            ),
            ) 
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(top: 8.0, left: 8),
              onPressed: () {
                  setState(() {
                    counterX = 0;
                    counterY = 0;
                    showWeek = !showWeek;
                  });
              },
              icon: Icon(Icons.swap_horiz, //timeline, today, swap_horiz
                color: showWeek ? Theme.of(context).accentColor.withOpacity(0.5) : Theme.of(context).accentColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 40),
              child: Text(
                dateLabel,
                textAlign: TextAlign.center,
              )
            )
          ],
        )
      ],
    );
  }

  Widget yearData() {
    var workingDate = DateTime(Jiffy().year+counterX);
    var spots = getSpots(
      workingDate,
      DateTime(Jiffy().year+1+counterX),
      Jiffy(Jiffy(beginDate).add(years: counterX)).isLeapYear ? 366:365
    );
    dateLabel = "Year: ${Jiffy(workingDate).year}";

    try {
      return LineChart(
        LineChartData(
        gridData: FlGridData( //Draws helping lines
          show: true,
          drawVerticalLine: true,
          checkToShowHorizontalLine: (double value) {
            return value%5 == 0; 
          },
          checkToShowVerticalLine: (double value){
            return Jiffy(Jiffy(beginDate).add(days: value.toInt())).date == 1;
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
            reservedSize: 8, //smaller value increases size of graph along y-axis
                              //should be set smaller
            textStyle:
                //TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 12),
                TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.normal, fontSize: 14),
            getTitles: (value) {
              List<String> months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
              List<int> titlesToDisplay = [2,5,8,11]; //met of zonder 11
              
              var _date = Jiffy(beginDate).add(days: value.toInt());
              if (Jiffy(_date).date == 1 && titlesToDisplay.contains(_date.month))
              {
                return months[_date.month-1].toUpperCase();
              }
              return "";
            },
            margin: 8,
            //rotateAngle: -30, //changes angel of titles
          ),
          leftTitles: SideTitles(
            showTitles: true,
            textStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
            getTitles: (value) {
              int offset = counterY*5;
              List<double> titlesToDisplay = [referanceHeight-5+offset, referanceHeight+offset, referanceHeight+5+offset];
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
        clipToBorder: true,
        minX: 0,
        maxX: Jiffy(beginDate).isLeapYear ? 365:364,
        minY: referanceHeight-10, //null for automatic
        maxY: referanceHeight+10,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            curveSmoothness: 0.2,
            //preventCurveOverShooting: true,
            //preventCurveOvershootingThreshold:100,
            colors: [Theme.of(context).accentColor],
            barWidth: 5,
            isStrokeCapRound: true,
            dotData: const FlDotData(
              show: false,
              dotColor: Colors.red,
            ),
          ),
        ],
      )
    );
    } catch (_) {
      dateLabel = "";
      return Padding(
        padding: const EdgeInsets.only(top: 64.0),
        child: Text(
          "No data to show.",
          textAlign: TextAlign.center,
        )
      );
    }

    
  }

  Widget weekData() {
    var workingDate = Jiffy(getFirstDayOfWeek(DateTime.now())).add(weeks: counterX);
    var spots = getSpots(
      workingDate,
      Jiffy(getFirstDayOfWeek(DateTime.now())).add(weeks: 1+counterX),
      7);
    dateLabel = "Week: ${Jiffy(workingDate).week}";
    try {
      return LineChart(
      LineChartData(
        gridData: FlGridData( //Draws helping lines
          show: true,
          drawVerticalLine: true,
          checkToShowHorizontalLine: (double value) {
            return value%5 == 0; 
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
            reservedSize: 8, //smaller value increases size of graph along y-axis
            textStyle:
                //TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 12),
                TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.normal, fontSize: 14),
            getTitles: (value) {
              List<String> days = ["Mn", "Te", "Wd", "Tu", "Fr", "St", "Sn"];
              if(value < 7){
                //print(value.toInt());
                return days[value.toInt()];
              }
              return "";
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
        clipToBorder: true,
        minX: 0,
        maxX: 6,
        minY: referanceHeight-10, //null for automatic
        maxY: referanceHeight+10,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            curveSmoothness: 0.2,
            //preventCurveOverShooting: true,
            //preventCurveOvershootingThreshold:5,
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
      )
    );
    } catch (_) {
      dateLabel = "";
      return Padding(
        padding: const EdgeInsets.only(top: 64.0),
        child: Text(
          "No data to show.",
          textAlign: TextAlign.center,
        )
      );
    }

    
  }

  List<FlSpot> getSpots(DateTime _begindDate, DateTime endDate, double intervalDays){
    List<FlSpot> spots = new List();
    List<FlSpot> averageSpots = new List();

    setState(() {
                beginDate = _begindDate;
              });

    Standardization standX = Standardization(
      beginDate.millisecondsSinceEpoch.toDouble(),
      endDate.millisecondsSinceEpoch.toDouble(),
      intervalDays-1);

    for (var item in widget.jumpItems) {
      spots.add(item.getSpot(standX));
      
      if (Jiffy(item.date).isBetween(beginDate, endDate)) {
          averageSpots.add(item.getSpot(standX));  
        }  
    }

    setState(() {
                  referanceHeight = roundTo5or0(averageHeight(averageSpots));
                });
    
    spots.sort((a, b) => a.x.compareTo(b.x));
    
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

  DateTime getFirstDayOfWeek(DateTime date){
    while(Jiffy(date).day != 1){
      date = Jiffy(date).subtract(days: 1);
    }
    return date;
  }
}