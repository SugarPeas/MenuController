import processing.serial.*;
Serial myPort;  // Create object from Serial class
String portName = Serial.list()[2]; //change the 0 to a 1 or 2 etc. to match your port

BaseScene[] scenes = new BaseScene[4];
int currentScene = 0;

void setup()
{
 myPort = new Serial(this, portName, 9600); 

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
