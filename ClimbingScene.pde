class ClimbingScene extends BaseScene
{
  PImage climbImage;
  
  ClimbingScene(){
    backgroundImage = loadImage("Climb_01.jpg");
    climbImage = loadImage("Climb_02.jpg");
  }
  
  void draw(){
    super.draw();
    
    //if data is available...
    if(myPort.available() > 0){  
      
      //store data
      val = myPort.readStringUntil('\n');
      
      if(val != null){
        
        //if rotary encoder is turned clockwise
        if(val.trim().equals("climb")){   
          
          //trigger climbing action
          image(climbImage,0,0,width,height);
          
        }
      
      }//end if 
      
    } //end if
  }//end draw()
  
  
 void mousePress() {
    setScene(2);
  }
}
