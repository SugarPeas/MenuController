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
    image(myMovie, 0, 0);
  }
  
  void mousePress() {
    myMovie.stop();
    setScene(1);
  }
  
}
