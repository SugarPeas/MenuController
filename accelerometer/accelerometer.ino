/* 
 This  sketch reads  the microphone sensor. The microphone
 will range from 0 (total silence) to 1023 (really loud). 
 The LED will be lit a yellow/orange/red (to simulate flickering fire).  
 */

#include <Esplora.h>

void setup() {
  // initialize the serial communication:
  Serial.begin(9600);
}

void loop() {
 
     int x_axis = Esplora.readAccelerometer(X_AXIS);
      /*Serial.print("x: ");
 Serial.print(x_axis);*/
     
     if(x_axis > 50){
       Serial.println("Up");
     }else if(x_axis < 0){
       Serial.println("Down");
     }
     
      delay(50);
}

