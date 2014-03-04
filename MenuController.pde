BaseScene[] scenes = new BaseScene[2];
int currentScene = 0;

void setup()
{
 scenes[0] = new MenuScene();
 scenes[1] = new HikingScene(); 
}

void draw()
{
 scenes[currentScene].draw(); 
}

void keyPressed()
{
   scenes[currentScene].keyPress();
}

void setScene(int id)
{
 currentScene = id; 
}
