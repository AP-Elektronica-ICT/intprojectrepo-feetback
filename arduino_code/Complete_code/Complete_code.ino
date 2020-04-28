#include <SoftwareSerial.h> 
SoftwareSerial MyBlue(10, 11); // RX | TX 
String flag ; 

int Button; 
int Mat;
double time1;
int Sub1();
int Sub2();

const int b1 = 10;

//I Only use b2 to see if you are standing on the mat. 
const int b2 = 9;

bool temp = false;

void setup() {
Serial.begin(9600);
MyBlue.begin(9600); 
pinMode(b1, INPUT);
pinMode(b2, INPUT);
}

void loop()
{
  /*
Serial.println("Press button to start!"); //program starts here
Button = digitalRead(b1);

while(Button == 0)
{
  Button = digitalRead(b1);
  delay(1);
}
*/
Sub1();

}

int Sub1()
{
  
  Serial.println("Step on the mat!"); 
  Mat = digitalRead(b2);
  while(Mat == 0 ) //waits until you step on the mat
  {
    Mat = digitalRead(b2);
    MyBlue.write("n"); // Send n to the app so that it knows the user is not standing on the app
    delay(1);
  }
  MyBlue.write("y"); // Send Y so that the app knows the user is standing on the app
  Serial.println("good now enter the jump in the app");
  while(!MyBlue.available()){

  // if the user leaves the mat without pressing the jump button in the app
  if(digitalRead(b2) == 0){
    return;
    }
  }
  Sub2();
}
int Sub2()
{
  
  Serial.println("Jump!");
  Serial.println(MyBlue.readString());
  while(Mat == 1)
  {
    
    Mat = digitalRead(b2);
    delay(1);
  }
  time1 = millis(); //start's the first timer
while(Mat == 0)
{
  Serial.println("Jumping");
  Mat = digitalRead(b2);
  delay(1);
}
 Sub3(time1);
  
  
  
}
int Sub3(double time1)
{

double AirTime;
double time2 = millis(); 
AirTime = (time2-time1)/1000; //calculates the AirTime in seconds
Serial.println ("Time on air = ");
Serial.println (AirTime);
delay(1000);

 double height = ((AirTime/2)*(AirTime/2)*0.5*9.81);
 Serial.println ("Jump Height = ");
  int temp = round(height*100);
  String outMessage = String(temp)+ "e";
  char* cString = (char*) malloc(sizeof(char)*(outMessage.length() + 1));
  outMessage.toCharArray(cString, outMessage.length() + 1);
  Serial.print(cString);
  Serial.print("outMessage"+outMessage);
  cString = cString;
  MyBlue.write(cString );
 
 Serial.println (height);
 delay(4000);
 return;
  
}
