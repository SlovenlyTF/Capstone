package ChessPieces;

import Main.ChessBoard;
import Main.Game;
import Main.Vector2D;
import processing.core.PApplet;

public class Pawn extends ChessPieceClass {

  private ChessBoard board;
  private Game game;

  public Pawn(int team, Vector2D coords, ChessBoard board, Game game, PApplet sketch){
    super(team, coords, board, 1, "Pawn", "Images/White Pawn.png", "Images/Black Pawn.png", game, sketch);
    this.board = board;
    this.game = game;
  }
  
  
  
  @Override
  public boolean movement(Vector2D newCoords){
    int checkPositionY = super.getPosition().getY() - newCoords.getY();
    
    Vector2D newCoordsAboveOrBelow = new Vector2D(newCoords.getX(), newCoords.getY() + 1);
    Vector2D newCoordsOffset = new Vector2D(newCoords.getX(), newCoords.getY() + 1);
    
    if(super.getTeam() == 1){
      checkPositionY = newCoords.getY() - super.getPosition().getY();
      newCoordsAboveOrBelow.setY(newCoords.getY() - 1);
      newCoordsOffset.setY(newCoords.getY() - 1);
    }
    
    if(board.getChessPiece(newCoords) == null){
      
      //Check if it is in its original position and that it tries to move two spaces.
      if(!super.getHasMoved() &&
          super.getPosition().getX() - newCoords.getX() == 0 &&
          checkPositionY == 2 &&
          board.getChessPiece(newCoordsAboveOrBelow) == null){
        
        return doublePawn();
        
        //Checks if the pawn tries to go diagonal and execute "en passant" move. Moves down.
      } else if(Math.abs(super.getPosition().getX() - newCoords.getX()) == 1 && checkPositionY == 1){
        
        if(board.getChessPiece(newCoordsOffset) != null && board.getChessPiece(newCoordsOffset).getJustDoublePawn()){
          return passant(newCoordsOffset);
        } 
      } else {
        if(super.getPosition().getX() - newCoords.getX() == 0 && checkPositionY == 1){
          return standard(newCoords);
        }
      }
      
      
    } else if (super.getTeam() != board.getChessPiece(newCoords).getTeam()) {

      if(Math.abs(super.getPosition().getX() - newCoords.getX()) == 1 && checkPositionY == 1){
        return standard(newCoords);
      }
    }
    
    return false;
  }
  
  
  
  //Peform the en passant move.
  private boolean passant(Vector2D newCoordsOffset){
    revertVariables(); //Just set reverts justCastled boolean back after a successful move that is not a castle.
    game.getScore().addTeamScore(1, game.getTurn() % 2);
    game.getScore().addChessPieceType("Pawn", game.getTurn() % 2);
    
    game.getPreviousMoveBoard().setChessPieceClassMatrix(board.getChessPieceClassMatrix());
    
    board.removeChessPiece(newCoordsOffset);
    super.setPerformedPassant(true);

    super.setPrevHasMoved(super.getHasMoved());
    super.setHasMoved(true);
    return true;
  }
  
  
  
  //Peform the double move.
  private boolean doublePawn(){
    revertVariables(); //Just set reverts justCastled boolean back after a successful move that is not a castle.
    super.setPerformedPassant(false);
    super.setJustDoublePawn(true);
    if(game.getTurn() % 2 == 0){
      board.setPawnDoubleMoveWhite(true);
    } else {
      board.setPawnDoubleMoveBlack(true);
    }

    super.setPrevHasMoved(super.getHasMoved());
    super.setHasMoved(true);
    return true;
  }
  
  
  
  //Just moves one space.
  private boolean standard(Vector2D coords){
    revertVariables(); //Just set reverts justCastled boolean back after a successful move that is not a castle.
    convertCheck(coords);
    super.setPerformedPassant(false);

    super.setPrevHasMoved(super.getHasMoved());
    super.setHasMoved(true);
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
