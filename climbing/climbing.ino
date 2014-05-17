// Handles rotary encoder - triggers climbing video
// Based on sketch from 6.12 of Arduino Cookbook

const int encoderPinA = 2;
const int encoderPinB = 4;

long previousTime = 0; // last time we checked
unsigned long currentTime; // current time
long interval = 100; // interval at which to check - might need to play around with this

int Pos, oldPos;
volatile int encoderPos = 0; // variables changed within interrupts are volatile

void setup()
{
  pinMode(encoderPinA, INPUT);
  pinMode(encoderPinB, INPUT);
  
  digitalWrite(encoderPinA, HIGH);
  digitalWrite(encoderPinB, HIGH);
  
  Serial.begin(9600);

  attachInterrupt(0, readEncoder, FALLING); // encoder pin on interrupt 0 (pin 2)
}


void loop()
{
  uint8_t oldSREG = SREG;
  
  cli();
  Pos = encoderPos;
  SREG = oldSREG;
  
  if(Pos != oldPos){
    
    // get the current time
    currentTime = millis();
    
    if(currentTime - previousTime > interval) {
      Serial.println("climb"); //send message to processing
    }
    
    oldPos = Pos;
    previousTime = currentTime;
    
  }  
}


//reads the rotary encoder
void readEncoder()
{
  //if both pins are the same
  if(digitalRead(encoderPinA) == digitalRead(encoderPinB)){
    encoderPos++; //increment encoder position
  } 
  //if pins are different
  else{
    encoderPos--; //decrement encoder position
  }
}
