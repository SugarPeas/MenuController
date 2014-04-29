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

//setup video display
JMCMovie myMovie;
float movieX;
float movieY;
float movieTransparency = 0;

//controls playing video
int savedPlayTime;
int playTime = 20000;

//controls pausing video
int savedPauseTime;
int pauseTime = 10000;

//used to display instruction animations
PImage[] gifAnimation;
int gifFrame;
float gifX;
float gifY;

//controls fading gif
int savedGifTime;
int gifTime = 2000;
float gifTransparency;

//is user interacting?
boolean working = false;

//controls fading overlay
int savedOverlayTime;
int overlayTime = 2000;
float overlayTransparency = 0;
boolean fadeIn = true;
 
 
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
//HANDLES VIDEO INTERACTION
//----------------------------------------
void interactiveVideo()
{
    //waiting for user interaction...
    if(!working){
      
        //give user time to respond, if they don't pause the video
        if(millis() - savedPauseTime > pauseTime){ myMovie.pause(); }
        //slow down the video
        else{
            if(myMovie.getRate() - 0.01 > 0.2){ myMovie.changeRate(-0.01); }
        }
        
        //wait for user interaction to trigger next section
        userInteraction(); 
    }
    //playing next chunk of video
    else if(working){
      
        //play 5 seconds then wait for user interaction again
        if(millis() - savedPlayTime > playTime){  
            //stop climbing
            working = false;
            fadeIn = true; 
            
            //restart timers
            savedPauseTime = millis();
            savedOverlayTime = millis();
            savedGifTime = millis();
         }
        //speed video back up
        else{
            if(myMovie.getRate() + 0.01 < 1.0){ myMovie.changeRate(0.01); }
        }
        
        //restart video if paused
        if(myMovie.isPlaying() == false){ myMovie.play(); } 
    }
        
    //show frame
    tint(255, movieTransparency);
    image(myMovie, movieX, movieY);
    
    // fade/show overlay
    if(millis() - savedOverlayTime < overlayTime && fadeIn){ overlay("fadeIn"); }
    else if(millis() - savedOverlayTime < overlayTime && !fadeIn){ overlay("fadeOut"); }
    else{ overlay(""); }
    
    // fade/play instructional gif
    if(millis() - savedGifTime < gifTime && fadeIn){ playGIF("fadeIn"); }
    else if(millis() - savedGifTime < gifTime && !fadeIn){ playGIF("fadeOut"); }
    else{ playGIF(""); }
}


//---------------------------------------- 
//FADES AND DISPLAYS THE VIDEO OVERLAY
//----------------------------------------
void overlay(String fade)
{
    //handles fading in and out
    if(fade == "fadeIn" && overlayTransparency + 10 <= 180){ overlayTransparency += 10; }
    else if(fade == "fadeOut" && overlayTransparency - 10 >= 0){ overlayTransparency -= 10; }
    
    //show overlay
    fill(255, 255, 255, overlayTransparency);
    rect(0, 0, displayWidth, displayHeight); 
}


//---------------------------------------- 
//FADES AND PLAYS ANIMATED GIF FILES
//----------------------------------------
void playGIF(String fade)
{   
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


//---------------------------------------- 
//HANDLES ARDUINO INTERACTION
//----------------------------------------
void userInteraction()
{

}

 
//---------------------------------------------
//HANDLES MOUSE CLICK - DISPLAY THE NEXT SCENE
//--------------------------------------------- 
void mousePress() { setScene(0); }

}//end class
