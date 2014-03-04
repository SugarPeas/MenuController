//This file is for properties/functionality all scenes have
boolean sketchFullScreen() {
  return true;
}

class BaseScene{
  
 color clearColor;
  
 BaseScene(){
   size(displayWidth,displayHeight);
   clearColor = color(255);
 }

  void draw(){
    background(clearColor);
  }
  
  void keyPress(){
    setScene(1); 
  }

}
