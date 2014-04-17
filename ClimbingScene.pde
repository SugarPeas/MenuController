import jmcvideo.*;
import processing.opengl.*;
import gifAnimation.*;

class ClimbingScene extends BaseScene{
    
  JMCMovie climbMovie;
  //Gif climbAnimation;
  
  //define video keyframes
  int currentKey = 0;
  float[] startKeys = { 00.00, 14.00, 20.15, 42.00, 47.00, 56.00, 58.25, 71.01, 73.05 };
  float[] endKeys   = { 14.00, 20.15, 42.00, 47.00, 56.00, 58.25, 71.01, 73.05, 85.09854 };
  //video sections  =   start  loop   climb  loop   climb  loop   climb  loop   end
  
  
  ClimbingScene(PApplet pa){
    super(pa);
  }
  
  
  //setup
  void begin(){
    climbMovie = new JMCMovie(parent, "climbing.mov", RGB);
    climbMovie.play();
    
//    climbAnimation = new Gif(parent, "climbing.gif");
//    climbAnimation.setTransparent(255, 255, 255);
//    climbAnimation.setDelay(5);
//    climbAnimation.play();
  }
  
  //loop
  void draw(){
    
    //image(climbAnimation, 100,100);
        
    //if current key is even
    if( currentKey % 2 == 0 || currentKey == 0){
            
      //if video is between keyframes...
      if( climbMovie.getCurrentTime() >= startKeys[currentKey] && climbMovie.getCurrentTime() < endKeys[currentKey] ){
                
        //keep playing
        climbMovie.play();
        image(climbMovie, 0, 0);
        
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
      
      image(climbMovie, 0, 0);
          
      //wait for user to trigger next section
      //if data is available...
      if(myPort.available() > 0){  
        
        //store data
        val = myPort.readStringUntil('\n');      
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
 

 //triggers next section of video
 void nextKey(){
  
   //update current keyframe, if more exist   
   if(startKeys.length > currentKey+1){
     currentKey++; 
   }
   
 }
 
 
 //move to next scene
 void mousePress() {
   climbMovie.stop();
   setScene(3);
 }
  
}
