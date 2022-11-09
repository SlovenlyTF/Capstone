public class King extends ChessPieceClass {
  
  King(int setTeam, int x, int y, ChessBoard tempBoard){
    team = setTeam;
    value = 0;
    position[0] = x;
    position[1] = y;
    type = "King";
    board = tempBoard;
    if(team == 0){
      img = loadImage("Images/White King.png");
    } else {
      img = loadImage("Images/Black King.png");
    }
  }  
  
  
  @Override
  boolean movement(int prevX, int prevY, int newX, int newY){
    
    //Checks if the movement done is one space from its original postition.
    if(Math.abs(prevX - newX) < 2 && Math.abs(prevY - newY) < 2){
      return true;
    }
    return false;
  }
  
}
