public class King extends ChessPieceClass {
  
  King(int setTeam, int x, int y, ChessBoard tempBoard){
    team = setTeam;
    value = 0;
    position[0] = x;
    position[1] = y;
    type = "King";
    board = tempBoard;
    if(team == 0){
      img = loadImage("Images/White King.png");
    } else {
      img = loadImage("Images/Black King.png");
    }
  }  
  
  
  @Override
  boolean movement(int newX, int newY){
    
    //Makes sure that the desired position has no piece or it's an enemy piece.
    if(board.getChessPiece(newX, newY) == null || team != board.getChessPiece(newX, newY).getTeam()){
    
      //Checks if the movement done is one space from its original postition.
      if(Math.abs(position[0] - newX) < 2 && Math.abs(position[1] - newY) < 2){
        revertVariables(); //Just set reverts justCastled boolean back after a successful move that is not a castle.
        if(!((position[0] == 4 && position[1] == 7) || (position[0] == 4 && position[1] == 0))){ //If the king moved from a non start position
          hasMoved = true;
        }
        return true;
      }
      
      boolean canCastle = true;
      //Small castle.
      if(newX == (game.getBoardSize() / 2) + 2 && position[0] == game.getBoardSize() / 2 && !hasMoved && board.getChessPiece(game.getBoardSize() - 1, position[1]) != null && board.getChessPiece(game.getBoardSize() - 1, position[1]).getType() == "Rook" && !board.getChessPiece(game.getBoardSize() - 1, position[1]).getHasMoved()){
        for(int i = position[0] + 1; i < game.getBoardSize() - 1; i++){
          if(board.getChessPiece(i, position[1]) != null){
            canCastle = false;
          }
        }
        if(canCastle){
          board.setChessPiece(game.getBoardSize() - 1, position[1], (game.getBoardSize() / 2) + 1, position[1]); //Puts the picked up piece into the cell that matches its new spot.
          board.getChessPiece(game.getBoardSize() - 1, position[1]).setPosition((game.getBoardSize() / 2) + 1, position[1]); //Sets the piece position inside the piece object.
          board.removeChessPiece(game.getBoardSize() - 1, position[1]); //Remove the pointer to the piece in the previous spot.
          board.setJustCastled(true); //Tells the board that it just castled, so if the user undo, it can undo the castle.
          return true;
        }
      }
      
      //Long castle.
      if(newX == (game.getBoardSize() / 2) - 2 && position[0] == game.getBoardSize() / 2 && !hasMoved && board.getChessPiece(0, position[1]) != null && board.getChessPiece(0, position[1]).getType() == "Rook" && !board.getChessPiece(0, position[1]).getHasMoved()){
        for(int i = position[0] - 1; i > 0; i--){
          if(board.getChessPiece(i, position[1]) != null){
            canCastle = false;
          }
        }
        if(canCastle){
          board.setChessPiece(0, position[1], (game.getBoardSize() / 2) - 1, position[1]); //Puts the picked up piece into the cell that matches its new spot.
          board.getChessPiece(0, position[1]).setPosition((game.getBoardSize() / 2) - 1, position[1]); //Sets the piece position inside the piece object.
          board.removeChessPiece(0, position[1]); //Remove the pointer to the piece in the previous spot.
          board.setJustCastled(true); //Tells the board that it just castled, so if the user undo, it can undo the castle.
          return true;
        }
      }
      
    }
    return false;
  }
  
}
