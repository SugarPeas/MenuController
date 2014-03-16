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
int numStrikes = 0; //will store how many times the user has striked the flint (pressed the button)
int numSparks = 5; //number of times user will have to strike the flint
int buttonState = 0; //will store current button state
int lastButtonState = 0; //will store previous button state

//Microphone variables
boolean finishedBlowing = false;
int blowUntil = 100; // how long the user needs to blow
int duration = 0;  // how long the user has been blowing


void setup() {
  // initialize the serial communication:
  Serial.begin(9600);
}

void loop() {
  
  //get button state
  buttonState = Esplora.readButton(SWITCH_DOWN);
  
  //if button state has changed
  if(buttonState != lastButtonState){
    
    //trigger button press on release
    //prevents long holds from being read as multiple button presses
    if(buttonState == HIGH && numStrikes <= numSparks){
      buttonFlint();
    }
    
  }
  
  //save current state as last state for next time through the loop
  lastButtonState = buttonState;
  
  //if spark was created...
  if(fireSparked){
    
    // is the user finished blowing?
    if(!finishedBlowing){
      
      if(duration < blowUntil){ 
        micFire(); //keep blowing
      }
      else{ 
        finishedBlowing = true; //finished!
        Serial.println("fire"); //send message to processing
        Esplora.writeRGB(0, 0, 0); //led off
      }
      
    }
    
  }
     
}//end loop()

void buttonFlint(){
  
  Serial.println("spark"); //send message to processing
  
  //fire sparked, user can start blowing
  if(numStrikes == numSparks){
    fireSparked = true;
  }   
   
  //increase number of times flint has been striked
  numStrikes++; 
  
} //end buttonFlint()


void micFire(){
  // read the sensor into a variable:
  int loudness = Esplora.readMicrophone();
  
  // if user is blowing...
  if(loudness > 30){
    
    // increase duration
    duration++;
    
    Serial.println("blowing");
    
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
