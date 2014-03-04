 class MenuScene extends BaseScene
{
  MenuScene()
  {
   clearColor = color(51, 51, 51); 
  }
  
  void draw(){
    super.draw();
  }
  
  void keyPress(){
    setScene(1); 
  }
}
