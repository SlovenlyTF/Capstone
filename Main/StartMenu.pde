public class StartMenu {
  
  PImage leftArrow;
  PImage rightArrow;
  PImage startGameText;
  PImage loadGameText;
  PImage boardSizeText;
  PImage numbers[] = new PImage[7];
  PImage gamemodes[] = new PImage[2];
  
  Game game;
  
  public StartMenu(Game tempGame){
    game = tempGame;
    
  }
  
  public void startMenuSetup(){
    
    startGameText = loadImage("Images/Start Game Text.png");
    loadGameText = loadImage("Images/Load Game Text.png");
    boardSizeText = loadImage("Images/Board Size Text.png");
    rightArrow = loadImage("Images/Right Arrow.png");
    leftArrow = loadImage("Images/Left Arrow.png");
    
    for(int i = 8, j = 0; i <= 20; i += 2, j++){
      numbers[j] = loadImage("Images/" + i + ".png");
    }
    
    gamemodes[0] = loadImage("Images/Standard Mode.png");
    gamemodes[1] = loadImage("Images/Knight Mode.png");
  }
  
  public void startMenuDraw(){
    
    fill(0, 0, 0);
    textSize(80);
    image(startGameText, 100, 100, 700, 200);
    image(loadGameText, 100, 300, 700, 200);
    image(boardSizeText, 230, 500, 350, 100);
    image(numbers[(game.getBoardSize() - 8) / 2], 570, 505, 100, 100);
    image(gamemodes[game.getGameMode()], 250, 600, 350, 100);
    //text(game.getBoardSize(), 615, 580);
    
    //Board size arrows.
    if(game.getBoardSize() > 8){
      image(leftArrow, 120, 510, 100, 80);
    }
    if(game.getBoardSize() < 20){
      image(rightArrow, 780, 510, -100, 80);
    }
    
    //Gamemode arrows.
    if(game.getGameMode() > 0){
      image(leftArrow, 120, 610, 100, 80);
    }
    if(game.getGameMode() < 1){
      image(rightArrow, 780, 610, -100, 80);
    }
    
    /*fill(0, 0, 0, 0);
    rect(680, 600, 100, 100);*/
    
    
  }
  
  public void startMenuMousePressed(){
    
    if(mouseX > 100 && mouseX < 800 && mouseY > 100 && mouseY < 300){
      game.startGame();
    } else if(mouseX > 100 && mouseX < 800 && mouseY > 300 && mouseY < 500){
      println("does nothing right now");
    } else if(mouseX > 120 && mouseX < 220 && mouseY > 500 && mouseY < 600 && game.getBoardSize() > 8){
      game.setBoardSize(game.getBoardSize() - 2);
    } else if(mouseX > 680 && mouseX < 780 && mouseY > 500 && mouseY < 600 && game.getBoardSize() < 20){
      game.setBoardSize(game.getBoardSize() + 2);
    } else if(mouseX > 120 && mouseX < 220 && mouseY > 600 && mouseY < 700 && game.getGameMode() > 0){
      game.setGameMode(game.getGameMode() - 1);
    } else if(mouseX > 680 && mouseX < 780 && mouseY > 600 && mouseY < 700 && game.getGameMode() < 1){
      game.setGameMode(game.getGameMode() + 1);
    }
    
    
    //if(mouseX <
  }
}
