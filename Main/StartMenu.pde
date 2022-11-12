public class StartMenu {
  
  private PImage leftArrow;
  private PImage leftArrowNoShine;
  private PImage rightArrow;
  private PImage startGameText;
  private PImage loadGameText;
  private PImage boardSizeText;
  private PImage numbers[] = new PImage[7];
  private PImage gamemodes[] = new PImage[3];
  private int points = 39;
  
  private int gamemodeAmount = 3;
  
  Game game;
  SaveAndLoad saveAndLoadData;
  
  public StartMenu(Game tempGame, SaveAndLoad tempSaveAndLoadData){
    game = tempGame;
    saveAndLoadData = tempSaveAndLoadData;
  }
  
  public void startMenuSetup(){
    
    startGameText = loadImage("Images/Start Game Text.png");
    loadGameText = loadImage("Images/Load Game Text.png");
    boardSizeText = loadImage("Images/Board Size Text.png");
    rightArrow = loadImage("Images/Right Arrow.png");
    leftArrow = loadImage("Images/Left Arrow.png");
    leftArrowNoShine = loadImage("Images/Left Arrow No Shine.png");
    
    for(int i = 8, j = 0; i <= 20; i += 2, j++){
      numbers[j] = loadImage("Images/" + i + ".png");
    }
    
    gamemodes[0] = loadImage("Images/Standard Mode.png");
    gamemodes[1] = loadImage("Images/Knight Mode.png");
    gamemodes[2] = loadImage("Images/Point Buy.png");
    
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
    if(game.getGameMode() < gamemodeAmount - 1){
      image(rightArrow, 780, 610, -100, 80);
    }
    
    
    if(game.getGameMode() == 2){
      textSize(40);
      text(points, 450, 730);
      fill(0, 0, 0, 0);
      if(points > 10){
        image(leftArrowNoShine, 350, 690, 50, 50);
      }
      image(rightArrow, 500, 690, 50, 50);
    }
    
    
  }
  
  public void startMenuMousePressed(){
    
    if(mouseX > 100 && mouseX < 800 && mouseY > 100 && mouseY < 300){
      game.startGame(true);
      game.board.setPoints(points);
    } else if(mouseX > 100 && mouseX < 800 && mouseY > 300 && mouseY < 500){
      saveAndLoadData.loadData(game);
    } else if(mouseX > 120 && mouseX < 220 && mouseY > 500 && mouseY < 600 && game.getBoardSize() > 8){
      game.setBoardSize(game.getBoardSize() - 2);
    } else if(mouseX > 680 && mouseX < 780 && mouseY > 500 && mouseY < 600 && game.getBoardSize() < 20){
      game.setBoardSize(game.getBoardSize() + 2);
    } else if(mouseX > 120 && mouseX < 220 && mouseY > 600 && mouseY < 700 && game.getGameMode() > 0){
      game.setGameMode(game.getGameMode() - 1);
    } else if(mouseX > 680 && mouseX < 780 && mouseY > 600 && mouseY < 700 && game.getGameMode() < gamemodeAmount - 1){
      game.setGameMode(game.getGameMode() + 1);
    } else if(mouseX > 350 && mouseX < 400 && mouseY > 690 && mouseY < 740 && game.getGameMode() == 2){
      if(keyCode == SHIFT){
        points -= 5;
      } else {
        points--;
      }
      if(points < 10){
        points = 10;
      }
    } else if(mouseX > 500 && mouseX < 550 && mouseY > 690 && mouseY < 740 && game.getGameMode() == 2){
      if(keyCode == SHIFT){
        points += 5;
      } else {
        points++;
      }
    }
    
    //if(mouseX <
  }
}
