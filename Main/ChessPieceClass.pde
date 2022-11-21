public abstract class ChessPieceClass implements ChessPieceInterface{
  
  protected int team;
  protected int value;
  protected Vector2D position = new Vector2D(0, 0);
  protected boolean isPickedUp = false;
  protected String type;
  protected boolean prevHasMoved = false;
  protected boolean hasMoved = false;
  ChessBoard board;
  ScoreBoard score;
  
  PImage img;
  
  public ChessPieceClass(int setTeam, Vector2D coords, ChessBoard tempBoard, int tempValue, String tempType, String whiteImg, String blackImg){
    team = setTeam;
    position.setX(coords.getX());
    position.setY(coords.getY());
    board = tempBoard;
    
    value = tempValue;
    type = tempType;
    if(team == 0){
      img = loadImage(whiteImg);
    } else {
      img = loadImage(blackImg);
    }
    
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
  
  public void setHasMoved(boolean i){
    hasMoved = i;
  }
  
  public boolean getPrevHasMoved(){
    return prevHasMoved;
  }
  
  
  //Creates the visual image of the
  void displayImage(){
    if(isPickedUp){
      tint(255, 150);
      image(img, mouseX - (game.getCellSize() / 2), mouseY - (game.getCellSize() / 2), game.getCellSize(), game.getCellSize());
      image(img, game.getCellSize()*position.getX(), game.getCellSize()*position.getY(), game.getCellSize(), game.getCellSize());
      tint(255, 255);
    } else {
      image(img, game.getCellSize()*position.getX(), game.getCellSize()*position.getY(), game.getCellSize(), game.getCellSize());
    }
  }
  
  String getType(){
    return type;
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
  protected boolean justDoublePawn = false;
  protected boolean performedPassant = false;
  
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
  //----
  
  
  
}
