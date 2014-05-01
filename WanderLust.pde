//----------------------------------------
//IMPORT NECESSARY LIBRARIES
//---------------------------------------- 
import processing.serial.*;
import jmcvideo.*;
import processing.opengl.*;
import gifAnimation.*;


//----------------------------------------
//VARIALBLES
//----------------------------------------

//handles serial port connection / communication
Serial climbPort;  
Serial panoPort;
Serial hikePort;
String portClimb = Serial.list()[6]; //9 = 14231
String portPano = Serial.list()[2];  //8 = 14221
String portHike = Serial.list()[7];  //7 = 14211

//handles various scenes 
BaseScene[] scenes = new BaseScene[4];
int currentScene = 0;

//display sketch full screen
boolean sketchFullScreen(){return true;}


//----------------------------------------
//SKETCH SETUP
//----------------------------------------
void setup()
{
 //display settings
 frameRate(30);
 size(displayWidth,displayHeight,P3D);
 
 //setup serial port connections - used to communicate with arduino boards
 climbPort = new Serial(this, portClimb, 9600);
// panoPort = new Serial(this, portPano, 9600);
 hikePort = new Serial(this, portHike, 9600);
 
 climbPort.bufferUntil('\n');
// panoPort.bufferUntil('\n');
 hikePort.bufferUntil('\n');
 
 //define the scenes
 scenes[0] = new MontageScene(this);
 scenes[1] = new HikingScene(this); 
 scenes[2] = new ClimbingScene(this);
 scenes[3] = new PanoScene(this);
 

 //start the first scene - intro montage video
 scenes[currentScene].begin(); 
}


//----------------------------------------
//DISPLAYS CURRENT SCENE
//----------------------------------------
void draw(){ scenes[currentScene].draw(); }


//----------------------------------------
//DISPLAY THE NEXT SCENE
//----------------------------------------
void setScene(int id){
  currentScene = id;
  scenes[id].begin(); 
}


//------------------------------------------
//HANDLES MOUSE CLICK EVENT
//------------------------------------------
void mouseReleased(){ scenes[currentScene].mousePress(); }
