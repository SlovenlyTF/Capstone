public abstract class ChessPieceClass implements ChessPieceInterface{
  
  protected int team;
  protected int value;
  protected int position[] = new int[2];
  protected boolean isPickedUp = false;
  protected String type;
  protected boolean hasMoved = false;
  ChessBoard board;
  ScoreBoard score;
  PImage img;
  
  
  public void setPosition(int x, int y){
    position[0] = x;
    position[1] = y;
  }
  
  public int getPosition(int i){
    return position[i];
  }
  
  public void setTeam(int i){
    team = i;
  }
  
  public int getTeam(){
    return team;
  }
  
  public void setValue(int i){
    value = i;
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
  
  
  //Creates the visual image of the
  void displayImage(){
    if(isPickedUp){
      tint(255, 150);
      image(img, mouseX - (cellSize / 2), mouseY - (cellSize / 2), cellSize, cellSize);
      image(img, cellSize*position[0], cellSize*position[1], cellSize, cellSize);
      tint(255, 255);
    } else {
      image(img, cellSize*position[0], cellSize*position[1], cellSize, cellSize);
    }
  }
  
  String getType(){
    return type;
  }
  
  //Just set reverts justCastled boolean back after a successful move that is not a castle.
  public void revertVariables(){
    board.setJustCastled(false);
    if(turn % 2 == 0){
      board.setPawnDoubleMoveWhite(false);
    } else {
      board.setPawnDoubleMoveBlack(false);
    }
  }
  
  
  
  //This code should be in the pawn class, but I can't figure out how to call it through this class...
  protected boolean justDoublePawn = false;
  protected boolean performedPassant = false;
  
  public void setJustDoublePawn(boolean i){
    justDoublePawn = i;
    if(i && turn % 2 == 0){
      board.setPawnDoubleMoveWhite(true);
    } else if (i){
      board.setPawnDoubleMoveBlack(true);
    }
  }
  
  public boolean getJustDoublePawn(){
    return justDoublePawn;
  }
  
  public boolean getPerformedPassant(){
    return performedPassant;
  }
  //----
  
  
  
}
