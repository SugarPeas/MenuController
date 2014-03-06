/* 
 This  sketch reads controls the "fire-starting actions" using the microphone and buttons. 
 
 ----BUTTON----
 The button will simulate striking a flint to create a spark.
 
 ----MICROPHONE----
 Blowing into the microphone will simulate blowing on tinder/kindling.
 The microphone will range from 0 (total silence) to 1023 (really loud). 
 The LED will be lit yellow/orange/red (to simulate flames) depending on the value provided by the microphone.  
 */

#include <Esplora.h>

//Button variables
boolean fireSparked = false;
int numStrikes = 0; //will store how many times the user has striked the flint (pushed the button)
long previousMillis = 0; //will store last time button was checked
long interval = 100; //how long to wait before checking button again

//Microphone variables
boolean finishedBlowing = false;
int blowUntil = 100; // how long the user needs to blow
int duration = 0;  // how long the user has been blowing


void setup() {
  // initialize the serial communication:
  Serial.begin(9600);
}

void loop() {
  
  //is it time to check the button?
  unsigned long currentMillis = millis();
  if(currentMillis - previousMillis > interval) {
    
    previousMillis = currentMillis; // save the last time you checked the button
    
    //if fire hasn't sparked
    if(!fireSparked){
      buttonFlint(); //check for button press
    }
    
  }
  
  //if spark was created...
  if(fireSparked){
    
    // is the user finished blowing?
    if(!finishedBlowing){
      
      if(duration < blowUntil){ 
        micFire(); //keep blowing
      }
      else{ 
        finishedBlowing = true; //finished!
        Serial.println("fire");
        Esplora.writeRGB(0, 0, 0); //led off
      }
      
    }//end if !finishedBlowing
    
  } //end if buttonPressed
    
  
  
     
}

void buttonFlint(){
  int button = Esplora.readButton(SWITCH_DOWN);
  
  //if button was pressed
  if(button == LOW){
    
    Serial.println("spark");
    
    //increase number of times flint has been striked
    numStrikes++;
    
    if(numStrikes == 5){
      fireSparked = true;
    }    
    
  }
  
} //end buttonFlint()


void micFire(){
  // read the sensor into a variable:
  int loudness = Esplora.readMicrophone();
  
  // if user is blowing...
  if(loudness > 30){
    
    // increase duration
    duration++;
    
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
