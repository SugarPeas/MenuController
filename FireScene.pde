class FireScene extends BaseScene
{
  //animatics
  PImage sparkImage;
  PImage blowingImage;
  PImage fireImage;
  
  boolean startFire = false;
  
  FireScene()
  {
    //load images
    backgroundImage = loadImage("CampFire_02.jpg");
    sparkImage = loadImage("CampFire_03.jpg");
    blowingImage = loadImage("CampFire_04.jpg");
    fireImage = loadImage("CampFire_05.jpg");    
  }
  
  void draw(){
    super.draw();
    
    //fire is started
    if(startFire){
       image(fireImage,0,0,width,height);
    }
    // If data is available, read it and store it in val
    else if(myPort.available() > 0){  
      val = myPort.readStringUntil('\n');  
      
      //if user striked the flint
      if(val.trim().equals("spark")){          
        image(sparkImage,0,0,width,height);
      }
      //if user is done blowing
      else if(val.trim().equals("blowing")){ 
        image(blowingImage,0,0,width,height);
      }
      //if user is done blowing
      else if(val.trim().equals("fire")){ 
        startFire = true; //start the fire
      }
      
    }
    
  }
  
  
 void mousePress() {
    setScene(3);
  }
}
