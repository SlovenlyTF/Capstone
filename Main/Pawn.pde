public class Pawn extends ChessPieceClass {
  
  boolean hasMoved = false;
  
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
    
    if(board.getChessPiece(newX, newY) == null){
      //Check if it is in its original position.
      if(position[1] == 1 || position[1] == 6){
        //Checks if the movement done is one space from its original postition.
        if(team == 0){
          if(position[0] - newX == 0 && position[1] - newY < 3 && position[1] - newY > 0 && board.getChessPiece(position[0], position[1] - 1) == null){
            revertJustCastled(); //Just set reverts justCastled boolean back after a successful move that is not a castle.
            convertQueen(position[0], position[1], newY, 0);
            return true;
          }
        } else {
          if(position[0] - newX == 0 && newY - position[1] < 3 && newY - position[1] > 0 && board.getChessPiece(position[0], position[1] + 1) == null){
            revertJustCastled(); //Just set reverts justCastled boolean back after a successful move that is not a castle.
            convertQueen(position[0], position[1], newY, 1);
            return true;
          }
        }
      } else {
        if(team == 0){
          if(position[0] - newX == 0 && position[1] - newY == 1){
          revertJustCastled(); //Just set reverts justCastled boolean back after a successful move that is not a castle.
            convertQueen(position[0], position[1], newY, 0);
            return true;
          }
        } else {
          if(position[0] - newX == 0 && newY - position[1] == 1){
          revertJustCastled(); //Just set reverts justCastled boolean back after a successful move that is not a castle.
            convertQueen(position[0], position[1], newY, 1);
            return true;
          }
        }
      }
    } else if (team != board.getChessPiece(newX, newY).getTeam()) {
      if(team == 0){
        if(Math.abs(position[0] - newX) == 1 && position[1] - newY == 1){
          revertJustCastled(); //Just set reverts justCastled boolean back after a successful move that is not a castle.
          convertQueen(position[0], position[1], newY, 0);
          return true;
        }
      } else {
        if(Math.abs(position[0] - newX) == 1 && newY - position[1] == 1){
          revertJustCastled(); //Just set reverts justCastled boolean back after a successful move that is not a castle.
          convertQueen(position[0], position[1], newY, 1);
          return true;
        }
      }
    }
    return false;
  }
  
  //Converts the pawn to a queen when reaching the others base.
  private void convertQueen(int x, int y, int checkY, int team){
    if(checkY == 0 || checkY == 7){
      board.removeChessPiece(x, y);
      board.spawnNewPiece(x, y, team, "queen");
    }
  }
  
}
