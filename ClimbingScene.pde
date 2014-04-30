//----------------------------------------
//SKETCH CONTROLS ROCK CLIMBING SCENE
//---------------------------------------- 
class ClimbingScene extends BaseScene{
  
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
  savedOverlayTime = millis();
  savedGifTime = millis();
}
  
  
  
//----------------------------------------
//DISPLAY THE SCENE
//----------------------------------------
void draw()
{
  background(0);
  interactiveVideo();
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
  println("climb mousePress");
  
  myMovie.dispose();
  advanceScene();
}
  
}//end class
