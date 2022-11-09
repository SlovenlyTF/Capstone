public class Bishop extends ChessPieceClass {
  
  Bishop(int setTeam, int x, int y, ChessBoard tempBoard){
    team = setTeam;
    value = 3;
    position[0] = x;
    position[1] = y;
    type = "Bishop";
    board = tempBoard;
    if(team == 0){
      img = loadImage("Images/White Bishop.png");
    } else {
      img = loadImage("Images/Black Bishop.png");
    }
  }
  
  
  @Override
  boolean movement(int prevX, int prevY, int newX, int newY){

    
    //Checks if there is a piece between the current position and the desired position.
    if(prevX < newX && prevY < newY){ //Down Right
      for(int i = prevX + 1, j = prevY + 1; i < newX; i++, j++){ 
        if(board.getChessPiece(i, j) != null){
          return false;
        }
      }
    } else if (prevX > newX && prevY < newY){ //Down Left
      for(int i = prevX - 1, j = prevY + 1; i > newX; i--, j++){ 
        if(board.getChessPiece(i, j) != null){
          return false;
        }
      }
    } else if (prevX < newX && prevY > newY){ //Up Right
      for(int i = prevX + 1, j = prevY - 1; i < newX; i++, j--){ 
        if(board.getChessPiece(i, j) != null){
          return false;
        }
      }
    } else { //Up Left
      for(int i = prevX - 1, j = prevY - 1; i > newX; i--, j--){ 
        if(board.getChessPiece(i, j) != null){
          return false;
        }
      }
    }
    
    //Checks if the movement done is diagonal.
    if(Math.abs(prevX - newX) == Math.abs(prevY - newY)){
      return true;
    }
    return false;
  }
  
  
}
