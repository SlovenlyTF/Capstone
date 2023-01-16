//Tobias Friese
//tfries21@student.aau.dk
//06-01-2023
//OOP Software AAU Semester 3

package ChessPieces;

import Main.ChessBoard;
import Main.Game;
import Main.Vector2D;
import processing.core.PApplet;


public class Queen extends ChessPieceClass {

  private ChessBoard board;

  public Queen(int team, Vector2D coords, ChessBoard board, Game game, PApplet sketch){
    super(team, coords, board, 9, "Queen", "Images/White Queen.png", "Images/Black Queen.png", game, sketch);
    this.board = board;
  }
  
  
  
  @Override
  public boolean movement(Vector2D newCoords){
    
    //Makes sure that the desired position has no piece or it's an enemy piece.
    if(!(board.getChessPiece(new Vector2D(newCoords.getX(), newCoords.getY())) == null || super.getTeam() != board.getChessPiece(new Vector2D(newCoords.getX(), newCoords.getY())).getTeam())){
      return false;
    }
    
    //Checks if the movement done is diagonal or orthogonal.
    if(!(Math.abs(super.getPosition().getX() - newCoords.getX()) == Math.abs(super.getPosition().getY() - newCoords.getY()) || super.getPosition().getX() - newCoords.getX() == 0 || super.getPosition().getY() - newCoords.getY() == 0)){
      return false;
    }

    int horizontal = 0;
    int vertical = 0;
    
    //Horizontal
    if (super.getPosition().getX() > newCoords.getX()){ 
      horizontal = - 1;
    } else if (super.getPosition().getX() < newCoords.getX()){
      horizontal = 1;
    }
    
    //Vertical
    if (super.getPosition().getY() > newCoords.getY()){ 
      vertical = - 1;
    } else if (super.getPosition().getY() < newCoords.getY()){
      vertical = 1;
    }
    
    //Checks if there is a piece between the current position and the desired position.
    for(int i = super.getPosition().getX() + horizontal, j = super.getPosition().getY() + vertical; (0 != Math.abs(i - newCoords.getX()) || 0 != Math.abs(j - newCoords.getY())); i += horizontal, j += vertical){
      if(board.getChessPiece(new Vector2D(i, j)) != null){
        return false;
      }
    }


    super.revertVariables(); //Just set reverts justCastled and pawnDoubleMove boolean back after a successful move that is not a castle.
    return true;
  }
  
}
