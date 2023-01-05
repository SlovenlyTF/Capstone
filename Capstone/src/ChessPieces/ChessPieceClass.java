package ChessPieces;

import Main.ChessBoard;
import Main.Game;
import Main.Vector2D;
import processing.core.PApplet;
import processing.core.PImage;

public abstract class ChessPieceClass extends PApplet implements ChessPieceInterface{
  
  private int team;
  private int value;
  private Vector2D position = new Vector2D(0, 0);
  private boolean isPickedUp = false;
  private String type;
  private boolean prevHasMoved = false;
  private boolean hasMoved = false;
  private ChessBoard board;
  private Game game;
  private PApplet sketch;
  PImage img;

  public Vector2D getPosition() {
    return position;
  }
  public void setPrevHasMoved(boolean i){
    prevHasMoved = i;
  }
  public void setHasMoved(boolean i){
    hasMoved = i;
  }
  public void setPosition(Vector2D coords){
    position.setX(coords.getX());
    position.setY(coords.getY());
  }
  public int getPositionX(){
    return position.getX();
  }
  public int getPositionY(){
    return position.getY();
  }
  public void setTeam(int i){
    team = i;
  }
  public int getTeam(){
    return team;
  }
  public String getType(){
    return type;
  }
  public int getValue(){
    return value;
  }
  public void setIsPickedUp(boolean i){
    isPickedUp = i;
  }
  public boolean getHasMoved(){
    return hasMoved;
  }
  public boolean getPrevHasMoved(){
    return prevHasMoved;
  }

  public ChessPieceClass(int team, Vector2D coords, ChessBoard board, int value, String type, String whiteImg, String blackImg, Game game, PApplet sketch){
    this.team = team;
    position.setX(coords.getX());
    position.setY(coords.getY());
    this.board = board;
    this.game = game;
    this.sketch = sketch;
    
    this.value = value;
    this.type = type;
    if(team == 0){
      img = loadImage(sketchPath("Data/") + whiteImg);
    } else {
      img = loadImage(sketchPath("Data/") + blackImg);
    }
  }

  
  //Creates the visual image of the
  public void displayImage(int mouseX, int mouseY){
    if(isPickedUp){
      sketch.tint(255, 150);
      sketch.image(img, mouseX - (game.getCellSize() / 2), mouseY - (game.getCellSize() / 2), game.getCellSize(), game.getCellSize());
      sketch.image(img, game.getCellSize()*position.getX(), game.getCellSize()*position.getY(), game.getCellSize(), game.getCellSize());
      sketch.tint(255, 255);
    } else {
      sketch.image(img, game.getCellSize()*position.getX(), game.getCellSize()*position.getY(), game.getCellSize(), game.getCellSize());
    }
  }

  
  //Just set reverts justCastled boolean back after a successful move that is not a castle.
  public void revertVariables(){
    board.setJustCastled(false);
    if(game.getTurn() % 2 == 0){
      board.setPawnDoubleMoveWhite(false);
    } else {
      board.setPawnDoubleMoveBlack(false);
    }
  }
  
  
  
  //This code should be in the pawn class, but I can't figure out how to call it through this class...
  private boolean justDoublePawn = false;
  private boolean performedPassant = false;

  public void setPerformedPassant(boolean performedPassant) {
    this.performedPassant = performedPassant;
  }

  public void setJustDoublePawn(boolean i){
    justDoublePawn = i;
    if(i && game.getTurn() % 2 == 0){
      board.setPawnDoubleMoveWhite(true);
    } else if (i){
      board.setPawnDoubleMoveBlack(true);
    }
  }
  
  public void convert(Vector2D coords){
    board.removeChessPiece(coords);
    board.spawnNewPiece(coords, game.getTurn() % 2 - 1, board.getSelectedType());
    board.setPieceSelectionPawn(false);
  }
  
  public boolean getJustDoublePawn(){
    return justDoublePawn;
  }
  
  public boolean getPerformedPassant(){
    return performedPassant;
  }


}
