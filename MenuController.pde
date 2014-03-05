BaseScene[] scenes = new BaseScene[4];
int currentScene = 0;

void setup()
{
 scenes[0] = new MenuScene();
 scenes[1] = new HikingScene(); 
 scenes[2] = new FireScene();
 scenes[3] = new StarScene();
}

void draw()
{
 scenes[currentScene].draw(); 
}


void mousePressed()
{
   scenes[currentScene].mousePress();
}

void setScene(int id)
{
 currentScene = id; 
}
