public class Rook extends ChessPieceClass {
  
  Rook(int setTeam, Vector2D coords, ChessBoard tempBoard){
    super(setTeam, coords, tempBoard, 5, "Rook", "Images/White Rook.png", "Images/Black Rook.png");
  }
  
  
  @Override
  boolean movement(Vector2D newCoords){
    
    //Makes sure that the desired position has no piece or it's an enemy piece.
    if(board.getChessPiece(newCoords) == null || team != board.getChessPiece(newCoords).getTeam()){
    
      //Checks if there is a piece between the current position and the desired position.
      if(position.getX() < newCoords.getX() && position.getY() - newCoords.getY() == 0){ //Right
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
      
      //Checks if the movement done is orthogonal.
      if(position.getX() - newCoords.getX() == 0 || position.getY() - newCoords.getY() == 0){
        revertVariables(); //Just set reverts justCastled boolean back after a successful move that is not a castle.
        
        prevHasMoved = hasMoved;
        hasMoved = true;
        return true;
      }
    }
    return false;
  }
  
  
}
