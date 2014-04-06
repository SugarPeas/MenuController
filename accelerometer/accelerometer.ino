/* 
 This  sketch reads accelerometer and uses it to update the image position in Processing.  
 */

#include <Esplora.h>

long previousTime = 0; // last time we checked
unsigned long currentTime; // current time
long interval = 40; // interval at which to check - might need to play around with this

void setup() {
  // initialize the serial communication:
  Serial.begin(9600);
}

void loop() {
  
  // get the current time
  currentTime = millis();
  
  // if the difference between the current time and the last time we checked is bigger than the interval...
  if(currentTime - previousTime > interval) {
    
    int x_axis = Esplora.readAccelerometer(X_AXIS);
     
     if(x_axis > 50){
       Serial.println("Up");
     }
     else if(x_axis < 0){
       Serial.println("Down");
     }
    
    // update previousTime
    previousTime = currentTime;
   
  }
       
}

