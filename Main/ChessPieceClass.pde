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
      image(img, mouseX - 50, mouseY - 50, 100, 100);
      image(img, 100*position[0], 100*position[1], 100, 100);
      tint(255, 255);
    } else {
      image(img, 100*position[0], 100*position[1], 100, 100);
    }
  }
  
  String getType(){
    return type;
  }
  
  //Just set reverts justCastled boolean back after a successful move that is not a castle.
  public void revertJustCastled(){
    if(board.getJustCastled()){
      board.setJustCastled(false);
    }
  }
  
}
