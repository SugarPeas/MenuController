//----------------------------------------
//SKETCH CONTROLS PANORAMIC SCENE
//---------------------------------------- 
class PanoScene extends BaseScene{
  
  
//----------------------------------------
//VARIABLES
//----------------------------------------

//  ----------Serial stuff----------
int numSensors = 3;    // we will be expecting for reading data from three sensors
float[] sensors;       // array to read the 4 values
float[] pSensors;      // array to store the previuos reading, usefur for comparing

float xPot;
float yPot;
boolean button = false;

//----------3D sphere stuff----------
PImage sphere_tex;
float rotx = 0.0;
float roty = 0.0;
float rotz = 0.0;
float deltax = 0.01;

float yOffset = 2.75; //to adjust intial position

int sDetail = 50;  // Sphere detail setting
float pushBack = 0; // z coordinate of the center of the sphere
float defaultPushBack;
float maxZoom = 100;
int zoomSpeed = 20;

float[] sphereX, sphereY, sphereZ;
float sinLUT[];
float cosLUT[];
float SINCOS_PRECISION = 0.5;
int SINCOS_LENGTH = int(360.0 / SINCOS_PRECISION);

//----------Fade In / Timer Stuff----------
int startTime;
float rectTransparency = 255;
int savedIdleTime;
int idleTime = 7500;


//----------------------------------------
//CONSTRUCTOR
//---------------------------------------- 
PanoScene(PApplet pa){ super(pa); }


//---------------------------------------- 
//SCENE SETUP
//----------------------------------------
void begin()
{ 
  clearPort();
  
  pushBack = height;
  defaultPushBack = pushBack;
  initializeSphere(sDetail);

  sphere_tex = loadImage("pano.jpg");
  
  //animation init and setup
  gifAnimation = Gif.getPImages(parent, "pano.gif");
  gifFrame = 0;
  gifTransparency = 100;
   
  //used to center animation
  gifX = (displayWidth - gifAnimation[0].width) / 2;
  gifY = (displayHeight - gifAnimation[0].height) / 2;  
  
  //start timers
  startTime = millis();
  savedIdleTime = millis();
  savedFadeTime = millis();
}
  
  
//---------------------------------------- 
//DISPLAY THE SCENE
//----------------------------------------
void draw()
{ 
    //if user has been idle, fade the overlay and gif in
    if( millis() - savedIdleTime > idleTime ){ 
      fadeIn = true; 
      savedFadeTime = millis();
    }
  
    //wait for user interaction
    userInteraction(); 

    //handles zoom in/zoom out
    if(button == true){ zoomIn(); }
    else{ zoomOut(); }
  
    //make sure panoramic shows up
    tint(255, 255);
    
    translate(width / 2.0, height / 2.0, pushBack);
    if(abs(rotx) > PI / 2) {
      deltax = -deltax;
    }
    rotateX(xPot*2);
    rotateY(yPot*2 + yOffset);
    textureMode(IMAGE);
    noStroke();
    //draw texture to sphere
    texturedSphere(pushBack, sphere_tex);
    
  
    //needed for 2d      
    camera();
    hint(DISABLE_DEPTH_TEST);    
    
    //fade in at beginning of scene
    if( millis() - startTime < 2000 ){
      //black overlay
      fill(0, 0, 0, rectTransparency);
      rect(0, 0, displayWidth, displayHeight); 
      
      //update transparency of overlay
      if(rectTransparency - 10 >= 0){ rectTransparency -= 10; }
      else{ rectTransparency = 0; }
    }
    
    //handles fading overlay & gif
    if(millis() - savedFadeTime < fadeTime && fadeIn){ 
        overlay("fadeIn"); 
        playGIF("fadeIn"); 
    }
    else if(millis() - savedFadeTime < fadeTime && !fadeIn){ 
        overlay("fadeOut"); 
        playGIF("fadeOut");
    }
    else{ 
        overlay("");
        playGIF(""); 
    }
    
    
}


//---------------------------------------- 
//ZOOM IN PANORAMIC VIEW
//----------------------------------------
void zoomIn(){
  if(pushBack + zoomSpeed <= defaultPushBack + maxZoom){ 
    pushBack += zoomSpeed; 
  }
}


//---------------------------------------- 
//ZOOM OUT PANORAMIC VIEW
//----------------------------------------
void zoomOut(){
  if(pushBack - zoomSpeed >= defaultPushBack){
    pushBack -= zoomSpeed;
  }
}
  
      
//---------------------------------------- 
//HANDLES ARDUINO INTERACTION
//----------------------------------------
void userInteraction(){
  if(panoPort.available() > 0){ 
    float yMaxVal = 610;
    float xMaxVal = 383;
    float xMinVal = 125;
    float newMax = xMaxVal - xMinVal;
    String myString = panoPort.readStringUntil('\n');
    
    
    // if you got any bytes other than the linefeed:
    if (myString != null) {
      myString = trim(myString);
      String[] m = match(myString, "\\d+,\\d+,\\d+");
      
      if(m != null){
        
        //fade out overlay and gif when user starts interacting
        fadeIn = false;
        savedFadeTime = millis();
        savedIdleTime = millis();
        
        pSensors = sensors;
        sensors = float(split(myString, ','));
        
//        if(val1 > previousVal + 2 || val1 < previousVal - 2){
//      
//          if(val2 > previousVal2 + 2 || val2 < previousVal2 - 2){
//            
//                  
//              previousVal2 = val2;
//          }
//          
//          previousVal = val1;
//        }

         
      
  
        if(sensors[0] >= yMaxVal){
          sensors[0] = yMaxVal;
        }else{
          yPot = (sensors[0]/yMaxVal) - 0.5;
        }
//        xPot = (sensors[1]/xMaxVal) - 0.5;
        xPot = ((sensors[1]-xMinVal)/newMax) - 0.5;
        
        
        
        println("y sen: " + sensors[0]);
        println("x sen: " + sensors[1]);
        
        if(sensors[2]>900){
          button = true;
        }else{
          button = false;
        }
      }
  
    } 
  }
}
    
    
//---------------------------------------- 
//INITIALIZE SPHERE
//---------------------------------------- 
void initializeSphere(int res)
{
  sinLUT = new float[SINCOS_LENGTH];
  cosLUT = new float[SINCOS_LENGTH];

  for (int i = 0; i < SINCOS_LENGTH; i++) {
    sinLUT[i] = (float) Math.sin(i * DEG_TO_RAD * SINCOS_PRECISION);
    cosLUT[i] = (float) Math.cos(i * DEG_TO_RAD * SINCOS_PRECISION);
  }

  float delta = (float)SINCOS_LENGTH/res;
  float[] cx = new float[res];
  float[] cz = new float[res];
  
  // Calc unit circle in XZ plane
  for (int i = 0; i < res; i++) {
    cx[i] = -cosLUT[(int) (i*delta) % SINCOS_LENGTH];
    cz[i] = sinLUT[(int) (i*delta) % SINCOS_LENGTH];
  }
  
  // Computing vertexlist vertexlist starts at south pole
  int vertCount = res * (res-1) + 2;
  int currVert = 0;
  
  // Re-init arrays to store vertices
  sphereX = new float[vertCount];
  sphereY = new float[vertCount];
  sphereZ = new float[vertCount];
  float angle_step = (SINCOS_LENGTH*0.5f)/res;
  float angle = angle_step;
  
  // Step along Y axis
  for (int i = 1; i < res; i++) {
    float curradius = sinLUT[(int) angle % SINCOS_LENGTH];
    float currY = -cosLUT[(int) angle % SINCOS_LENGTH];
    for (int j = 0; j < res; j++) {
      sphereX[currVert] = cx[j] * curradius;
      sphereY[currVert] = currY;
      sphereZ[currVert++] = cz[j] * curradius;
    }
    angle += angle_step;
  }
  sDetail = res;
}//end initializeSphere
    
    
//---------------------------------------- 
//GENERIC ROUTINE TO DRAW TEXTURED SPHERE
//----------------------------------------
void texturedSphere(float r, PImage t) 
{
  int v1,v11,v2;
  r = (r + 240 ) * 0.33;
  beginShape(TRIANGLE_STRIP);
  texture(t);
  float iu = (float)(t.width-1)/(sDetail);
  float iv = (float)(t.height-1)/(sDetail);
  float u = 0, v = iv;
  for (int i = 0; i < sDetail; i++) {
    vertex(0, -r, 0,u,0);
    vertex(sphereX[i] * r, sphereY[i] * r, sphereZ[i] * r, u, v);
    u += iu;
  }
  vertex(0, -r, 0, u, 0);
  vertex(sphereX[0] * r, sphereY[0] * r, sphereZ[0] * r, u, v);
  endShape();   
  
  // Middle rings
  int voff = 0;
  for(int i = 2; i < sDetail; i++) {
    v1 = v11 = voff;
    voff += sDetail;
    v2 = voff;
    u = 0;
    beginShape(TRIANGLE_STRIP);
    texture(t);
    for(int j = 0; j < sDetail; j++) {
      vertex(sphereX[v1] * r, sphereY[v1] * r, sphereZ[v1++] * r, u, v);
      vertex(sphereX[v2] * r, sphereY[v2] * r, sphereZ[v2++] * r, u, v + iv);
      u += iu;
    }
  
    // Close each ring
    v1 = v11;
    v2 = voff;
    vertex(sphereX[v1] * r, sphereY[v1] * r, sphereZ[v1] * r, u, v);
    vertex(sphereX[v2] * r, sphereY[v2] * r, sphereZ[v2] * r, u, v + iv);
    endShape();
    v += iv;
  }
  u = 0;
  
  // Add the northern cap
  beginShape(TRIANGLE_STRIP);
  texture(t);
  for(int i = 0; i < sDetail; i++) {
    v2 = voff + i;
    vertex(sphereX[v2] * r, sphereY[v2] * r, sphereZ[v2] * r, u, v);
    vertex(0, r, 0, u, v + iv);    
    u += iu;
  }
  vertex(sphereX[voff] * r, sphereY[voff] * r, sphereZ[voff] * r, u, v);
  endShape();
  
} //end texturedSphere
 
  
//---------------------------------------- 
//CLEARS SERIAL PORT BUFFER
//----------------------------------------
void clearPort()
{ 
  panoPort.clear(); 
}


//---------------------------------------- 
//ADVANCE TO NEXT SCENE - MONTAGE
//----------------------------------------
void mousePress()
{ 
  clearPort();
  setScene(0); 
}

}//end class
