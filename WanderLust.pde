import processing.serial.*;
import processing.video.*;

// Create object from Serial class
Serial climbPort;  
Serial panoPort;
Serial hikePort;

String portClimb = Serial.list()[2]; //change the 0 to a 1 or 2 etc. to match your port
String portPano = Serial.list()[3];
String portHike = Serial.list()[2];

BaseScene[] scenes = new BaseScene[4];
int currentScene = 0;

void setup()
{
 frameRate(30);
 size(displayWidth,displayHeight);
 climbPort = new Serial(this, portClimb, 9600);
 panoPort = new Serial(this, portPano, 9600);
 hikePort = new Serial(this, portHike, 9600);
 
 climbPort.bufferUntil('\n');
 panoPort.bufferUntil('\n');
 hikePort.bufferUntil('\n');

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
 scenes[id].begin(); 
}

void movieEvent(Movie m) {
  m.read();
}
