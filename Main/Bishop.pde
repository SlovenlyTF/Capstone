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
  boolean movement(int newX, int newY){
    
    //Makes sure that the desired position has no piece or it's an enemy piece.
    if(game.board.getChessPiece(newX, newY) == null || team != board.getChessPiece(newX, newY).getTeam()){
      
      
      
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
      } else { //Up Left
        for(int i = position[0] - 1, j = position[1] - 1; i > newX; i--, j--){ 
          if(board.getChessPiece(i, j) != null){
            return false;
          }
        }
      }
      
      //Checks if the movement done is diagonal.
      if(Math.abs(position[0] - newX) == Math.abs(position[1] - newY)){
        revertVariables(); //Just set reverts justCastled boolean back after a successful move that is not a castle.
        return true;
      }
    }
    return false;
  }
  
  
}
