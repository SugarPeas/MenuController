BaseScene[] scenes = new BaseScene[3];
int currentScene = 0;

void setup()
{
 scenes[0] = new MenuScene();
 scenes[1] = new HikingScene(); 
 scenes[2] = new FireScene();
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
