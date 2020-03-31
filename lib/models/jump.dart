import 'package:feetback/models/standardization.dart';
import 'package:fl_chart/fl_chart.dart';

class Jump{
    DateTime date;
    double height;
    double airtime;
    bool favorite;
  
    Jump(DateTime date, double height, double airtime){
        this.date = date;
        this.height = height;
        this.airtime = airtime;
        this.favorite = false;
    }    

    FlSpot getSpot(Standardization x){
      return FlSpot(x.getStandard(this.date.millisecondsSinceEpoch.toDouble()), this.height);
    }
}