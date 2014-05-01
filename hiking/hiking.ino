// these constants won't change:
const int knockSensor = A0; // the piezo is connected to analog pin 0
const int threshold = 0;  // threshold value to decide when the detected sound is a knock or not


// these variables will change:
int sensorReading = 0;      // variable to store the value read from the sensor pin

int previousReading = 0;


void setup() {
 Serial.begin(9600);       // use the serial port
}

void loop() {
  // read the sensor and store it in the variable sensorReading:
  sensorReading = analogRead(knockSensor);    
  //Serial.println(sensorReading);
  //Serial.println(previousReading);
  //Serial.println(abs(previousReading - sensorReading));
  if(previousReading == 0){
      previousReading = sensorReading;
  }else{
   if(abs(previousReading - sensorReading) > 50){
      Serial.println("WHAM!");  
   }
   previousReading = sensorReading;
  }
 // Serial.println("----");

  delay(1000);  // delay to avoid overloading the serial port buffer
  
}
