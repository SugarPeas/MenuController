import processing.serial.*;

class StarScene extends BaseScene
{
  StarScene()
  {
   backgroundImage = loadImage("stars.jpg");
   
  }
  
  void draw(){
    super.draw();
  }
  
  
 void mousePress() {
    setScene(0);
  }
}
