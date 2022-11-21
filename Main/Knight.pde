public class Knight extends ChessPieceClass {
  
  Knight(int setTeam, Vector2D coords, ChessBoard tempBoard){
    super(setTeam, coords, tempBoard, 3, "Knight", "Images/White Knight.png", "Images/Black Knight.png");
  }
  
  
  @Override
  boolean movement(Vector2D newCoords){
    
    //Makes sure that the desired position has no piece or it's an enemy piece.
    if(board.getChessPiece(newCoords) == null || team != board.getChessPiece(newCoords).getTeam()){
    
      //Checks if the movement done is in an L shape.
      if((Math.abs(position.getX() - newCoords.getX()) == 2 && Math.abs(position.getY() - newCoords.getY()) == 1) || (Math.abs(position.getX() - newCoords.getX()) == 1 && Math.abs(position.getY() - newCoords.getY()) == 2)){
        revertVariables(); //Just set reverts justCastled boolean back after a successful move that is not a castle.
        return true;
      }
    }
    return false;
  }
  
  
}
