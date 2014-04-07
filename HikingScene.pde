class HikingScene extends BaseScene
{
  HikingScene()
  {
   backgroundImage = loadImage("hiking.jpg"); 
  }
  
  void draw(){
    super.draw();
  }
  
  
 void mousePress() {
    setScene(1);
  }
}
