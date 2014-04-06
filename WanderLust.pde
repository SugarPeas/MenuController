import processing.serial.*;
Serial myPort;  // Create object from Serial class
Serial myPort2;
String portFire = Serial.list()[2]; //change the 0 to a 1 or 2 etc. to match your port
String portAccel = Serial.list()[3];

BaseScene[] scenes = new BaseScene[3];
int currentScene = 0;

void setup()
{
 myPort = new Serial(this, portFire, 9600);
 myPort2 = new Serial(this, portAccel, 9600);
 myPort.bufferUntil('\n');
 myPort2.bufferUntil('\n');

 scenes[0] = new HikingScene(); 
 scenes[1] = new FireScene();
 scenes[2] = new StarScene();
}

void draw()
{
 scenes[currentScene].draw(); 
}


void mousePressed()
{
   scenes[currentScene].mousePress();
}

void setScene(int id)
{
 currentScene = id; 
}
