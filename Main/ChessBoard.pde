public class ChessBoard{
  
  private boolean pawnDoubleMoveWhite = false; //Is a check for if the previous move was a white pawn that moved two spaces.
  private boolean pawnDoubleMoveBlack = false; //Is a check for if the previous move was a white pawn that moved two spaces.
  private boolean justCastled = false; //Is a check for if the previous move was a castle.
  
  private GameModes gameModes = new GameModes(this);
  /**
  *  Stores an int if there is a chess piece is in the square matching the matrix.
  *  The int represent which team it belongs to, so team 0 is white, team 1 is black.
  */
  private ChessPieceClass chessBoard[][] = new ChessPieceClass[game.getBoardSize()][game.getBoardSize()];
  
  public ChessPieceClass getChessPiece(int x, int y){
    return chessBoard[x][y];
  }
  
  public void setChessPiece(int prevX, int prevY, int x, int y){
    chessBoard[x][y] = chessBoard[prevX][prevY];
  }
  
  public void removeChessPiece(int x, int y){
    chessBoard[x][y] = null;
  }
  
  public void setJustCastled(boolean i){
    justCastled = i;
  }
  
  public boolean getJustCastled(){
    return justCastled;
  }
  
  /**Sets the pawn boolean, but also sets all pawns in the row for the double move to equal false.
  *  There are two, one for white and one for black, because there was an error when trying to undo, and not being able to passant after.
  */
  public void setPawnDoubleMoveWhite(boolean setBool){
    
    //If a pawn double moved last move.
    if(pawnDoubleMoveWhite){
      for(int i = 0; i < game.getBoardSize(); i++){
        
        //Checks for white. Makes sure that it's a pawn in the spot it checks.
        if(game.board.getChessPiece(i, game.getBoardSize() - 4) != null && game.board.getChessPiece(i, game.getBoardSize() - 4).getType() == "Pawn"){
          game.board.getChessPiece(i, game.getBoardSize() - 4).setJustDoublePawn(false);
        }
      }
    }
    
    pawnDoubleMoveWhite = setBool;
  }
  
  /**Sets the pawn boolean, but also sets all pawns in the row for the double move to equal false.
  *  There are two, one for white and one for black, because there was an error when trying to undo, and not being able to passant after.
  */
  public void setPawnDoubleMoveBlack(boolean setBool){
    
    //If a pawn double moved last move.
    if(pawnDoubleMoveBlack){
      for(int i = 0; i < game.getBoardSize(); i++){
        
        //Checks for black. Makes sure that it's a pawn in the spot it checks.
        if(game.board.getChessPiece(i, 3) != null && game.board.getChessPiece(i, 3).getType() == "Pawn"){
          game.board.getChessPiece(i, 3).setJustDoublePawn(false);
        }
      }
    }
    
    pawnDoubleMoveBlack = setBool;
  }
  
  public boolean getPawnDoubleMoveWhite(){
    return pawnDoubleMoveWhite;
  }
  
  public boolean getPawnDoubleMoveBlack(){
    return pawnDoubleMoveBlack;
  }
  
  //Runs the setup function that matches the selected mode.
  public void setUp(int mode){
    gameModes.chooseGameMode(mode);
  }
  
  
  
  public ChessPieceClass[][] getMatrix(){
    return chessBoard;
  }
  
  public int getValue(int x, int y){
    if(chessBoard[x][y] != null){ //Makes sure that there is a piece to get the value from.
      return chessBoard[x][y].getValue();
    }
    return -1;
  }
  
  //Runs through the matrix and copies each field.
  public void setMatrix(ChessPieceClass[][] other){
    for(int i = 0; i < game.getBoardSize(); i++){
      for(int j = 0; j < game.getBoardSize(); j++){
        chessBoard[i][j] = other[i][j];
      }
    }
  }
  
  public void undoCastle(int team){
    if(justCastled){
      
      if(team == 0){ //Checks if team is white.
        if(chessBoard[(game.getBoardSize() / 2) - 2][game.getBoardSize() - 1] != null && chessBoard[(game.getBoardSize() / 2) - 2][game.getBoardSize() - 1].getType() == "King"){ //Checks if the king is moved to the left in the castle.
          chessBoard[(game.getBoardSize() / 2) - 1][game.getBoardSize() - 1].setPosition(0, game.getBoardSize() - 1); //Sets the rook object position back.
          setMatrix(game.previousMoveBoard.getMatrix()); //Reverts the board matrix back for the king.
          chessBoard[0][game.getBoardSize() - 1] = chessBoard[(game.getBoardSize() / 2) - 1][game.getBoardSize() - 1]; //Puts the rook back in the chessboard matrix because the previousMoveBoard didn't save it, since it's only made for one piece to move at a time.
          chessBoard[(game.getBoardSize() / 2) - 1][game.getBoardSize() - 1] = null; //Deletes the rook from it's castle position.
        } else { //If the king is moved to the Right in the castle.
          chessBoard[(game.getBoardSize() / 2) + 1][game.getBoardSize() - 1].setPosition(game.getBoardSize() - 1, game.getBoardSize() - 1); //Sets the rook object position back.
          setMatrix(game.previousMoveBoard.getMatrix()); //Reverts the board matrix back for the king.
          chessBoard[game.getBoardSize() - 1][game.getBoardSize() - 1] = chessBoard[(game.getBoardSize() / 2) + 1][game.getBoardSize() - 1]; //Puts the rook back in the chessboard matrix because the previousMoveBoard didn't save it, since it's only made for one piece to move at a time.
          chessBoard[(game.getBoardSize() / 2) + 1][game.getBoardSize() - 1] = null; //Deletes the rook from it's castle position.
        }
      } else { //Checks if team is black.
        if(chessBoard[(game.getBoardSize() / 2) - 2][0] != null && chessBoard[(game.getBoardSize() / 2) - 2][0].getType() == "King"){ //Checks if the king is moved to the left in the castle.
          chessBoard[(game.getBoardSize() / 2) - 1][0].setPosition(0, 0); //Sets the rook object position back.
          setMatrix(game.previousMoveBoard.getMatrix()); //Reverts the board matrix back for the king.
          chessBoard[0][0] = chessBoard[(game.getBoardSize() / 2) - 1][0]; //Puts the rook back in the chessboard matrix because the previousMoveBoard didn't save it, since it's only made for one piece to move at a time.
          chessBoard[(game.getBoardSize() / 2) - 1][0] = null; //Deletes the rook from it's castle position.
        } else { //If the king is moved to the Right in the castle.
          chessBoard[(game.getBoardSize() / 2) + 1][0].setPosition(game.getBoardSize() - 1, 0); //Sets the rook object position back.
          setMatrix(game.previousMoveBoard.getMatrix()); //Reverts the board matrix back for the king.
          chessBoard[game.getBoardSize() - 1][0] = chessBoard[(game.getBoardSize() / 2) + 1][0]; //Puts the rook back in the chessboard matrix because the previousMoveBoard didn't save it, since it's only made for one piece to move at a time.
          chessBoard[(game.getBoardSize() / 2) + 1][0] = null; //Deletes the rook from it's castle position.
        }
      }
      
      justCastled = false;
    }
  }
  
  public void spawnNewPiece(int x, int y, int team, String type){
    switch(type){
      case "pawn":
        chessBoard[x][y] = new Pawn(team, x, y, this);
        break;
      
      case "bishop":
        chessBoard[x][y] = new Bishop(team, x, y, this);
        break;
        
      case "knight":
        chessBoard[x][y] = new Knight(team, x, y, this);
        break;
        
      case "rook":
        chessBoard[x][y] = new Rook(team, x, y, this);
        break;
        
      case "queen":
        chessBoard[x][y] = new Queen(team, x, y, this);
        break;
        
      case "king":
        chessBoard[x][y] = new King(team, x, y, this);
        break;
    }
  }
  
}
