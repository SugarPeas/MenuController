int x = 0;
int y = -150;
String val;

class StarScene extends BaseScene
{
  StarScene()
  {
    backgroundImage = loadImage("stars.jpg");
  }
  
  void draw(){
    //super.draw();
    image(backgroundImage,x,y);
      if(myPort2.available() > 0){  
          val = myPort2.readStringUntil('\n').trim();
          if( val.trim().equals("Up") ){
               if (y != 0){
                  y+=2;
               }
          }else if(val.trim().equals("Down")){
            if(y != backgroundImage.height){
               y-=2; 
            }
          }
      }
  }
  
  
 void mousePress() {
    setScene(0);
  }
}
