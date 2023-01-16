//Tobias Friese
//tfries21@student.aau.dk
//06-01-2023
//OOP Software AAU Semester 3

package Main;

import processing.core.PApplet;
import ChessPieces.*;

public class GameModes { //This class is kinda unnesesary. It was just to split the code up more easily.

  private ChessBoard board;
  private Game game;
  private PApplet sketch;

  public GameModes(ChessBoard board, Game game, PApplet sketch){
    this.board = board;
    this.game = game;
    this.sketch = sketch;
  }
  
  
  
  public void chooseGameMode(int mode){
    switch(mode){
      
      case 0:
        standardSetUp();
        break;
      
      case 1:
        knightSetUp();
        break;
      
      case 2:
        pointBuySystem();
        break;
        
      default:
        break;
    }
  }
  
  

  /**
   * Sets up a standard game of chess.
   */
  private void standardSetUp(){
    
    //Creates Black special pieces
    board.chessBoard[0][0] = new Rook(1, new Vector2D(0, 0), board, game, sketch);
    board.chessBoard[game.getBoardSize() - 1][0] = new Rook(1, new Vector2D(game.getBoardSize() - 1, 0), board, game, sketch);
    board.chessBoard[(game.getBoardSize() / 2) - 3][0] = new Knight(1, new Vector2D((game.getBoardSize() / 2) - 3, 0), board, game, sketch);
    board.chessBoard[(game.getBoardSize() / 2) + 2][0] = new Knight(1, new Vector2D((game.getBoardSize() / 2) + 2, 0), board, game, sketch);
    board.chessBoard[(game.getBoardSize() / 2) - 2][0] = new Bishop(1, new Vector2D((game.getBoardSize() / 2) - 2, 0), board, game, sketch);
    board.chessBoard[(game.getBoardSize() / 2) + 1][0] = new Bishop(1, new Vector2D((game.getBoardSize() / 2) + 1, 0), board, game, sketch);
    board.chessBoard[game.getBoardSize() / 2][0] = new King(1, new Vector2D(game.getBoardSize() / 2, 0), board, game, sketch);
    board.chessBoard[(game.getBoardSize() / 2) - 1][0] = new Queen(1, new Vector2D((game.getBoardSize() / 2) - 1, 0), board, game, sketch);
    
    
    //Creates White special pieces
    board.chessBoard[0][game.getBoardSize() - 1] = new Rook(0, new Vector2D(0, game.getBoardSize() - 1), board, game, sketch);
    board.chessBoard[game.getBoardSize() - 1][game.getBoardSize() - 1] = new Rook(0, new Vector2D(game.getBoardSize() - 1, game.getBoardSize() - 1), board, game, sketch);
    board.chessBoard[(game.getBoardSize() / 2) - 3][game.getBoardSize() - 1] = new Knight(0, new Vector2D((game.getBoardSize() / 2) - 3, game.getBoardSize() - 1), board, game, sketch);
    board.chessBoard[(game.getBoardSize() / 2) + 2][game.getBoardSize() - 1] = new Knight(0, new Vector2D((game.getBoardSize() / 2) + 2, game.getBoardSize() - 1), board, game, sketch);
    board.chessBoard[(game.getBoardSize() / 2) - 2][game.getBoardSize() - 1] = new Bishop(0, new Vector2D((game.getBoardSize() / 2) - 2, game.getBoardSize() - 1), board, game, sketch);
    board.chessBoard[(game.getBoardSize() / 2) + 1][game.getBoardSize() - 1] = new Bishop(0, new Vector2D((game.getBoardSize() / 2) + 1, game.getBoardSize() - 1), board, game, sketch);
    board.chessBoard[game.getBoardSize() / 2][game.getBoardSize() - 1] = new King(0, new Vector2D(game.getBoardSize() / 2, game.getBoardSize() - 1), board, game, sketch);
    board.chessBoard[(game.getBoardSize() / 2) - 1][game.getBoardSize() - 1] = new Queen(0, new Vector2D((game.getBoardSize() / 2) - 1, game.getBoardSize() - 1), board, game, sketch);
    
    createPawns(); //Creates the pawns.
  }
  
  

  /**
   * Sets up a game of chess with a bunch of knights.
   */
  private void knightSetUp(){
    
    //Creates Black special pieces
    board.chessBoard[game.getBoardSize() / 2][0] = new King(1, new Vector2D(game.getBoardSize() / 2, 0), board, game, sketch);
    board.chessBoard[(game.getBoardSize() / 2) - 1][0] = new Queen(1, new Vector2D((game.getBoardSize() / 2) - 1, 0), board, game, sketch);
    
    for(int i = 0; i < game.getBoardSize(); i++){
      if(!(i == game.getBoardSize() / 2 || i == game.getBoardSize() / 2 - 1)){
        board.chessBoard[i][0] = new Knight(1, new Vector2D(i, 0), board, game, sketch);
      }
    }
    
    
    //Creates White special pieces
    board.chessBoard[game.getBoardSize() / 2][game.getBoardSize() - 1] = new King(0, new Vector2D(game.getBoardSize() / 2, game.getBoardSize() - 1), board, game, sketch);
    board.chessBoard[(game.getBoardSize() / 2) - 1][game.getBoardSize() - 1] = new Queen(0, new Vector2D((game.getBoardSize() / 2) - 1, game.getBoardSize() - 1), board, game, sketch);
    
    for(int i = 0; i < game.getBoardSize(); i++){
      if(!(i == game.getBoardSize() / 2 || i == game.getBoardSize() / 2 - 1)){
        board.chessBoard[i][game.getBoardSize() - 1] = new Knight(0, new Vector2D(i, game.getBoardSize() - 1), board, game, sketch);
      }
    }
    
    createPawns(); //Creates the pawns.
  }


  /**
   * Sets the point buy system to activate.
   */
  public void pointBuySystem() {
    board.setPieceSelection(true);
  }


  /**
   * Create all the pawns on the board.
   */
  private void createPawns(){
    //Creates the black pawns.
    for(int i = 0; i < game.getBoardSize(); i++){
      board.chessBoard[i][1] = new Pawn(1, new Vector2D(i, 1), board, game, sketch);
    }
    
    //Creates the white pawns.
    for(int i = 0; i < game.getBoardSize(); i++){
      board.chessBoard[i][game.getBoardSize() - 2] = new Pawn(0, new Vector2D(i, game.getBoardSize() - 2), board, game, sketch);
    }
  }
  
}
