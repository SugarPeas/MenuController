import processing.serial.*;
import processing.video.*;
import processing.opengl.*;

// Create object from Serial class
Serial myPort;  
Serial myPort2;
Serial myPort3;


String portClimb = Serial.list()[2]; //change the 0 to a 1 or 2 etc. to match your port
String portAccel = Serial.list()[3];
String portPano = Serial.list()[5];

BaseScene[] scenes = new BaseScene[4];
int currentScene = 3;

void setup()
{
 frameRate(30);
 size(1024,768, OPENGL);
// myPort = new Serial(this, portClimb, 9600);
// myPort2 = new Serial(this, portAccel, 9600);
 myPort3 = new Serial(this, portPano, 9600);
 
// myPort.bufferUntil('\n');
// myPort2.bufferUntil('\n');
 myPort3.bufferUntil('\n');

 scenes[0] = new MontageScene(this);
 scenes[1] = new HikingScene(this); 
 scenes[2] = new ClimbingScene(this);
 scenes[3] = new PanoScene(this);
 
 scenes[currentScene].begin();
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
