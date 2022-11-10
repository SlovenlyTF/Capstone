public class Knight extends ChessPieceClass {
  
  Knight(int setTeam, int x, int y, ChessBoard tempBoard){
    team = setTeam;
    value = 3;
    position[0] = x;
    position[1] = y;
    type = "Knight";
    board = tempBoard;
    if(team == 0){
      img = loadImage("Images/White Knight.png");
    } else {
      img = loadImage("Images/Black Knight.png");
    }
  }
  
  
  @Override
  boolean movement(int newX, int newY){
    
    //Makes sure that the desired position has no piece or it's an enemy piece.
    if(board.getChessPiece(newX, newY) == null || team != board.getChessPiece(newX, newY).getTeam()){
    
      //Checks if the movement done is in an L shape.
      if((Math.abs(position[0] - newX) == 2 && Math.abs(position[1] - newY) == 1) || (Math.abs(position[0] - newX) == 1 && Math.abs(position[1] - newY) == 2)){
        revertVariables(); //Just set reverts justCastled boolean back after a successful move that is not a castle.
        return true;
      }
    }
    return false;
  }
  
  
}
