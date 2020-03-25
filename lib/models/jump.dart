import 'package:firebase_database/firebase_database.dart';

class Jump{
  String jid;
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

  Jump.fromDB(this.jid, Map data) {
    date = DateTime.parse(data['date']);
    height = data['height'];
    airtime = data['airtime'];
    favorite = data['favorite'];
  }

  @override
  String toString() {
    //   print(jump.jid);
    //   print('\t' + jump.height.toString());
    //   print('\t' + jump.date.toString());
    //   print('\t' + jump.airtime.toString());
    //   print('\t' + jump.favorite.toString());
    //   print('\n\n');
    return "jid: " + jid 
          + '\n\t' + "date:     " + date.toString()
          + '\n\t' + "height:   " + height.toString()
          + '\n\t' + "airtime:  " + airtime.toString()
          + '\n\t' + "favorite: " + favorite.toString();
  }
}