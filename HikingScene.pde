class HikingScene extends BaseScene
{
  Movie hikeMovie;
  boolean paused = false;
  float[] startKeys = { 00.00, 14.00, 20.15, 42.00, 47.00, 56.00, 58.25, 71.01, 73.05 };
  float[] endKeys   = { 14.00, 20.15, 42.00, 47.00, 56.00, 58.25, 71.01, 73.05, 85.09854 };
  
  HikingScene(PApplet pa)
  {
    super(pa);
  }
  
  void begin(){
    hikeMovie = new Movie(parent, "climbing.mp4");
    hikeMovie.play();
    hikeMovie.pause();
  }
  
  void draw(){
    image(hikeMovie, 0, 0);
    if(myPort3.available() > 0){
      hikeMovie.play();
    }
  }
  

 void mousePress() {
    setScene(2);
  }
}
