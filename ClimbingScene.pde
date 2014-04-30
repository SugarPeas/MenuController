//----------------------------------------
//SKETCH CONTROLS ROCK CLIMBING SCENE
//---------------------------------------- 
class ClimbingScene extends BaseScene{
  
//----------------------------------------
//CONSTRUCTOR
//---------------------------------------- 
ClimbingScene(PApplet pa){ super(pa); }


float progressY;


//---------------------------------------- 
//SCENE SETUP
//----------------------------------------
void begin()
{   
  //video init and setup
  myMovie = new JMCMovie(parent, "climbing.mov", RGB);
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
  
  //start timers
  savedPauseTime = millis();
  savedFadeTime = millis();
  
  progressY = displayHeight - 60;
}
  
  
  
//----------------------------------------
//DISPLAY THE SCENE
//----------------------------------------
void draw()
{
    background(0);
    interactiveVideo();
    

    //calculate progress bar location
    progressY = lerp( (float)displayHeight-60 , 60.0, (float)myMovie.getPlaybackPercentage() );
    
    //progress bar
    fill(255, 150);
    stroke(255);
    strokeWeight(2);
    line(displayWidth-60, 60, displayWidth-60, displayHeight-60);
    ellipse(displayWidth - 60, progressY, 30, 30);
    
    super.draw();
  
  
    
    
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
              working = true;
              fadeIn = false;
              
              //restart timers
              savedPlayTime = millis();
              savedFadeTime = millis();
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
  advanceScene();
}
  
}//end class
