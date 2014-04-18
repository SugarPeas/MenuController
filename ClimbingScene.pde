//----------------------------------------
//SKETCH CONTROLS ROCK CLIMBING SCENE
//---------------------------------------- 
class ClimbingScene extends BaseScene{
 
//----------------------------------------
//CONSTRUCTOR
//---------------------------------------- 
ClimbingScene(PApplet pa){super(pa);}
 
  
//---------------------------------------- 
//SCENE SETUP
//----------------------------------------
void begin()
{   
  //video init and setup
  myMovie = new JMCMovie(parent, "climbing.mov", RGB);
  myMovie.frameImage();
  myMovie.play();
   
  //define video sections
  currentKey = 0;
  startKeys = new double[]{ 00.00, 14.00, 20.15, 42.00, 47.00, 56.00, 58.25, 71.01, 73.05 };
  endKeys = new double[]{ 14.00, 20.15, 42.00, 47.00, 56.00, 58.25, 71.01, 73.05, 85.09 };
   
  //animation init and setup
  gifAnimation = Gif.getPImages(parent, "climbing.gif");
  gifFrame = 0;
  transparency = 0;
   
  //figure out how long fading in/out should take
  instructionStart = 11.00;
  instructionEnd   = 14.00;
  fadeLength = (instructionEnd - instructionStart) * .15; 
   
  //used to center animation
  gifX = (displayWidth - gifAnimation[0].width) / 2;
  gifY = (displayHeight - gifAnimation[0].height) / 2;
}
  
  
  
//---------------------------------------- 
//DISPLAY THE SCENE
//----------------------------------------
void draw()
{  
  videoPlayback(); 
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
          if(val.trim().equals("climb")){ nextKey(); } //if rotary encoder is turning, trigger climbing action
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
