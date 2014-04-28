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
   
  //define video sections
  currentKey = 0;
  startKeys = new double[]{ 00.0, 14.0, 19.0, 29.0, 31.0, 43.0, 45.0 };
  endKeys   = new double[]{ 14.0, 19.0, 28.0, 31.0, 43.0, 45.0, 54.0 };
                         // start loop  play  loop  play  loop  play
  reverse = false;
  
  movieX = (displayWidth - 1920) / 2;
  movieY = (displayHeight - 1080) / 2;
  
  //animation init and setup
  gifAnimation = Gif.getPImages(parent, "climbing.gif");
  gifFrame = 0;
  gifTransparency = 0;
  
  //define when instructions should fade in or out
  instructionStart = 11.00;
  instructionEnd   = 14.00;
   
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
            
            //show interaction instructions
            if( myMovie.getCurrentTime() >= instructionStart && myMovie.getCurrentTime() < instructionEnd ){ playGIF(instructionStart, instructionEnd); }
        }        
        //if reached end of video section, trigger loop
        else{ nextKey(); }
        
    }
    //if current key is odd
    else{
        
        //figure out which direction we need to play in
        if( myMovie.getCurrentTime() > endKeys[currentKey] ){ reverse = true; myMovie.setRate(-1.0); }
        else if( myMovie.getCurrentTime() < startKeys[currentKey] ){ reverse = false; myMovie.setRate(1.0); }
        
        //handles playback speed and easing 
//        if( !reverse && endKeys[currentKey] - myMovie.getCurrentTime() < .5 && myMovie.getRate() > -1.0 ){ myMovie.changeRate(-0.06); }
//        else if ( reverse && endKeys[currentKey] - myMovie.getCurrentTime() < .5 && myMovie.getRate() < 1.0 ){ myMovie.changeRate(0.06); }
//        else if( reverse && myMovie.getCurrentTime() - startKeys[currentKey] < .5 && myMovie.getRate() > -1.0 ){ myMovie.changeRate(-0.06); }
//        else if( !reverse && myMovie.getCurrentTime() - startKeys[currentKey] < .5 && myMovie.getRate() < 1.0 ){ myMovie.changeRate(0.06); }
        
        //keep looping
        tint(255, 255);
        image(myMovie, movieX, movieY);  
          
        //wait for user interaction to trigger next section
        userInteraction();
    
    }//end else
    
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
