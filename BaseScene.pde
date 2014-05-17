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
int playTime = 5000;

//controls pausing video
int savedPauseTime;
int pauseTime = 5000;

//used to display instruction animations
PImage[] gifAnimation;
int gifFrame;
float gifX;
float gifY;

//controls fading overlay & gif
boolean fadeIn = true;
int savedFadeTime;
int fadeTime = 2000;
float overlayTransparency = 0;
float gifTransparency = 0;

//controls video progress bar
float progressY;
float progressTransparency = 0;

//is user interacting?
boolean working = false;
 
 
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
    //if near beginning of video, fade in
    if(myMovie.getCurrentTime() < 1){
        if(movieTransparency + 50 > 255){ movieTransparency = 255; }
        else{ movieTransparency += 50; }
    }
    //if near the end of video, fade out
    else if(myMovie.getDuration() - myMovie.getCurrentTime() < 1){
        if(movieTransparency - 50 < 0){ movieTransparency = 0; }
        else{ movieTransparency -= 50; }
    }
    
    //if reached end of video, go to next scene
    if(myMovie.getCurrentTime() == myMovie.getDuration()){ mousePress(); }
}


//----------------------------------------
//HANDLES VIDEO INTERACTION
//----------------------------------------
void interactiveVideo()
{  
    //waiting for user interaction...
    if(working == false){
            
        //give user time to respond, if they don't pause the video
        if(millis() - savedPauseTime > pauseTime){ myMovie.pause(); }
        //slow down the video
        else{
            if(myMovie.getRate() - 0.05 > 0.5){ myMovie.changeRate(-0.05); }
        }
        
        //wait for user interaction to trigger next section
        userInteraction(); 
    }
    //playing next chunk of video
    else if(working){
      
        //clear out the serial buffer 
        if(millis() - savedPlayTime < playTime - 1000){ clearPort(); }
        
        //play 10 seconds then wait for user interaction again
        if(millis() - savedPlayTime > playTime){  
            //stop climbing
            working = false;
            fadeIn = true; 
            
            //restart timers
            savedPauseTime = millis();
            savedFadeTime = millis();
        }
        //speed video back up
        else{
            if(myMovie.getRate() + 0.05 < 1.0){ myMovie.changeRate(0.05); }
        }
        
        //restart video if paused
        if(myMovie.isPlaying() == false){ myMovie.play(); } 
    }
    
        
    //show video frame
    tint(255, movieTransparency);
    image(myMovie, 0, 0);
    
    
    //fade in progress bar
    if(myMovie.getCurrentTime() < 1){ progressBar("fadeIn"); }
    //fade out progress bar
    else if(myMovie.getDuration() - myMovie.getCurrentTime() < 1){ progressBar("fadeOut"); }
    //else display progress bar
    else{ progressBar(""); }
    
    
    // fade/show overlay & gif
    if(millis() - savedFadeTime < fadeTime && fadeIn){ 
        overlay("fadeIn"); 
        playGIF("fadeIn"); 
    }
    else if(millis() - savedFadeTime < fadeTime && !fadeIn){ 
        overlay("fadeOut"); 
        playGIF("fadeOut");
    }
    else{ 
        overlay("");
        playGIF(""); 
    }
}


//------------------------------------------ 
//FADES AND DISPLAYS THE VIDEO PROGRESS BAR
//------------------------------------------
void progressBar(String fade)
{
    //handles fading in and out
    if(fade == "fadeIn"){ 
      if( progressTransparency + 25 > 175 ){ progressTransparency = 175; }
      else{ progressTransparency += 25; }
    }
    else if(fade == "fadeOut"){ 
      if( progressTransparency - 25 < 0.0 ){ progressTransparency = 0.0; }
      else{ progressTransparency -= 25; }
    }
  
    //calculate progress bar location
    progressY = lerp( (float)displayHeight-80 , 80.0, (float)myMovie.getPlaybackPercentage() );
    
    //progress bar
    fill(255, progressTransparency);
    stroke(255, progressTransparency);
    strokeWeight(2);
    strokeCap(ROUND);
    line(myMovie.width-900, 80, myMovie.width-900, displayHeight-80);
    ellipse(myMovie.width - 900, progressY, 30, 30);
}


//---------------------------------------- 
//FADES AND DISPLAYS THE VIDEO OVERLAY
//----------------------------------------
void overlay(String fade)
{
    //handles fading in and out
    if(fade == "fadeIn"){ 
      if( overlayTransparency + 25 > 125 ){ overlayTransparency = 125; }
      else{ overlayTransparency += 25; }
    }
    else if(fade == "fadeOut"){ 
      if( overlayTransparency - 25 < 0.0 ){ overlayTransparency = 0.0; }
      else{ overlayTransparency -= 25; }
    }
    
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
//CLEARS SERIAL PORT BUFFER
//----------------------------------------
void clearPort(){ }

//---------------------------------------- 
//HANDLES ARDUINO INTERACTION
//----------------------------------------
void userInteraction(){ }

 
//---------------------------------------------
//HANDLES MOUSE CLICK - DISPLAY THE NEXT SCENE
//--------------------------------------------- 
void mousePress(){ setScene(0); }


}//end class
