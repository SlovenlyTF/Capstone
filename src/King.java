package src;

import processing.core.PApplet;

public class King extends ChessPieceClass {


  private Game game;
  private ChessBoard board;

  King(int team, Vector2D coords, ChessBoard board, Game game, PApplet sketch){
    super(team, coords, board, 0, "King", "Images/White King.png", "Images/Black King.png", game, sketch);
    this.game = game;
    this.board = board;
  }
  
  
  
  @Override
  public boolean movement(Vector2D newCoords){
    
    //Makes sure that the desired position has no piece or it's an enemy piece.
    if(!(board.getChessPiece(newCoords) == null || super.getTeam() != board.getChessPiece(newCoords).getTeam())){
      return false;
    }
    
    boolean canCastle = true;
    //Small castle.
    if(newCoords.getX() == (game.getBoardSize() / 2) + 2 && super.getPosition().getX() == game.getBoardSize() / 2 && !super.getHasMoved()&& board.getChessPiece(new Vector2D(game.getBoardSize() - 1, super.getPosition().getY())) != null && board.getChessPiece(new Vector2D(game.getBoardSize() - 1, super.getPosition().getY())).getType() == "Rook" && !board.getChessPiece(new Vector2D(game.getBoardSize() - 1, super.getPosition().getY())).getHasMoved()){
      for(int i = super.getPosition().getX() + 1; i < game.getBoardSize() - 1; i++){
        if(board.getChessPiece(new Vector2D(i, super.getPosition().getY())) != null){
          canCastle = false;
        }
      }
      if(canCastle){
        board.setChessPiece(new Vector2D(game.getBoardSize() - 1, super.getPosition().getY()), new Vector2D((game.getBoardSize() / 2) + 1, super.getPosition().getY())); //Puts the picked up piece into the cell that matches its new spot.
        board.getChessPiece(new Vector2D(game.getBoardSize() - 1, super.getPosition().getY())).setPosition(new Vector2D((game.getBoardSize() / 2) + 1, super.getPosition().getY())); //Sets the piece position inside the piece object.
        board.removeChessPiece(new Vector2D(game.getBoardSize() - 1, super.getPosition().getY())); //Remove the pointer to the piece in the previous spot.
        board.setJustCastled(true); //Tells the board that it just castled, so if the user undo, it can undo the castle.

        super.setPrevHasMoved(super.getHasMoved());
        super.setHasMoved(true);
        return true;
      }
    }


    //Long castle.
    if(newCoords.getX() == (game.getBoardSize() / 2) - 2 && super.getPosition().getX() == game.getBoardSize() / 2 && !super.getHasMoved()&& board.getChessPiece(new Vector2D(0, super.getPosition().getY())) != null && board.getChessPiece(new Vector2D(0, super.getPosition().getY())).getType() == "Rook" && !board.getChessPiece(new Vector2D(0, super.getPosition().getY())).getHasMoved()){
      for(int i = super.getPosition().getX() - 1; i > 0; i--){
        if(board.getChessPiece(new Vector2D(i, super.getPosition().getY())) != null){
          canCastle = false;
        }
      }
      if(canCastle){
        board.setChessPiece(new Vector2D(0, super.getPosition().getY()), new Vector2D((game.getBoardSize() / 2) - 1, super.getPosition().getY())); //Puts the picked up piece into the cell that matches its new spot.
        board.getChessPiece(new Vector2D(0, super.getPosition().getY())).setPosition(new Vector2D((game.getBoardSize() / 2) - 1, super.getPosition().getY())); //Sets the piece position inside the piece object.
        board.removeChessPiece(new Vector2D(0, super.getPosition().getY())); //Remove the pointer to the piece in the previous spot.
        board.setJustCastled(true); //Tells the board that it just castled, so if the user undo, it can undo the castle.

        super.setPrevHasMoved(super.getHasMoved());
        super.setHasMoved(true);
        return true;
      }
    }


    //Checks if the movement done is one space from its original postition.
    if(!(Math.abs(super.getPosition().getX() - newCoords.getX()) < 2 && Math.abs(super.getPosition().getY() - newCoords.getY()) < 2)){
      return false;
    }

    revertVariables(); //Just reverts justCastled and doublePawn boolean.

    super.setPrevHasMoved(super.getHasMoved());
    super.setHasMoved(true);
    return true;
  }
  
}
