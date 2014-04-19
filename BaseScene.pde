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

//handles video playback and looping
JMCMovie myMovie;
int currentKey;
double[] startKeys;
double[] endKeys;
 
//used to display instruction animation
PImage[] gifAnimation;
int gifFrame;
float gifX;
float gifY;
 
//handles animation fade in and out
double instructionStart;
double instructionEnd;
double fadeLength;
float transparency;
 
 
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
//HANDLES VIDEO PLAYBACK AND LOOPING
//----------------------------------------
void videoPlayback()
{
    //if current key is even
    if( currentKey % 2 == 0 || currentKey == 0){
      
        //if video is between keyframes...
        if( myMovie.getCurrentTime() >= startKeys[currentKey] && myMovie.getCurrentTime() < endKeys[currentKey] ){
              
            //keep playing
            tint(255, 255);
            myMovie.centerImage();  
            
            //show interaction instructions
            if( myMovie.getCurrentTime() >= instructionStart && myMovie.getCurrentTime() < instructionEnd ){
                playGIF();
            }
        }        
        //if reached end of video section, trigger loop
        else{ nextKey(); }
    }
    //if current key is odd
    else{
    
        //if reached end of section, play video in reverse
        if( myMovie.getCurrentTime() > endKeys[currentKey] ){
            myMovie.setRate(-1.0);  
        }
        else if( myMovie.getCurrentTime() < startKeys[currentKey] ){
            myMovie.setRate(1.0);  
        }
        
        //keep looping
        tint(255, 255);
        myMovie.centerImage();  
          
        //wait for user interaction to trigger next section
        userInteraction();
    
    }//end else
    
    
    //if reached end of video, go to next scene
    if(myMovie.getCurrentTime() == myMovie.getDuration()){ mousePress(); }
}


//---------------------------------------- 
//HANDLES ARDUINO INTERACTION
//----------------------------------------
void userInteraction(){ }


//---------------------------------------- 
//PLAYS ANIMATED GIF FILES
//----------------------------------------
void playGIF()
{   
  //fade in
  if( myMovie.getCurrentTime() - instructionStart <= fadeLength ){ 
    if( transparency + 25 > 255 ){ transparency = 255; }
    else{ transparency += 25; }
  }
  //fade out
  else if( instructionEnd - myMovie.getCurrentTime() <= fadeLength ){
    if( transparency - 25 < 0.0 ){ transparency = 0.0; }
    else{ transparency -= 25; }
  }
 
  //display current GIF frame
  tint(255, transparency); 
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


//---------------------------------------- 
//TRIGGERS NEXT SECTION OF VIDEO PLAYBACK
//----------------------------------------
void nextKey()
{
   //update current video keyframe, if more exist   
   if(startKeys.length > currentKey+1){
     currentKey++; 
   }
}
 
 
//---------------------------------------------
//HANDLES MOUSE CLICK - DISPLAY THE NEXT SCENE
//--------------------------------------------- 
void mousePress() {
  setScene(0);
}

}//end class
