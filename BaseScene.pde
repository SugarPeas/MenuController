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
float movieX;
float movieY;
float movieTransparency = 0;

//used to display instruction animations
PImage[] gifAnimation;
int gifFrame;
float gifX;
float gifY;
 
//handles animation fade in and out
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
void draw()
{ 
    background(0);
    
    //if near beginning of video, fade in
    if(myMovie.getCurrentTime() < 1 && (movieTransparency + 10) <= 255){ movieTransparency += 10; }
    //if near the end of video, fade out
    else if(myMovie.getDuration() - myMovie.getCurrentTime() < 1 && (movieTransparency - 10) >= 0 ){ movieTransparency -= 10; }
    //if reached end of video, go to next scene
    else if(myMovie.getCurrentTime() == myMovie.getDuration()){ mousePress(); }
}


//---------------------------------------- 
//PLAYS ANIMATED GIF FILES FOR VIDEO
//----------------------------------------
void playGIF(String fade)
{   
  println("play gif");
  //fade in
  if(fade == "fadeIn"){ 
    if( gifTransparency + 10 > 180 ){ gifTransparency = 180; }
    else{ gifTransparency += 10; }
  }
  //fade out
  else if(fade == "fadeOut"){
    if( gifTransparency - 10 < 0.0 ){ gifTransparency = 0.0; }
    else{ gifTransparency -= 10; }
  }
   
  //display current GIF frame
  tint(255, gifTransparency); 
  image(gifAnimation[gifFrame], gifX, gifY);
   
  //move onto next GIF frame, if more exist
  if(gifAnimation.length > gifFrame+1){ gifFrame++; }
  //loop back to the beginning
  else{ gifFrame = 0; }   
}

 
 
//---------------------------------------------
//HANDLES MOUSE CLICK - DISPLAY THE NEXT SCENE
//--------------------------------------------- 
void mousePress() { setScene(0); }

}//end class
