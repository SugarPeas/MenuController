
//This file is for properties/functionality all scenes have
boolean sketchFullScreen() {
  return true;
}

class BaseScene{
 PImage backgroundImage;
 String portName = Serial.list()[2]; //change the 0 to a 1 or 2 etc. to match your port

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
