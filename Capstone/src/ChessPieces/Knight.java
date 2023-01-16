//Tobias Friese
//tfries21@student.aau.dk
//06-01-2023
//OOP Software AAU Semester 3

package ChessPieces;

import Main.ChessBoard;
import Main.Game;
import Main.Vector2D;
import processing.core.PApplet;

public class Knight extends ChessPieceClass {

  private ChessBoard board;

  public Knight(int team, Vector2D coords, ChessBoard board, Game game, PApplet sketch){
    super(team, coords, board, 3, "Knight", "Images/White Knight.png", "Images/Black Knight.png", game, sketch);
    this.board = board;
  }
  
  
  
  @Override
  public boolean movement(Vector2D newCoords){
    
    //Makes sure that the desired position has no piece or it's an enemy piece.
    if(!(board.getChessPiece(newCoords) == null || super.getTeam() != board.getChessPiece(newCoords).getTeam())){
      return false;
    }
    
      //Checks if the movement done is in an L shape.
      if((Math.abs(super.getPosition().getX() - newCoords.getX()) == 2 && Math.abs(super.getPosition().getY() - newCoords.getY()) == 1) || (Math.abs(super.getPosition().getX() - newCoords.getX()) == 1 && Math.abs(super.getPosition().getY() - newCoords.getY()) == 2)){
        super.revertVariables(); //Just set reverts justCastled and pawnDoubleMove boolean back after a successful move that is not a castle.
        return true;
      }

    System.out.println("ERROR");
    return false;
  }
  
  
}
