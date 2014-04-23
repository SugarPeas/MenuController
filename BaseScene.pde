//---------------------------------------------------------------
//SKETCH CONTAINS BASE PROPERTIES / FUNCTIONALITY FOR ALL SCENES
//--------------------------------------------------------------- 
class BaseScene
{
  
//----------------------------------------
//VARIABLES
//----------------------------------------
PApplet parent;
String val; //Stores serial messages from arduino

//handles video playback
JMCMovie myMovie;
float movieX = (displayWidth - 1280) / 2;
float movieY = (displayHeight - 720) / 2;
float movieTransparency = 0;

//used to display instruction animations
PImage[] gifAnimation;
int gifFrame;
float gifX;
float gifY;
 
//handles animation fade in and out
double instructionStart;
double instructionEnd;
double fadeLength;
float gifTransparency;
 
 
//----------------------------------------
//CONSTRUCTOR
//----------------------------------------
BaseScene(PApplet pa){parent = pa;}
 
 
//----------------------------------------
//SCENE SETUP
//----------------------------------------
void begin(){ }
 
 
//----------------------------------------
//DISPLAY THE SCENE
//----------------------------------------
void draw(){ }


//---------------------------------------- 
//HANDLES ARDUINO INTERACTION
//----------------------------------------
void userInteraction(){ println("User Interaction"); }


//---------------------------------------- 
//PLAYS ANIMATED GIF FILES
//----------------------------------------
void playGIF()
{   
  //fade in
  if( myMovie.getCurrentTime() - instructionStart <= fadeLength ){ 
    if( gifTransparency + 25 > 175 ){ gifTransparency = 175; }
    else{ gifTransparency += 25; }
  }
  //fade out
  else if( instructionEnd - myMovie.getCurrentTime() <= fadeLength ){
    if( gifTransparency - 25 < 0.0 ){ gifTransparency = 0.0; }
    else{ gifTransparency -= 25; }
  }
 
  //display current GIF frame
  tint(255, gifTransparency); 
  image(gifAnimation[gifFrame], gifX, gifY);
   
  //display next GIF frame, if more exist
  if(gifAnimation.length > gifFrame+1){
    gifFrame++; 
  }
  //animation loops back to the beginning
  else{
    gifFrame = 0;
  }  
}

 
 
//---------------------------------------------
//HANDLES MOUSE CLICK - DISPLAY THE NEXT SCENE
//--------------------------------------------- 
void mousePress() { setScene(0); }

}//end class
