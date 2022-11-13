public class Pawn extends ChessPieceClass {
  
  Pawn(int setTeam, int x, int y, ChessBoard tempBoard){
    team = setTeam;
    value = 1;
    position[0] = x;
    position[1] = y;
    type = "Pawn";
    board = tempBoard;
    if(team == 0){
      img = loadImage("Images/White Pawn.png");
    } else {
      img = loadImage("Images/Black Pawn.png");
    }
  }
  
  
  @Override
  public boolean movement(int newX, int newY){
    int checkPositionY = position[1] - newY;
    int offsetY = 1;
    
    if(team == 1){
      checkPositionY = newY - position[1];
      offsetY = - 1;
    }
  
    
    if(board.getChessPiece(newX, newY) == null){
      //Check if it is in its original position and that it tries to move two spaces.
      if(!hasMoved && ((position[0] - newX == 0 && position[1] - newY == 2 && board.getChessPiece(position[0], position[1] - 1) == null) || (position[0] - newX == 0 && newY - position[1] == 2 && board.getChessPiece(position[0], position[1] + 1) == null))){
        
        return doublePawn();
        
        //Checks if the pawn tries to go diagonal and execute "en passant" move. Moves down.
      } else if(Math.abs(position[0] - newX) == 1 && checkPositionY == 1){
        
        if(board.getChessPiece(newX, newY + offsetY) != null && board.getChessPiece(newX, newY + offsetY).getJustDoublePawn()){
        
          return passant(offsetY, newX, newY);
         
        } 
      } else {
        if(position[0] - newX == 0 && checkPositionY == 1){
          return standard(newX, newY);
        }
      }
    } else if (team != board.getChessPiece(newX, newY).getTeam()) {

      if(Math.abs(position[0] - newX) == 1 && checkPositionY == 1){
        return standard(newX, newY);
      }
    }
    return false;
  }
  
  
  //Peform the en passant move.
  private boolean passant(int i, int newX, int newY){
    revertVariables(); //Just set reverts justCastled boolean back after a successful move that is not a castle.
    game.score.addTeamScore(1, game.getTurn() % 2);
    game.score.addChessPieceType("Pawn", game.getTurn() % 2);
    
    game.previousMoveBoard.setMatrix(board.getMatrix());
    
    board.removeChessPiece(newX, newY + i);
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
  private boolean standard(int newX, int newY){
    revertVariables(); //Just set reverts justCastled boolean back after a successful move that is not a castle.
    convertCheck(newX, newY);
    performedPassant = false;
    
    prevHasMoved = hasMoved;
    hasMoved = true;
    return true;
  }
  
  
  //Converts the pawn to a queen when reaching the others base.
  private void convertCheck(int x, int y){
    if(y == 0 || y == game.getBoardSize() - 1){
      board.setPieceSelectionPawn(true);
      int i[] = {x, y};
      board.setPawnPosition(i);
    }
  }
  
}
