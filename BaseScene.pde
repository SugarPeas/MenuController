//This file is for properties/functionality all scenes have
boolean sketchFullScreen() {
  return true;
}

String val; //Stores serial messages from arduino
PFont font;

class BaseScene{
 PImage backgroundImage;
 String portName = Serial.list()[2]; //change the 0 to a 1 or 2 etc. to match your port

 PApplet parent;

 BaseScene(PApplet pa){
   font = createFont("Arial Bold",48);
   parent = pa;
 }
 
 void begin()
 {
   
 }

  void draw(){
    image(backgroundImage,0,0,width,height);
    // oversampled fonts tend to look better
    textFont(font,36);
    // white float frameRate
    fill(255);
    text(frameRate,60,60);
    // gray int frameRate display:
    fill(200);
    text(int(frameRate),60,100);
  }
  
  void mousePress() {
    setScene(0);
  }

}
