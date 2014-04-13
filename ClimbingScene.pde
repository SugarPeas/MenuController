import processing.video.*;

class ClimbingScene extends BaseScene{
    
  Movie climbMovie;
  Boolean isPlaying = false;
  
  ClimbingScene(PApplet pa){
    super(pa);
  }
  
  //setup
  void begin(){
    climbMovie = new Movie(parent, "climbing.mp4");
    //climbMovie.play();
  }
  
  //loop
  void draw(){
    
    image(climbMovie, 0, 0);
        
    //if data is available...
    if(myPort.available() > 0){  
      
      //store data
      val = myPort.readStringUntil('\n');      
      if(val != null){
        
        //if rotary encoder is turning, trigger climbing action
        if(val.trim().equals("climb")){ climb(); }
      
      }//end if 
    } //end if
    
  }//end draw()
 

 
 void climb(){
   
   //if playing
   if(isPlaying){
     climbMovie.pause();
     isPlaying = false;
   }
   else{
     climbMovie.play();
     isPlaying = true;
   }
   
 }
 
 
 //move to next scene
 void mousePress() {
    setScene(3);
  }
  
}
