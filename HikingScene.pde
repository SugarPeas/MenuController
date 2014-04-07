class HikingScene extends BaseScene
{
  HikingScene(PApplet pa)
  {
    super(pa);
   backgroundImage = loadImage("hiking.jpg"); 
  }
  
  void draw(){
    super.draw();
  }
  
  
 void mousePress() {
    setScene(0);
  }
}
