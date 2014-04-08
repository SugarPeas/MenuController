import processing.serial.*;
import processing.video.*;

Serial myPort;  // Create object from Serial class
Serial myPort2;

String portFire = Serial.list()[2]; //change the 0 to a 1 or 2 etc. to match your port
String portAccel = Serial.list()[3];

BaseScene[] scenes = new BaseScene[4];
int currentScene = 0;

void setup()
{
  frameRate(30);
   size(displayWidth,displayHeight);
 myPort = new Serial(this, portFire, 9600);
 //myPort2 = new Serial(this, portAccel, 9600);
 
 myPort.bufferUntil('\n');
 //myPort2.bufferUntil('\n');

 scenes[0] = new MontageScene(this);
 scenes[1] = new HikingScene(this); 
 scenes[2] = new ClimbingScene(this);
 scenes[3] = new PanoScene(this);
 
 scenes[0].begin();
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
 if(id == 0)
 {
  scenes[id].begin(); 
 }
}

void movieEvent(Movie m) {
  m.read();
}
