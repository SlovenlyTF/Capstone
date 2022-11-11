private boolean startScreen = true;

private PImage background;

private Game game = new Game();
private StartMenu startMenu = new StartMenu(game);


//Is run once when the program is launched.
void setup() {
  
  size(900, 800); //Sets the window size.
  frameRate(30); //Sets the framerate.
  
  textAlign(CENTER);
  background = loadImage("Images/Marble Background.png"); //Loads in the image for the background.
  
  game.gameSetup();
  startMenu.startMenuSetup();
}


/**Runs each frame.
*  Runs primarily all the visual code.
*/
void draw(){
  
  image(background, 0, 0, width, height);
  
  if(startScreen){
    startMenu.startMenuDraw();
  } else {
    game.drawGame();
  }
  
}


void mousePressed(){
  
  if(startScreen){
    startMenu.startMenuMousePressed();
  } else {
    game.gameMousePressed();
  }
  
}


void keyPressed() {
  
  if(!startScreen){
    game.gameKeyPressed();
  }
  
}
