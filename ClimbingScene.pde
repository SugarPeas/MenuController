class ClimbingScene extends BaseScene{
    
  Movie climbMovie;
  
  //define video keyframes
  int currentKey = 0;
  float[] startKeys = { 00.0, 15.0, 19.0, 23.0, 30.0, 52.0, 58.0, 65.0, 85.0, 094.0, 136.0, 144.0, 154.0, 158.0 };
  float[] endKeys =   { 15.0, 19.0, 23.0, 30.0, 52.0, 58.0, 65.0, 85.0, 94.0, 136.0, 144.0, 154.0, 158.0, 176.727 };
  
  
  ClimbingScene(PApplet pa){
    super(pa);
  }
  
  
  //setup
  void begin(){
    climbMovie = new Movie(parent, "climbing.mp4");
  }
  
  //loop
  void draw(){
     
    //if video is between keyframes...
    if( climbMovie.time() >= startKeys[currentKey] && climbMovie.time() < endKeys[currentKey] ){
      
      //keep playing
      climbMovie.play();
      image(climbMovie, 0, 0);
      
    }
    //if reached end of video, 
    else if(climbMovie.time() == climbMovie.duration()){
      mousePress(); //go to next scene
    }
    //if reached end of current section...
    else{
      climbMovie.pause();
      
      //wait for user to trigger next section
      //if data is available...
      if(myPort.available() > 0){  
        
        //store data
        val = myPort.readStringUntil('\n');      
        if(val != null){
          
          //if rotary encoder is turning, trigger climbing action
          if(val.trim().equals("climb")){ climb(); }
        
        }//end if 
      } //end if
      
    }//end else
    
    
  }//end draw()
 

 //triggers next section of video
 void climb(){
  
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
