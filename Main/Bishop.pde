public class Bishop extends ChessPieceClass {
  
  Bishop(int setTeam, Vector2D coords, ChessBoard tempBoard){
    super(setTeam, coords, tempBoard, 3, "Bishop", "Images/White Bishop.png", "Images/Black Bishop.png");
  }
  
  
  @Override
  boolean movement(Vector2D newCoords){
    
    //Makes sure that the desired position has no piece or it's an enemy piece.
    if(game.board.getChessPiece(newCoords) == null || team != board.getChessPiece(newCoords).getTeam()){
      
      //Default is down right.
      int horizontal = 1;
      int vertical = 1;
      
      if (position.getX() > newCoords.getX() && position.getY() < newCoords.getY()){ //Down Left
        horizontal = - 1;
      } else if (position.getX() < newCoords.getX() && position.getY() > newCoords.getY()){ //Up Right
        vertical = -1;
      } else { //Up Left
        horizontal = -1;
        vertical = -1;
      }
      
      
      //Checks if there is a piece between the current position and the desired position.
      for(int i = position.getX() + horizontal, j = position.getY() + vertical; i < newCoords.getX(); i += horizontal, j += vertical){
        if(board.getChessPiece(new Vector2D(i, j)) != null){
          return false;
        }
      }
      
      
      //Checks if the movement done is diagonal.
      if(Math.abs(position.getX() - newCoords.getX()) == Math.abs(position.getY() - newCoords.getY())){
        revertVariables(); //Just set reverts justCastled boolean back after a successful move that is not a castle.
        return true;
      }
    }
    return false;
  }
  
  
}
