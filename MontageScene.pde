import processing.video.*;

class MontageScene extends BaseScene{

  Movie myMovie;

  MontageScene(PApplet pa)
  {
    super(pa);
  }
  
  void begin()
  {
    myMovie = new Movie(parent, "introMontage.mp4");
    myMovie.loop();
  }
  
  void draw(){
    //super.draw();
    //tint(255, 20);
    image(myMovie, 0, 0);
  }
  
   void mousePress() {
    setScene(1);
  }
  
}
