//----------------------------------------
//SKETCH CONTROLS ROCK CLIMBING SCENE
//---------------------------------------- 
class ClimbingScene extends BaseScene{
 
  
//----------------------------------------
//VARIABLES
//----------------------------------------

//is user climbing?
boolean climbing = false;

//controls playing video
int savedPlayTime;
int playTime = 10000;

//controls pausing video
int savedPauseTime;
int pauseTime = 20000;

//controls fading overlay
int savedOverlayTime;
int overlayTime = 2000;
float overlayTransparency = 0;

//controls fading gif
int savedGifTime;
int gifTime = 2000;

boolean fadeIn = true;



  
//----------------------------------------
//CONSTRUCTOR
//---------------------------------------- 
ClimbingScene(PApplet pa){ super(pa); }

  
//---------------------------------------- 
//SCENE SETUP
//----------------------------------------
void begin()
{ 
  //video init and setup
  myMovie = new JMCMovie(parent, "climb_converted.mov", RGB);
  myMovie.play();
  
  //used to center video
  movieX = (displayWidth - 1920) / 2;
  movieY = (displayHeight - 1080) / 2;
  
  //animation init and setup
  gifAnimation = Gif.getPImages(parent, "climbing.gif");
  gifFrame = 0;
  gifTransparency = 0;
   
  //used to center animation
  gifX = (displayWidth - gifAnimation[0].width) / 2;
  gifY = (displayHeight - gifAnimation[0].height) / 2;
  
  //timers
  savedPauseTime = millis();
  savedOverlayTime = millis();
  savedGifTime = millis();
}
  
  
  
//----------------------------------------
//DISPLAY THE SCENE
//----------------------------------------
void draw()
{
    super.draw();
    
    //waiting for user interaction...
    if(!climbing){
      
        //give user time to respond, if they don't pause the video
        if(millis() - savedPauseTime > pauseTime){ myMovie.pause(); }
        //slow down the video
        else{
            if(myMovie.getRate() - 0.01 > 0.2){ myMovie.changeRate(-0.01); }
        }
        
        //wait for user interaction to trigger next section
        userInteraction(); 
    }
    else if(climbing){
      
        //play 5 seconds then wait for user interaction again
        if(millis() - savedPlayTime > playTime){  
            //stop climbing
            climbing = false;
            fadeIn = true; 
            
            //restart timers
            savedPlayTime = millis();
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
 

void overlay(String fade)
{
    //overlay
    if(fade == "fadeIn" && overlayTransparency + 10 <= 180){ overlayTransparency += 10; }
    else if(fade == "fadeOut" && overlayTransparency - 10 >= 0){ overlayTransparency -= 10; }
    
    fill(255, 255, 255, overlayTransparency);
    rect(0, 0, displayWidth, displayHeight); 
}

 
//---------------------------------------- 
//HANDLES ARDUINO INTERACTION
//----------------------------------------
void userInteraction()
{
  //wait for user to trigger next section
  //if data is available...
  if(climbPort.available() > 0){  
      val = climbPort.readStringUntil('\n'); //store data
      
      if(val != null){ 
        
          //if rotary encoder is turning, trigger climbing action
          if(val.trim().equals("climb")){ 
              
              //start playing video
              climbing = true;
              fadeIn = false;
              
              //restart timers
              savedPlayTime = millis();
              savedOverlayTime = millis();
              savedGifTime = millis();
              
          } 
      }
  }
}//end userInteraction



//---------------------------------------- 
//ADVANCE TO NEXT SCENE - PANORAMIC
//----------------------------------------
void mousePress() 
{
  myMovie.dispose();
  setScene(3);
}
  
}//end class
