//----------------------------------------
//SKETCH CONTROLS INTRO MONTAGE
//---------------------------------------- 
class MontageScene extends BaseScene{

//---------------------------------------- 
//CONSTRUCTOR
//----------------------------------------
MontageScene(PApplet pa){super(pa);}


//---------------------------------------- 
//SCENE SETUP
//----------------------------------------
void begin()
{
  //video init and setup
  myMovie = new JMCMovie(parent, "introMontage.mp4", RGB);
  myMovie.frameImage();
  myMovie.play();
}


//---------------------------------------- 
//DISPLAY THE SCENE
//----------------------------------------
void draw()
{
  myMovie.centerImage();
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
