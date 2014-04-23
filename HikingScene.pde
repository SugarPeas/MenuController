//----------------------------------------
//SKETCH CONTROLS HIKING SCENE
//---------------------------------------- 
class HikingScene extends BaseScene{
    
//----------------------------------------
//CONSTRUCTOR
//----------------------------------------  
HikingScene(PApplet pa){ super(pa); }
  
  
//---------------------------------------- 
//SCENE SETUP
//----------------------------------------
void begin()
{ 
  //video init and setup
  myMovie = new JMCMovie(parent, "hiking.mov", RGB);
  myMovie.play();
  
  //animation init and setup
  gifAnimation = Gif.getPImages(parent, "hiking.gif");
  gifFrame = 0;
  gifTransparency = 0;
   
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
  super.draw();
  
  //display frame
  tint(255, movieTransparency);
  image(myMovie, movieX, movieY);
}
 
 
//---------------------------------------- 
//HANDLES ARDUINO INTERACTION
//----------------------------------------
void userInteraction()
{ 
  //if data is available...
  if(hikePort.available() > 0){
      val = hikePort.readStringUntil('\n'); //store data
      if(val != null){ 
        //play next video
      } //trigger next video section
  }
}


//---------------------------------------- 
//ADVANCE TO NEXT SCENE - CLIMBING
//----------------------------------------
void mousePress() 
{
  myMovie.dispose();
  setScene(2);
}
  
}//end class
