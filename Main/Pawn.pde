public class Pawn extends ChessPieceClass {
  
  Pawn(int setTeam, Vector2D coords, ChessBoard tempBoard){
    super(setTeam, coords, tempBoard, 1, "Pawn", "Images/White Pawn.png", "Images/Black Pawn.png");
  }
  
  
  @Override
  public boolean movement(Vector2D newCoords){
    int checkPositionY = position.getY() - newCoords.getY();
    
    Vector2D newCoordsAboveOrBelow = new Vector2D(newCoords.getX(), newCoords.getY() + 1);
    Vector2D newCoordsOffset = new Vector2D(newCoords.getX(), newCoords.getY() + 1);
    
    if(team == 1){
      checkPositionY = newCoords.getY() - position.getY();
      newCoordsAboveOrBelow.setY(newCoords.getY() - 1);
      newCoordsOffset.setY(newCoords.getY() - 1);
    }
    
    if(board.getChessPiece(newCoords) == null){
      
      //Check if it is in its original position and that it tries to move two spaces.
      if(!hasMoved && 
          position.getX() - newCoords.getX() == 0 &&
          checkPositionY == 2 &&
          board.getChessPiece(newCoordsAboveOrBelow) == null){
        
        return doublePawn();
        
        //Checks if the pawn tries to go diagonal and execute "en passant" move. Moves down.
      } else if(Math.abs(position.getX() - newCoords.getX()) == 1 && checkPositionY == 1){
        
        if(board.getChessPiece(newCoordsOffset) != null && board.getChessPiece(newCoordsOffset).getJustDoublePawn()){
        
          return passant(newCoordsOffset);
         
        } 
      } else {
        if(position.getX() - newCoords.getX() == 0 && checkPositionY == 1){
          return standard(newCoords);
        }
      }
    } else if (team != board.getChessPiece(newCoords).getTeam()) {

      if(Math.abs(position.getX() - newCoords.getX()) == 1 && checkPositionY == 1){
        return standard(newCoords);
      }
    }
    return false;
  }
  
  
  //Peform the en passant move.
  private boolean passant(Vector2D newCoordsOffset){
    revertVariables(); //Just set reverts justCastled boolean back after a successful move that is not a castle.
    game.score.addTeamScore(1, game.getTurn() % 2);
    game.score.addChessPieceType("Pawn", game.getTurn() % 2);
    
    game.previousMoveBoard.setMatrix(board.getMatrix());
    
    board.removeChessPiece(newCoordsOffset);
    performedPassant = true;
    
    prevHasMoved = hasMoved;
    hasMoved = true;
    return true;
  }
  
  
  //Peform the double move.
  private boolean doublePawn(){
    revertVariables(); //Just set reverts justCastled boolean back after a successful move that is not a castle.
    performedPassant = false;
    justDoublePawn = true;
    if(game.getTurn() % 2 == 0){
      board.setPawnDoubleMoveWhite(true);
    } else {
      board.setPawnDoubleMoveBlack(true);
    }
    
    prevHasMoved = hasMoved;
    hasMoved = true;
    return true;
  }
  
  
  //Just moves one space.
  private boolean standard(Vector2D coords){
    revertVariables(); //Just set reverts justCastled boolean back after a successful move that is not a castle.
    convertCheck(coords);
    performedPassant = false;
    
    prevHasMoved = hasMoved;
    hasMoved = true;
    return true;
  }
  
  
  //Converts the pawn to a queen when reaching the others base.
  private void convertCheck(Vector2D coords){
    if(coords.getY() == 0 || coords.getY() == game.getBoardSize() - 1){
      board.setPieceSelectionPawn(true);
      board.setPawnPosition(coords);
    }
  }
  
}
