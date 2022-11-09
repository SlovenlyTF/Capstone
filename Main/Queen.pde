public class Queen extends ChessPieceClass {
  
  Queen(int setTeam, int x, int y, ChessBoard tempBoard){
    team = setTeam;
    value = 9;
    position[0] = x;
    position[1] = y;
    type = "Queen";
    board = tempBoard;
    if(team == 0){
      img = loadImage("Images/White Queen.png");
    } else {
      img = loadImage("Images/Black Queen.png");
    }
  }
  
  
  
  @Override
  boolean movement(int prevX, int prevY, int newX, int newY){
    
    //Checks if there is a piece between the current position and the desired position.
    if(prevX < newX && prevY - newY == 0){ //Right
      for(int i = prevX + 1; i < newX; i++){
        if(board.getChessPiece(i, prevY) != null){
          return false;
        }
      }
    } else if (prevX > newX && prevY - newY == 0){ //Left
      for(int i = prevX - 1; i > newX; i--){
        if(board.getChessPiece(i, prevY) != null){
          return false;
        }
      }
    } else if (prevX - newX == 0 && prevY < newY){ //Up
      for(int i = prevY + 1; i < newY; i++){
        if(board.getChessPiece(prevX, i) != null){
          return false;
        }
      }
    } else { //Down
      for(int i = prevY - 1; i > newY; i--){
        if(board.getChessPiece(prevX, i) != null){
          return false;
        }
      }
    }
    
    
    //Checks if the movement done is diagonal or orthogonal.
    if(Math.abs(prevX - newX) == Math.abs(prevY - newY) || prevX - newX == 0 || prevY - newY == 0){
      return true;
    }
    return false;
  }
  
}
