/* 
 This  sketch reads  the microphone sensor. The microphone
 will range from 0 (total silence) to 1023 (really loud). 
 The LED will be lit yellow/orange/red (to simulate fire).  
 */

#include <Esplora.h>

boolean finished = false;
int blowUntil = 150; // how long the user needs to blow
int duration = 0;  // how long the user has been blowing

void setup() {
  // initialize the serial communication:
  Serial.begin(9600);
}

void loop() {
  
  // user needs to keep blowing
  if(!finished){
    
    if(duration < blowUntil){ 
      micFire(); //keep blowing
    }
    else{ 
      finished = true; //finished!
      Serial.println("true");
      Esplora.writeRGB(0, 0, 0); //led off
    }
    
  }
     
}


void micFire(){
  // read the sensor into a variable:
  int loudness = Esplora.readMicrophone();
  
  // if user is blowing...
  if(loudness > 0){
    
    // increase duration
    duration += 1;
    
    //determine LED color based on duration
    if(duration < blowUntil*.25){
      Esplora.writeRGB(214, 69, 12); //red
    }
    else if(duration < blowUntil*.5){
      Esplora.writeRGB(235, 94, 15); //dark orange
    }
    else if(duration < blowUntil*.75){
      Esplora.writeRGB(252, 123, 4); //bright orange
    }
    else if(duration < blowUntil){
      Esplora.writeRGB(253, 142, 1); //light orange 
    }
    
    Esplora.writeRGB(0, 0, 0); //led off - gives a flickering fire effect
  
  }
  // user isn't blowing...
  else{
    Esplora.writeRGB(0, 0, 0); //led off
  }
  
} //end micFire()
