public abstract class ChessPieceClass implements ChessPieceInterface{
  
  protected int team;
  protected int value;
  protected int position[] = new int[2];
  protected boolean isPickedUp = false;
  protected String type;
  ChessBoard board;
  ScoreBoard score;
  PImage img;
  
  void setPosition(int x, int y){
    position[0] = x;
    position[1] = y;
  }
  
  int getPosition(int i){
    return position[i];
  }
  
  void setTeam(int i){
    team = i;
  }
  
  int getTeam(){
    return team;
  }
  
  void setValue(int i){
    value = i;
  }
  
  int getValue(){
    return value;
  }
  
  void setIsPickedUp(boolean i){
    isPickedUp = i;
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
  
    
}
