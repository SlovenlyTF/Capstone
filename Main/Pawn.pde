public class Pawn extends ChessPieceClass {
  
  boolean hasMoved = false;
  
  Pawn(int setTeam, int x, int y, ChessBoard tempBoard){
    team = setTeam;
    value = 1;
    position[0] = x;
    position[1] = y;
    type = "Pawn";
    board = tempBoard;
    if(team == 0){
      img = loadImage("Images/White Pawn.png");
    } else {
      img = loadImage("Images/Black Pawn.png");
    }
  }
  
  
  
  @Override
  boolean movement(int prevX, int prevY, int newX, int newY){
    
    if(board.getChessPiece(newX, newY) == null){
      //Check if it is in its original position.
      if(prevY == 1 || prevY == 6){
        //Checks if the movement done is one space from its original postition.
        if(team == 0){
          if(prevX - newX == 0 && prevY - newY < 3 && prevY - newY > 0 && board.getChessPiece(prevX, prevY - 1) == null){
            return true;
          }
        } else {
          if(prevX - newX == 0 && newY - prevY < 3 && newY - prevY > 0 && board.getChessPiece(prevX, prevY + 1) == null){
            return true;
          }
        }
      } else {
        if(team == 0){
          if(prevX - newX == 0 && prevY - newY == 1){
            return true;
          }
        } else {
          if(prevX - newX == 0 && newY - prevY == 1){
            return true;
          }
        }
      }
    } else {
      if(team == 0){
        if(Math.abs(prevX - newX) == 1 && prevY - newY == 1){
          return true;
        }
      } else {
        if(Math.abs(prevX - newX) == 1 && newY - prevY == 1){
          return true;
        }
      }
    }
    return false;
  }
  
  
}
