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
    if(myMovie.getCurrentTime() < 1 && (movieTransparency + 8.5) <= 255){ movieTransparency += 8.5; }
    //if near the end of video, fade out
    else if(myMovie.getDuration() - myMovie.getCurrentTime() < 1 && (movieTransparency - 8.5) >= 0 ){ movieTransparency -= 8.5; }
    //if reached end of video, go to next scene
    else if(myMovie.getCurrentTime() == myMovie.getDuration()){ mousePress(); }
}


//---------------------------------------- 
//PLAYS ANIMATED GIF FILES FOR VIDEO
//----------------------------------------
void playGIF(double gifStart, double gifEnd)
{   
  double fadeLength = (gifEnd - gifStart) * .15;
  
  //fade in
  if( myMovie.getCurrentTime() - gifStart <= fadeLength ){ 
    if( gifTransparency + 25 > 175 ){ gifTransparency = 175; }
    else{ gifTransparency += 25; }
  }
  //fade out
  else if( gifEnd - myMovie.getCurrentTime() <= fadeLength ){
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
