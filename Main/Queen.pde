public class Queen extends ChessPieceClass {
  
  Queen(int setTeam, Vector2D coords, ChessBoard tempBoard){
    super(setTeam, coords, tempBoard, 9, "Queen", "Images/White Queen.png", "Images/Black Queen.png");
  }
  
  
  @Override
  boolean movement(Vector2D newCoords){
    
    //Makes sure that the desired position has no piece or it's an enemy piece.
    if(board.getChessPiece(new Vector2D(newCoords.getX(), newCoords.getY())) == null || team != board.getChessPiece(new Vector2D(newCoords.getX(), newCoords.getY())).getTeam()){
      
      //Checks if there is a piece between the current position and the desired position.
      if(position.getX() < newCoords.getX() && position.getY() < newCoords.getY()){ //Down Right
        for(int i = position.getX() + 1, j = position.getY() + 1; i < newCoords.getX(); i++, j++){ 
          if(board.getChessPiece(new Vector2D(i, j)) != null){
            return false;
          }
        }
      } else if (position.getX() > newCoords.getX() && position.getY() < newCoords.getY()){ //Down Left
        for(int i = position.getX() - 1, j = position.getY() + 1; i > newCoords.getX(); i--, j++){ 
          if(board.getChessPiece(new Vector2D(i, j)) != null){
            return false;
          }
        }
      } else if (position.getX() < newCoords.getX() && position.getY() > newCoords.getY()){ //Up Right
        for(int i = position.getX() + 1, j = position.getY() - 1; i < newCoords.getX(); i++, j--){ 
          if(board.getChessPiece(new Vector2D(i, j)) != null){
            return false;
          }
        }
      } else if (position.getX() > newCoords.getX() && position.getY() > newCoords.getY()){ //Up Left
        for(int i = position.getX() - 1, j = position.getY() - 1; i > newCoords.getX(); i--, j--){ 
          if(board.getChessPiece(new Vector2D(i, j)) != null){
            return false;
          }
        }
      } else if(position.getX() < newCoords.getX() && position.getY() - newCoords.getY() == 0){ //Right
        for(int i = position.getX() + 1; i < newCoords.getX(); i++){
          if(board.getChessPiece(new Vector2D(i, position.getY())) != null){
            return false;
          }
        }
      } else if (position.getX() > newCoords.getX() && position.getY() - newCoords.getY() == 0){ //Left
        for(int i = position.getX() - 1; i > newCoords.getX(); i--){
          if(board.getChessPiece(new Vector2D(i, position.getY())) != null){
            return false;
          }
        }
      } else if (position.getX() - newCoords.getX() == 0 && position.getY() < newCoords.getY()){ //Up
        for(int i = position.getY() + 1; i < newCoords.getY(); i++){
          if(board.getChessPiece(new Vector2D(position.getX(), i)) != null){
            return false;
          }
        }
      } else { //Down
        for(int i = position.getY() - 1; i > newCoords.getY(); i--){
          if(board.getChessPiece(new Vector2D(position.getX(), i)) != null){
            return false;
          }
        }
      }
      //Checks if the movement done is diagonal or orthogonal.
      if(Math.abs(position.getX() - newCoords.getX()) == Math.abs(position.getY() - newCoords.getY()) || position.getX() - newCoords.getX() == 0 || position.getY() - newCoords.getY() == 0){
        revertVariables(); //Just set reverts justCastled boolean back after a successful move that is not a castle.
        return true;
      }
    }
    return false;
  }
  
}
