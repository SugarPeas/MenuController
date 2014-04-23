//----------------------------------------
//SKETCH CONTROLS INTRO MONTAGE
//---------------------------------------- 
class MontageScene extends BaseScene{

  
//---------------------------------------- 
//CONSTRUCTOR
//----------------------------------------
MontageScene(PApplet pa){ super(pa); }


//---------------------------------------- 
//SCENE SETUP
//----------------------------------------
void begin()
{
  //video init and setup
  myMovie = new JMCMovie(parent, "introMontage.mp4", RGB);
  myMovie.play();
}


//---------------------------------------- 
//DISPLAY THE SCENE
//----------------------------------------
void draw()
{
  background(0);
  
  //if near beginning of video, fade in
  if(myMovie.getCurrentTime() < 1 && (movieTransparency + 8.5) <= 255){ movieTransparency += 8.5; }
  //if near the end of video, fade out
  else if(myMovie.getDuration() - myMovie.getCurrentTime() < 1 && (movieTransparency - 8.5) >= 0 ){ movieTransparency -= 8.5; }
  //if reached end of video, go to next scene
  else if(myMovie.getCurrentTime() == myMovie.getDuration()){ mousePress(); }
    
  
  //display frame
  tint(255, movieTransparency);
  image(myMovie, movieX, movieY);
  
}


//---------------------------------------- 
//ADVANCE TO NEXT SCENE - HIKING
//----------------------------------------
void mousePress() 
{
  myMovie.dispose();
  setScene(1);
}
  
}//end class
