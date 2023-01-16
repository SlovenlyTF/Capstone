//Tobias Friese
//tfries21@student.aau.dk
//06-01-2023
//OOP Software AAU Semester 3

package Main;

import processing.core.PApplet;
import processing.core.PImage;

import java.util.ArrayList;

public class StartMenu extends PApplet {

  private PApplet sketch;
  private PImage leftArrow;
  private PImage leftArrowNoShine;
  private PImage rightArrow;
  private PImage startGameText;
  private PImage loadGameText;
  private PImage boardSizeText;
  private ArrayList<PImage> numbers = new ArrayList();
  private ArrayList<PImage> gamemodes = new ArrayList<PImage>();
  private int points = 39;
  private int gamemodeAmount = 3;
  private int keyCodeVar = 0;

  public void setKeyCodeVar(int keyCodeVar) {
    this.keyCodeVar = keyCodeVar;
  }

  private Game game;
  private SaveAndLoad saveAndLoadData;
  
  
  
  public StartMenu(Game tempGame, SaveAndLoad tempSaveAndLoadData, PApplet sketch){
    game = tempGame;
    saveAndLoadData = tempSaveAndLoadData;
    this.sketch = sketch;
  }
  
  
  
  public void startMenuSetup(){
    
    startGameText = loadImage(sketchPath("Data/Images/Start Game Text.png"));
    loadGameText = loadImage(sketchPath("Data/Images/Load Game Text.png"));
    boardSizeText = loadImage(sketchPath("Data/Images/Board Size Text.png"));
    rightArrow = loadImage(sketchPath("Data/Images/Right Arrow.png"));
    leftArrow = loadImage(sketchPath("Data/Images/Left Arrow.png"));
    leftArrowNoShine = loadImage(sketchPath("Data/Images/Left Arrow No Shine.png"));
    
    for(int i = 8; i <= 20; i += 2){
      numbers.add(loadImage(sketchPath("Data/Images/" + i + ".png")));
    }
    
    gamemodes.add(loadImage(sketchPath("Data/Images/Standard Mode.png")));
    gamemodes.add(loadImage(sketchPath("Data/Images/Knight Mode.png")));
    gamemodes.add(loadImage(sketchPath("Data/Images/Point Buy.png")));
    
  }


  /**
   * Runs every frame on the main menu.
   */
  public void startMenuDraw(){

    sketch.fill(0, 0, 0);
    sketch.textSize(80);
    sketch.image(startGameText, 100, 100, 700, 200);
    sketch.image(loadGameText, 100, 300, 700, 200);
    sketch.image(boardSizeText, 230, 500, 350, 100);
    sketch.image(numbers.get((game.getBoardSize() - 8) / 2), 570, 505, 100, 100);
    sketch.image(gamemodes.get(game.getGameMode()), 250, 600, 350, 100);
    
    
    //Board size arrows.
    if(game.getBoardSize() > 8){
      sketch.image(leftArrow, 120, 510, 100, 80);
    }
    if(game.getBoardSize() < 20){
      sketch.image(rightArrow, 780, 510, -100, 80);
    }
    
    
    //Gamemode arrows.
    if(game.getGameMode() > 0){
      sketch.image(leftArrow, 120, 610, 100, 80);
    }
    if(game.getGameMode() < gamemodeAmount - 1){
      sketch.image(rightArrow, 780, 610, -100, 80);
    }
    
    
    //If game mode is point buy, show extra menu
    if(game.getGameMode() == 2){
      sketch.textSize(40);
      sketch.text(points, 450, 730);
      sketch.fill(0, 0, 0, 0);
      if(points > 10){
        sketch.image(leftArrowNoShine, 350, 690, 50, 50);
      }
      sketch.image(rightArrow, 500, 690, 50, 50);
    }
    
  }
  

  /**
   * All the buttons on the main screen.
   * Runs every time the mouse is clicked on the main menu.
   * @param mouseY Just the mouse position at the Y coordinate.
   * @param mouseX Just the mouse position at the X coordinate.
   */
  public void startMenuMousePressed(int mouseY, int mouseX){
    
    //Start game
    if(mouseX > 100 && mouseX < 800 && mouseY > 100 && mouseY < 300){
      game.startGame(true);
      game.getBoard().setPoints(points);
      
      //Load game
    } else if(mouseX > 100 && mouseX < 800 && mouseY > 300 && mouseY < 500){
      saveAndLoadData.loadData(game);
      
      //Decrease board size
    } else if(mouseX > 120 && mouseX < 220 && mouseY > 500 && mouseY < 600 && game.getBoardSize() > 8){
      game.setBoardSize(game.getBoardSize() - 2);
      
      //Increase board size
    } else if(mouseX > 680 && mouseX < 780 && mouseY > 500 && mouseY < 600 && game.getBoardSize() < 20){
      game.setBoardSize(game.getBoardSize() + 2);
      
      //Game mode left arrow
    } else if(mouseX > 120 && mouseX < 220 && mouseY > 600 && mouseY < 700 && game.getGameMode() > 0){
      game.setGameMode(game.getGameMode() - 1);
      
      //Game mode right arrow
    } else if(mouseX > 680 && mouseX < 780 && mouseY > 600 && mouseY < 700 && game.getGameMode() < gamemodeAmount - 1){
      game.setGameMode(game.getGameMode() + 1);
      
      
      //Decrease points in point buy mode
    } else if(mouseX > 350 && mouseX < 400 && mouseY > 690 && mouseY < 740 && game.getGameMode() == 2){
      if(keyCodeVar == SHIFT){ //*5 if holding shift
        points -= 5;
      } else {
        points--;
      }
      if(points < 10){
        points = 10;
      }
      
      //Increase points in point buy mode
    } else if(mouseX > 500 && mouseX < 550 && mouseY > 690 && mouseY < 740 && game.getGameMode() == 2){
      if(keyCodeVar == SHIFT){ //*5 if holding shift
        points += 5;
      } else {
        points++;
      }
    }
    
    
  }
}
