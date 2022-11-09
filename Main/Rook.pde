public class Rook extends ChessPieceClass {
  
  Rook(int setTeam, int x, int y, ChessBoard tempBoard){
    team = setTeam;
    value = 5;
    position[0] = x;
    position[1] = y;
    type = "Rook";
    board = tempBoard;
    if(team == 0){
      img = loadImage("Images/White Rook.png");
    } else {
      img = loadImage("Images/Black Rook.png");
    }
  }
  
  @Override
  boolean movement(int newX, int newY){
    
    //Makes sure that the desired position has no piece or it's an enemy piece.
    if(board.getChessPiece(newX, newY) == null || team != board.getChessPiece(newX, newY).getTeam()){
    
      //Checks if there is a piece between the current position and the desired position.
      if(position[0] < newX && position[1] - newY == 0){ //Right
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
      
      //Checks if the movement done is orthogonal.
      if(position[0] - newX == 0 || position[1] - newY == 0){
        revertJustCastled(); //Just set reverts justCastled boolean back after a successful move that is not a castle.
        if(!((position[0] == 7 && position[1] == 7) || (position[0] == 7 && position[1] == 0) || (position[0] == 0 && position[1] == 7) || (position[0] == 0 && position[1] == 0))){ //If the rook moved from a non start position.
          hasMoved = true;
        }
        return true;
      }
    }
    return false;
  }
  
  
}
