 /* Analog Read to LED
 * ------------------ 
 *
 * turns on and off a light emitting diode(LED) connected to digital  
 * pin 13. The amount of time the LED will be on and off depends on
 * the value obtained by analogRead(). In the easiest case we connect
 * a potentiometer to analog pin 2.
 *
 * Created 1 December 2005
 * copyleft 2005 DojoDave <http://www.0j0.org>
 * http://arduino.berlios.de
 *
 */

int potPin1 = 2;    // select the input pin for the potentiometer
int potPin2 = 3;
int buttonPin = 1;
int val = 100;       // variable to store the value coming from the sensor
int val2 = 200;
int val3 = 500;
int counter = 0;

int maxVal = 1023;

long previousTime = 0; // last time we checked
unsigned long currentTime; // current time
long interval = 50; // interval at which to check - might need to play around with this

String dataSend;
String previousData;

void setup() {
  Serial.begin(9600);
}

void loop() {
  // get the current time
  currentTime = millis();
  
  // if the difference between the current time and the last time we checked is bigger than the interval...
  if(currentTime - previousTime > interval) {
    
//    val = analogRead(potPin1);    // read the value from the sensor
//    val2 = analogRead(potPin2);
//    val3 = analogRead(buttonPin);
    if(counter < 1024){
      counter+=5;
    }else{
      counter = 0;
    }
    val = counter;
    val2 = counter;
    val3 = maxVal;
    
    dataSend = String(counter);
    dataSend = dataSend + ",";
    dataSend = dataSend + String(counter);
    dataSend = dataSend + ",";
    dataSend = dataSend + String(maxVal);
    if(dataSend != previousData){
      Serial.println(dataSend);
      previousData = dataSend;
    }
    
    
    //Serial.print(val);
    //Serial.print(",");
    //Serial.print(val2);
    //Serial.print(",");
    //Serial.println(val3);
    // update previousTime
    previousTime = currentTime;  
  }
  
}
