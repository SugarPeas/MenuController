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
  
  movieX = (displayWidth - 1280) / 2;
  movieY = (displayHeight - 720) / 2;
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
//ADVANCE TO NEXT SCENE - HIKING
//----------------------------------------
void mousePress() 
{
  myMovie.dispose();
  setScene(1);
}
  
}//end class
