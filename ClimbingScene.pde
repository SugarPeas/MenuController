//----------------------------------------
//SKETCH CONTROLS ROCK CLIMBING SCENE
//---------------------------------------- 
class ClimbingScene extends BaseScene{
 
  
//----------------------------------------
//VARIABLES
//----------------------------------------
int currentKey;
double[] startKeys;
double[] endKeys;
boolean reverse;

double instructionStart;
double instructionEnd;

  
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
   
  //define video sections
  currentKey = 0;
  startKeys = new double[]{ 00.0, 14.0, 19.0, 29.0, 31.0, 43.0, 45.0 };
  endKeys   = new double[]{ 14.0, 19.0, 28.0, 31.0, 43.0, 45.0, 54.0 };
                         // start loop  play  loop  play  loop  play
  
  //animation init and setup
  gifAnimation = Gif.getPImages(parent, "climbing.gif");
  gifFrame = 0;
  gifTransparency = 0;
   
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
             
    //if current key is even
    if( currentKey % 2 == 0 || currentKey == 0){
      
        //if video is between keyframes...
        if( myMovie.getCurrentTime() >= startKeys[currentKey] && myMovie.getCurrentTime() < endKeys[currentKey] ){
              
            //keep playing
            tint(255, movieTransparency);
            image(myMovie, movieX, movieY);

        }        
        //if reached end of video section, trigger loop
        else{ nextKey(); }
        
    }
    //if current key is odd
    else{
        
        //slow down the video
        if( myMovie.getRate() - 0.05 > 0 ){
          myMovie.changeRate(-0.05);
        }
                
        //keep playing
        tint(255, 255);
        image(myMovie, movieX, movieY); 
        
        //overlay
        fill(255, 255, 255, 200);
        rect(0, 0, displayWidth, displayHeight); 
        
        //play gif
        playGIF();
        
        //wait for user interaction to trigger next section
        userInteraction();
    
    }
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
//TRIGGERS NEXT SECTION OF VIDEO PLAYBACK
//----------------------------------------
void nextKey()
{
   //update current video keyframe, if more exist   
   if(startKeys.length > currentKey+1){
     currentKey++; 
   }
}


//---------------------------------------- 
//ADVANCE TO NEXT SCENE - PANORAMIC
//----------------------------------------
void mousePress() 
{
  myMovie.dispose();
  setScene(3);
}
  
}//end class
