//Tobias Friese
//tfries21@student.aau.dk
//06-01-2023
//OOP Software AAU Semester 3

package ChessPieces;

import Main.ChessBoard;
import Main.Game;
import Main.Vector2D;
import processing.core.PApplet;

public class Bishop extends ChessPieceClass {

  private ChessBoard board;
  private Game game;

  public Bishop(int team, Vector2D coords, ChessBoard board, Game game, PApplet sketch){
    super(team, coords, board, 3, "Bishop", "Images/White Bishop.png", "Images/Black Bishop.png", game, sketch);
    this.board = board;
    this.game = game;
  }
  
  
  @Override
  public boolean movement(Vector2D newCoords){
    
    //Makes sure that the desired position has no piece or it's an enemy piece.
    if(!(game.getBoard().getChessPiece(newCoords) == null || super.getTeam() != board.getChessPiece(newCoords).getTeam())){
      return false;
    }
    
    
    //Checks if the movement done is diagonal.
    if(!(Math.abs(super.getPosition().getX() - newCoords.getX()) == Math.abs(super.getPosition().getY() - newCoords.getY()))){
      return false;
    }
    
    
    //Default is down right.
    int horizontal = 1;
    int vertical = 1;
    
    if (super.getPosition().getX() > newCoords.getX()){ //Horizontal
      horizontal = - 1;
    }
    if (super.getPosition().getY() > newCoords.getY()){ //Vertical
      vertical = - 1;
    }
    
    
    //Checks if there is a piece between the current position and the desired position.
    for(int i = super.getPosition().getX() + horizontal, j = super.getPosition().getY() + vertical; 0 != Math.abs(i - newCoords.getX()); i += horizontal, j += vertical){
      if(board.getChessPiece(new Vector2D(i, j)) != null){
        return false;
      }
    }


    super.revertVariables(); //Just set reverts justCastled and pawnDoubleMove boolean back after a successful move that is not a castle.
    return true;
  }
  
  
}
