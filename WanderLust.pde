import processing.serial.*;
Serial myPort;  // Create object from Serial class
Serial myPort2;
String portFire = Serial.list()[2]; //change the 0 to a 1 or 2 etc. to match your port
String portAccel = Serial.list()[3];

BaseScene[] scenes = new BaseScene[4];
int currentScene = 0;

void setup()
{
 myPort = new Serial(this, portFire, 9600);
 myPort2 = new Serial(this, portAccel, 9600);

 scenes[0] = new MenuScene();
 scenes[1] = new HikingScene(); 
 scenes[2] = new FireScene();
 scenes[3] = new StarScene();
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
