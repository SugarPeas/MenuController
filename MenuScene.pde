class MenuScene extends BaseScene
{
  PImage hikingMarker;
  PImage fireMarker;
  boolean hike = false;
  MenuScene()
  {
   backgroundImage = loadImage("campsite.jpg");
   hikingMarker = loadImage("hikingMarker.png");
   fireMarker = loadImage("fireMarker.png");
  }
  
  void draw(){
    super.draw();
    image(hikingMarker,300,400);
    image(fireMarker, 620, 400);
  
  }
  
  void mousePress(){
    setScene(2); 
  }
}
