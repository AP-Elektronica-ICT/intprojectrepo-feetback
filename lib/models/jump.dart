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
}