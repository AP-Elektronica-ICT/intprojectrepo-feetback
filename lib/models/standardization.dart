class Standardization{
    double lowerBound;
    double upperBound;
    double scale;  
    
    Standardization(double lowerBound, double upperBound, double scale){
      this.lowerBound = lowerBound;
      this.upperBound = upperBound;
      this.scale = scale;
    }    

    double getStandard(double value){
      return ((value-lowerBound)/(upperBound-lowerBound))*scale;
    }
}