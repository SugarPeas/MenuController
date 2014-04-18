import jmcvideo.*;
import processing.opengl.*;
import gifAnimation.*;

class ClimbingScene extends BaseScene{
 
  
 //----------------------------------------
 //VARIABLES
 //---------------------------------------- 
 
 //handles video playback and looping
 JMCMovie climbMovie;
 int currentKey;
 double[] startKeys;
 double[] endKeys;
 
 //used to display instruction animation
 PImage[] gifAnimation;
 int gifFrame;
 float gifX;
 float gifY;
 
 //handles animation fade in and out
 double instructionStart;
 double instructionEnd;
 double fadeLength;
 float transparency;
 
 
 ClimbingScene(PApplet pa){
   super(pa);
 }
 
 
  
 //---------------------------------------- 
 //SCENE SETUP
 //----------------------------------------
 void begin(){
   
   //video init and setup
   climbMovie = new JMCMovie(parent, "climbing.mov", RGB);
   climbMovie.frameImage();
   climbMovie.play();
   
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
 //DRAW LOOP
 //----------------------------------------
 void draw(){
    
   
    //if current key is even
    if( currentKey % 2 == 0 || currentKey == 0){
            
      //if video is between keyframes...
      if( climbMovie.getCurrentTime() >= startKeys[currentKey] && climbMovie.getCurrentTime() < endKeys[currentKey] ){
                
        //keep playing
        tint(255, 255);
        climbMovie.centerImage();  
        
        if( climbMovie.getCurrentTime() >= instructionStart && climbMovie.getCurrentTime() < instructionEnd ){
        
          //play instructions gif
          playGIF();
          
        }
        
      }
      //if reached end of video
      else if(climbMovie.getCurrentTime() == climbMovie.getDuration()){
        mousePress(); //go to next scene
      }
      //if reached end of video section, trigger loop
      else{
        nextKey();
      }
      
    }
    
    //if current key is odd
    else{
      
      //if reached end of section, play video in reverse
      if( climbMovie.getCurrentTime() > endKeys[currentKey] ){
        climbMovie.setRate(-1.0);  
      }
      else if( climbMovie.getCurrentTime() < startKeys[currentKey] ){
        climbMovie.setRate(1.0);  
      }
      
      tint(255, 255);
      climbMovie.centerImage();  
          
      //wait for user to trigger next section
      //if data is available...
      if(climbPort.available() > 0){  
        
        //store data
        val = climbPort.readStringUntil('\n');      
        if(val != null){
          
          //if rotary encoder is turning, trigger climbing action
          if(val.trim().equals("climb")){ 
            climbMovie.isBouncing = false;            
            nextKey(); 
          }
        
        }//end if 
      }//end if
      
    }//end else
  
  
 }//end draw()
 
 

 //---------------------------------------- 
 //TRIGGERS NEXT SECTION OF VIDEO
 //----------------------------------------
 void nextKey(){

   //update current video keyframe, if more exist   
   if(startKeys.length > currentKey+1){
     currentKey++; 
   }
 
 }
 
 
 
 //---------------------------------------- 
 //PLAYS ANIMATED GIF FILES
 //----------------------------------------
 void playGIF(){
   
   //fade in
   if( climbMovie.getCurrentTime() - instructionStart <= fadeLength ){ 
     if( transparency + 25 > 255 ){ transparency = 255; }
     else{ transparency += 25; }
   }
   //fade out
   else if( instructionEnd - climbMovie.getCurrentTime() <= fadeLength ){
     if( transparency - 25 < 0.0 ){ transparency = 0.0; }
     else{ transparency -= 25; }
   }
   
   //disply current GIF frame
   tint(255, transparency); 
   image(gifAnimation[gifFrame], gifX, gifY);
   
   //update current GIF frame, if more exist
   if(gifAnimation.length > gifFrame+1){
     gifFrame++; 
   }
   //animation loops back to the beginning
   else{
     gifFrame = 0;
   }
   
 }
 
 
 //---------------------------------------- 
 //ADVANCE TO NEXT SCENE
 //----------------------------------------
 void mousePress() {
   climbMovie.stop();
   setScene(3);
 }
  
}
