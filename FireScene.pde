class FireScene extends BaseScene
{
  boolean startFire = false;
  PFont f;
  
  FireScene()
  {
   backgroundImage = loadImage("fire.jpg");
   f = createFont("Arial",36,true); // Arial, 36 point, anti-aliasing on
  }
  
  void draw(){
    super.draw();
    
    // If data is available, read it and store it in val
    if(myPort.available() > 0){  
      val = myPort.readStringUntil('\n');  
      if( val.trim().equals("true") ){ startFire = true; }
    }
    
    if(startFire){
      textFont(f,36);
      fill(#FFFFFF);
      text("Start the Fire",100,100);
    }
    
  }
  
  
 void mousePress() {
    setScene(3);
  }
}
