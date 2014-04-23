//----------------------------------------
//SKETCH CONTROLS HIKING SCENE
//---------------------------------------- 
class HikingScene extends BaseScene{
  
double instructionStart;
double instructionEnd;
    
//----------------------------------------
//CONSTRUCTOR
//----------------------------------------  
HikingScene(PApplet pa){ super(pa); }
  
  
//---------------------------------------- 
//SCENE SETUP
//----------------------------------------
void begin()
{ 
  
  movieX = (displayWidth - 1920) / 2;
  movieY = (displayHeight - 1080) / 2;

  //video init and setup
  myMovie = new JMCMovie(parent, "Hiking_Video2.mov", RGB);
  myMovie.play();
  
  //animation init and setup
  gifAnimation = Gif.getPImages(parent, "hiking.gif");
  gifFrame = 0;
  gifTransparency = 0; 
   
  //used to center animation
  gifX = (displayWidth - gifAnimation[0].width) / 2;
  gifY = (displayHeight - gifAnimation[0].height) / 2;
  
  instructionStart = 1.0;
  instructionEnd = 4.0;
}
  
  
  
//---------------------------------------- 
//DISPLAY THE SCENE
//----------------------------------------
void draw()
{ 
  super.draw();
  
  if(myMovie.getCurrentTime() >= instructionStart && myMovie.getCurrentTime() <= instructionEnd){
    playGIF(instructionStart, instructionEnd);
  }
  
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
