class FireScene extends BaseScene
{
  PFont f;
  boolean startFire = false;
  
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
      
      //if user striked the flint
      if(val.trim().equals("spark")){         
        textFont(f);
        fill(#FFFFFF);
        text("Spark",100,100); 
        
        delay(200);
      }
      //if user is done blowing
      else if(val.trim().equals("fire")){ 
        startFire = true; //start the fire
      }
    }
    
    if(startFire){
      textFont(f);
      fill(#FFFFFF);
      text("Start the Fire",100,100); 
    }
    
  }
  
  
 void mousePress() {
    setScene(3);
  }
}
