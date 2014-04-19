import processing.serial.*;
//This file is for properties/functionality all scenes have
boolean sketchFullScreen() {
  return false;
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
    println("drawbg");
    image(backgroundImage,0,0,width,height);
    // oversampled fonts tend to look better
    println("make font");
    textFont(font,36);
    // white float frameRate
    fill(255);
    text(frameRate,60,60);
    // gray int frameRate display:
    fill(200);
    text(int(frameRate),60,100);
    println("done base draw");
  }
  
  void mousePress() {
    setScene(0);
  }

}
