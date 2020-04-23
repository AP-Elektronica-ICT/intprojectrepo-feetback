class Jump{
  String jid;
  DateTime date;
  double height;
  double airtime;
  bool favorite;

  Jump(DateTime date, double height, double airtime, String jid){
      this.date = date;
      this.height = height;
      this.airtime = airtime;
      this.favorite = false;
      this.jid = jid;
  }

  Jump.fromDB(this.jid, Map data) {
    date = DateTime.parse(data['date']);
    height = data['height'].toDouble();
    airtime = data['airtime'].toDouble();
    favorite = data['favorite'];
    jid = data['jid'].toString();
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