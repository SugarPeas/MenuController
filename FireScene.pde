class FireScene extends BaseScene
{
  FireScene()
  {
   backgroundImage = loadImage("fire.jpg");
  }
  
  void draw(){
    super.draw();
  }
  
  
 void mousePress() {
    setScene(0);
  }
}
