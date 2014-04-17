import jmcvideo.*;
import processing.opengl.*;
//import gifAnimation.*;

class HikingScene extends BaseScene{
    
  JMCMovie hikeMovie;
  //Gif hikeAnimation;
  
  //define video keyframes
  int currentKey = 0;
  float[] startKeys = { 00.00, 14.00, 20.15, 42.00, 47.00, 56.00, 58.25, 71.01, 73.05 };
  float[] endKeys   = { 14.00, 20.15, 42.00, 47.00, 56.00, 58.25, 71.01, 73.05, 85.09854 };
  //video sections  =   start  loop   hike  loop   hike  loop   hike  loop   end
  
  
  HikingScene(PApplet pa){
    super(pa);
  }
  
  
  //setup
  void begin(){
    hikeMovie = new JMCMovie(parent, "climbing.mov", RGB);
    hikeMovie.play();
    
//    hikeAnimation = new Gif(parent, "hikeing.gif");
//    hikeAnimation.setTransparent(255, 255, 255);
//    hikeAnimation.setDelay(5);
//    hikeAnimation.play();
  }
  
  //loop
  void draw(){
    
    //image(hikeAnimation, 100,100);
        
    //if current key is even
    if( currentKey % 2 == 0 || currentKey == 0){
            
      //if video is between keyframes...
      if( hikeMovie.getCurrentTime() >= startKeys[currentKey] && hikeMovie.getCurrentTime() < endKeys[currentKey] ){
                
        //keep playing
        hikeMovie.play();
        image(hikeMovie, 0, 0);
        
      }
      //if reached end of video
      else if(hikeMovie.getCurrentTime() == hikeMovie.getDuration()){
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
      if( hikeMovie.getCurrentTime() > endKeys[currentKey] ){
        hikeMovie.setRate(-1.0);  
      }
      else if( hikeMovie.getCurrentTime() < startKeys[currentKey] ){
        hikeMovie.setRate(1.0);  
      }
      
      image(hikeMovie, 0, 0);
          
      //wait for user to trigger next section
      //if data is available...
      if(myPort3.available() > 0){  
        
        //store data
        val = myPort3.readStringUntil('\n');      
        if(val != null){
            hikeMovie.isBouncing = false;            
            nextKey(); 
          }
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
   hikeMovie.stop();
   setScene(3);
 }
  
}
