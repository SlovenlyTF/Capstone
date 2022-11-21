public class King extends ChessPieceClass {
  
  King(int setTeam, Vector2D coords, ChessBoard tempBoard){
    super(setTeam, coords, tempBoard, 0, "King", "Images/White King.png", "Images/Black King.png");
  }
  
  
  @Override
  boolean movement(Vector2D newCoords){
    
    //Makes sure that the desired position has no piece or it's an enemy piece.
    if(board.getChessPiece(newCoords) == null || team != board.getChessPiece(newCoords).getTeam()){
    
      //Checks if the movement done is one space from its original postition.
      if(Math.abs(position.getX() - newCoords.getX()) < 2 && Math.abs(position.getY() - newCoords.getY()) < 2){
        revertVariables(); //Just reverts justCastled and doublePawn boolean.
        
        prevHasMoved = hasMoved;
        hasMoved = true;
        return true;
      }
      
      boolean canCastle = true;
      //Small castle.
      if(newCoords.getX() == (game.getBoardSize() / 2) + 2 && position.getX() == game.getBoardSize() / 2 && !hasMoved && board.getChessPiece(new Vector2D(game.getBoardSize() - 1, position.getY())) != null && board.getChessPiece(new Vector2D(game.getBoardSize() - 1, position.getY())).getType() == "Rook" && !board.getChessPiece(new Vector2D(game.getBoardSize() - 1, position.getY())).getHasMoved()){
        for(int i = position.getX() + 1; i < game.getBoardSize() - 1; i++){
          if(board.getChessPiece(new Vector2D(i, position.getY())) != null){
            canCastle = false;
          }
        }
        if(canCastle){
          board.setChessPiece(new Vector2D(game.getBoardSize() - 1, position.getY()), new Vector2D((game.getBoardSize() / 2) + 1, position.getY())); //Puts the picked up piece into the cell that matches its new spot.
          board.getChessPiece(new Vector2D(game.getBoardSize() - 1, position.getY())).setPosition(new Vector2D((game.getBoardSize() / 2) + 1, position.getY())); //Sets the piece position inside the piece object.
          board.removeChessPiece(new Vector2D(game.getBoardSize() - 1, position.getY())); //Remove the pointer to the piece in the previous spot.
          board.setJustCastled(true); //Tells the board that it just castled, so if the user undo, it can undo the castle.
          
          prevHasMoved = hasMoved;
          hasMoved = true;
          return true;
        }
      }
      
      //Long castle.
      if(newCoords.getX() == (game.getBoardSize() / 2) - 2 && position.getX() == game.getBoardSize() / 2 && !hasMoved && board.getChessPiece(new Vector2D(0, position.getY())) != null && board.getChessPiece(new Vector2D(0, position.getY())).getType() == "Rook" && !board.getChessPiece(new Vector2D(0, position.getY())).getHasMoved()){
        for(int i = position.getX() - 1; i > 0; i--){
          if(board.getChessPiece(new Vector2D(i, position.getY())) != null){
            canCastle = false;
          }
        }
        if(canCastle){
          board.setChessPiece(new Vector2D(0, position.getY()), new Vector2D((game.getBoardSize() / 2) - 1, position.getY())); //Puts the picked up piece into the cell that matches its new spot.
          board.getChessPiece(new Vector2D(0, position.getY())).setPosition(new Vector2D((game.getBoardSize() / 2) - 1, position.getY())); //Sets the piece position inside the piece object.
          board.removeChessPiece(new Vector2D(0, position.getY())); //Remove the pointer to the piece in the previous spot.
          board.setJustCastled(true); //Tells the board that it just castled, so if the user undo, it can undo the castle.
          
          prevHasMoved = hasMoved;
          hasMoved = true;
          return true;
        }
      }
      
    }
    return false;
  }
  
}
