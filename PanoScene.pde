int x = 0;
int y = -150;

class PanoScene extends BaseScene
{
  PanoScene(PApplet pa)
  {
    super(pa);
    backgroundImage = loadImage("stars.jpg");
  }
  
  void draw(){
    super.draw();
    
    image(backgroundImage,x,y);
    
    if(myPort2.available() > 0){  
      
        val = myPort2.readString();
        
        if(val != null){
        
          if( val.trim().equals("Down") ){
          
             if (y < 0){
                y+=5;
             }
          }
          else if( val.trim().equals("Up") ){
            
            if(y + backgroundImage.height > displayHeight){
               y-=5; 
            }
            
          }
        
        }
    }
  }
  
  
 void mousePress() {
    setScene(0);
  }
}
