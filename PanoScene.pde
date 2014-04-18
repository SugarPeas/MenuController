//----------------------------------------
//SKETCH CONTROLS PANORAMIC SCENE
//---------------------------------------- 
class PanoScene extends BaseScene{
  
//----------------------------------------
//VARIABLES
//---------------------------------------- 
int xpos = 0;
int ypos = -150;


//---------------------------------------- 
//CONSTRUCTOR
//----------------------------------------
PanoScene(PApplet pa){super(pa);}

//---------------------------------------- 
//SCENE SETUP
//----------------------------------------
void begin()
{
  //INIT AND SETUP GOES HERE
}


//---------------------------------------- 
//DISPLAY THE SCENE
//----------------------------------------
void draw()
{
//  DO SOMETHING HERE:

//  if(panoPort.available() > 0){  
//    
//    val = panoPort.readString();
//    
//    if(val != null){
//    
//      if( val.trim().equals("Down") ){
//       if (ypos < 0){ypos += 5;}
//      }
//      else if( val.trim().equals("Up") ){
//        if(ypos + backgroundImage.height > displayHeight){ypox -= 5;}
//      }
//    }
//  }

}//end draw


//---------------------------------------- 
//ADVANCE TO NEXT SCENE - INTRO MONTAGE
//----------------------------------------  
void mousePress()
{
  setScene(0);
}

}//end class
