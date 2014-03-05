
//This file is for properties/functionality all scenes have
boolean sketchFullScreen() {
  return true;
}

class BaseScene{
 PImage backgroundImage;
 BaseScene(){
   size(displayWidth,displayHeight);
 }

  void draw(){
    image(backgroundImage,0,0,width,height);
  }
  
  void mousePress() {
    setScene(0);
  }

}
