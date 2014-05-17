

// these variables will change:
int sensorReading = 0;      // variable to store the value read from the sensor pin

int previousReading = 100;


void setup() {
 Serial.begin(9600);       // use the serial port
}

void loop() {
  // read the sensor and store it in the variable sensorReading:
  sensorReading = analogRead(1); 
  //Serial.println(previousReading);
  //Serial.println(abs(previousReading - sensorReading));
  if(sensorReading == 0){
    
    if(previousReading != 0){
      
        Serial.println("WHAM!");
        delay(1000);
        
    }
    
  }
  previousReading = sensorReading;
 // Serial.println("----");

//  delay(1000);  // delay to avoid overloading the serial port buffer
  
}
