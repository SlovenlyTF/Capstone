public class Pawn extends ChessPieceClass {
  
  ScoreBoard score;
  
  Pawn(int setTeam, int x, int y, ChessBoard tempBoard, ScoreBoard tempScore){
    team = setTeam;
    value = 1;
    position[0] = x;
    position[1] = y;
    type = "Pawn";
    board = tempBoard;
    score = tempScore;
    if(team == 0){
      img = loadImage("Images/White Pawn.png");
    } else {
      img = loadImage("Images/Black Pawn.png");
    }
  }
  
  
  @Override
  public boolean movement(int newX, int newY){
    
    if(!(position[1] == 1 || position[1] == boardSize - 2)){ //If the rook moved from a non start position.
      hasMoved = true;
    }
  
    
    if(board.getChessPiece(newX, newY) == null){
      //Check if it is in its original position and that it tries to move two spaces..
      if(!hasMoved && ((position[0] - newX == 0 && position[1] - newY == 2 && board.getChessPiece(position[0], position[1] - 1) == null) || (position[0] - newX == 0 && newY - position[1] == 2 && board.getChessPiece(position[0], position[1] + 1) == null))){
        
        return doublePawn();
        
        //Checks if the pawn tries to go diagonal and execute "en passant" move. Moves down.
      } else if(team == 1 && Math.abs(position[0] - newX) == 1 && newY - position[1] == 1){
        
        if(board.getChessPiece(newX, newY - 1) != null && board.getChessPiece(newX, newY - 1).getJustDoublePawn()){
        
          passant(-1);
          return true;
          
        }
        
        
        //Checks if the pawn tries to go diagonal and execute "en passant" move. Moves down.
      } else if(team == 0 && Math.abs(position[0] - newX) == 1 && position[1] - newY == 1){
      
        if(board.getChessPiece(newX, newY + 1) != null && board.getChessPiece(newX, newY + 1).getJustDoublePawn()){
        
          passant(1);
          return true;
          
        }
      
      } else {
        if(team == 0){
          if(position[0] - newX == 0 && position[1] - newY == 1){
            return standard(newY, 0);
          }
        } else {
          if(position[0] - newX == 0 && newY - position[1] == 1){
            return standard(newY, 1);
          }
        }
      }
    } else if (team != board.getChessPiece(newX, newY).getTeam()) {
      if(team == 0){
        if(Math.abs(position[0] - newX) == 1 && position[1] - newY == 1){
          return standard(newY, 0);
        }
      } else {
        if(Math.abs(position[0] - newX) == 1 && newY - position[1] == 1){
          return standard(newY, 1);
        }
      }
    }
    return false;
  }
  
  private void passant(int i){
    revertVariables(); //Just set reverts justCastled boolean back after a successful move that is not a castle.
    score.addTeamScore(1, turn % 2);
    score.addChessPieceType("Pawn", turn % 2);
    
    previousMoveBoard.setMatrix(board.getMatrix());
    
    board.removeChessPiece(newMouseX, newMouseY + i);
    performedPassant = true;
  }
  
  private boolean doublePawn(){
    revertVariables(); //Just set reverts justCastled boolean back after a successful move that is not a castle.
    performedPassant = false;
    justDoublePawn = true;
    if(turn % 2 == 0){
      board.setPawnDoubleMoveWhite(true);
    } else {
      board.setPawnDoubleMoveBlack(true);
    }
    return true;
  }
  
  private boolean standard(int newY, int team){
    revertVariables(); //Just set reverts justCastled boolean back after a successful move that is not a castle.
    convertQueen(position[0], position[1], newY, team);
    performedPassant = false;
    return true;
  }
  
  //Converts the pawn to a queen when reaching the others base.
  private void convertQueen(int x, int y, int checkY, int team){
    if(checkY == 0 || checkY == boardSize - 1){
      board.removeChessPiece(x, y);
      board.spawnNewPiece(x, y, team, "queen");
    }
  }
  
}
