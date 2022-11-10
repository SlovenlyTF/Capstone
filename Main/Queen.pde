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
  boolean movement(int newX, int newY){
    
    //Makes sure that the desired position has no piece or it's an enemy piece.
    if(board.getChessPiece(newX, newY) == null || team != board.getChessPiece(newX, newY).getTeam()){
      
      //Checks if there is a piece between the current position and the desired position.
      if(position[0] < newX && position[1] < newY){ //Down Right
        for(int i = position[0] + 1, j = position[1] + 1; i < newX; i++, j++){ 
          if(board.getChessPiece(i, j) != null){
            return false;
          }
        }
      } else if (position[0] > newX && position[1] < newY){ //Down Left
        for(int i = position[0] - 1, j = position[1] + 1; i > newX; i--, j++){ 
          if(board.getChessPiece(i, j) != null){
            return false;
          }
        }
      } else if (position[0] < newX && position[1] > newY){ //Up Right
        for(int i = position[0] + 1, j = position[1] - 1; i < newX; i++, j--){ 
          if(board.getChessPiece(i, j) != null){
            return false;
          }
        }
      } else if (position[0] > newX && position[1] > newY){ //Up Left
        for(int i = position[0] - 1, j = position[1] - 1; i > newX; i--, j--){ 
          if(board.getChessPiece(i, j) != null){
            return false;
          }
        }
      } else if(position[0] < newX && position[1] - newY == 0){ //Right
        for(int i = position[0] + 1; i < newX; i++){
          if(board.getChessPiece(i, position[1]) != null){
            return false;
          }
        }
      } else if (position[0] > newX && position[1] - newY == 0){ //Left
        for(int i = position[0] - 1; i > newX; i--){
          if(board.getChessPiece(i, position[1]) != null){
            return false;
          }
        }
      } else if (position[0] - newX == 0 && position[1] < newY){ //Up
        for(int i = position[1] + 1; i < newY; i++){
          if(board.getChessPiece(position[0], i) != null){
            return false;
          }
        }
      } else { //Down
        for(int i = position[1] - 1; i > newY; i--){
          if(board.getChessPiece(position[0], i) != null){
            return false;
          }
        }
      }
      
      //Checks if the movement done is diagonal or orthogonal.
      if(Math.abs(position[0] - newX) == Math.abs(position[1] - newY) || position[0] - newX == 0 || position[1] - newY == 0){
        revertVariables(); //Just set reverts justCastled boolean back after a successful move that is not a castle.
        return true;
      }
    }
    return false;
  }
  
}
