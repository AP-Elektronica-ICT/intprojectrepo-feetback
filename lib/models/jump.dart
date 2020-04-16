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

  Jump.fromDB(this.jid, Map data) {
    date = DateTime.parse(data['date']);
    height = data['height'].toDouble();
    airtime = data['airtime'].toDouble();
    favorite = data['favorite'];
  }

  @override
  String toString() {
    return "jid: " + jid 
          + '\n\t' + "date:     " + date.toString()
          + '\n\t' + "height:   " + height.toString()
          + '\n\t' + "airtime:  " + airtime.toString()
          + '\n\t' + "favorite: " + favorite.toString();
  }
}