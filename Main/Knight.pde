public class Knight extends ChessPieceClass {
  
  Knight(int setTeam, int x, int y, ChessBoard tempBoard){
    team = setTeam;
    value = 3;
    position[0] = x;
    position[1] = y;
    type = "Knight";
    board = tempBoard;
    if(team == 0){
      img = loadImage("Images/White Knight.png");
    } else {
      img = loadImage("Images/Black Knight.png");
    }
  }
  
  
  
  @Override
  boolean movement(int prevX, int prevY, int newX, int newY){
    
    //Checks if the movement done is in an L shape.
    if((Math.abs(prevX - newX) == 2 && Math.abs(prevY - newY) == 1) || (Math.abs(prevX - newX) == 1 && Math.abs(prevY - newY) == 2)){
      return true;
    }
    return false;
  }
  
  
}
