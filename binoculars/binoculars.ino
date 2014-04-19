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
float val = 0;       // variable to store the value coming from the sensor
float val2 = 0;
float val3 = 0;

float maxVal = 1023;

long previousTime = 0; // last time we checked
unsigned long currentTime; // current time
long interval = 50; // interval at which to check - might need to play around with this

void setup() {
  Serial.begin(9600);
}

void loop() {
  // get the current time
  currentTime = millis();
  
  // if the difference between the current time and the last time we checked is bigger than the interval...
  if(currentTime - previousTime > interval) {
    
    val = analogRead(potPin1);    // read the value from the sensor
    val2 = analogRead(potPin2);
    val3 = analogRead(buttonPin);
    Serial.print(val, DEC);
    Serial.print(",");
    Serial.print(val2, DEC);
    Serial.print(",");
    Serial.println(val3, DEC);
    // update previousTime
    previousTime = currentTime;  
  }
}
