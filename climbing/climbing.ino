// Handles rotary encoder - triggers climbing video
// Based on sketch from 6.12 of Arduino Cookbook

const int encoderPinA = 2;
const int encoderPinB = 3;

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
  delay(1000);
}


//reads the rotary encoder
void readEncoder()
{
  //if both pins are the same
  if(digitalRead(encoderPinA) == digitalRead(encoderPinB)){
    encoderPos++; //increment encoder position
    Serial.println("climb"); //send message to processing
  } 
  //if pins are different
  else{
    encoderPos--; //decrement encoder position
  }
}
