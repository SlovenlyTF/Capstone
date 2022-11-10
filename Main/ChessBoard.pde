public class ChessBoard{
  
  private boolean pawnDoubleMoveWhite = false; //Is a check for if the previous move was a white pawn that moved two spaces.
  private boolean pawnDoubleMoveBlack = false; //Is a check for if the previous move was a white pawn that moved two spaces.
  private boolean justCastled = false; //Is a check for if the previous move was a castle.
  
  /**
  *  Stores an int if there is a chess piece is in the square matching the matrix.
  *  The int represent which team it belongs to, so team 0 is white, team 1 is black.
  */
  private ChessPieceClass chessBoard[][] = new ChessPieceClass[boardSize][boardSize];
  
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
      for(int i = 0; i < boardSize; i++){
        
        //Checks for white. Makes sure that it's a pawn in the spot it checks.
        if(board.getChessPiece(i, boardSize - 4) != null && board.getChessPiece(i, boardSize - 4).getType() == "Pawn"){
          board.getChessPiece(i, boardSize - 4).setJustDoublePawn(false);
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
      for(int i = 0; i < boardSize; i++){
        
        //Checks for black. Makes sure that it's a pawn in the spot it checks.
        if(board.getChessPiece(i, 3) != null && board.getChessPiece(i, 3).getType() == "Pawn"){
          board.getChessPiece(i, 3).setJustDoublePawn(false);
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
  public void setUp(String mode, ScoreBoard score){
    switch(mode){
      
      case "standard":
        standardSetUp(score);
        break;
      
      default:
        break;
    }
  }
  
  //Sets up a standard game of chess.
  private void standardSetUp(ScoreBoard score){
    
    //Creates Black special pieces
    chessBoard[0][0] = new Rook(1, 0, 0, this);
    chessBoard[boardSize - 1][0] = new Rook(1, boardSize - 1, 0, this);
    chessBoard[(boardSize / 2) - 3][0] = new Knight(1, (boardSize / 2) - 3, 0, this);
    chessBoard[(boardSize / 2) + 2][0] = new Knight(1, (boardSize / 2) + 2, 0, this);
    chessBoard[(boardSize / 2) - 2][0] = new Bishop(1, (boardSize / 2) - 2, 0, this);
    chessBoard[(boardSize / 2) + 1][0] = new Bishop(1, (boardSize / 2) + 1, 0, this);
    chessBoard[boardSize / 2][0] = new King(1, boardSize / 2, 0, this);
    chessBoard[(boardSize / 2) - 1][0] = new Queen(1, (boardSize / 2) - 1, 0, this);
    
    
    //Creates White special pieces
    chessBoard[0][boardSize - 1] = new Rook(0, 0, boardSize - 1, this);
    chessBoard[boardSize - 1][boardSize - 1] = new Rook(0, boardSize - 1, boardSize - 1, this);
    chessBoard[(boardSize / 2) - 3][boardSize - 1] = new Knight(0, (boardSize / 2) - 3, boardSize - 1, this);
    chessBoard[(boardSize / 2) + 2][boardSize - 1] = new Knight(0, (boardSize / 2) + 2, boardSize - 1, this);
    chessBoard[(boardSize / 2) - 2][boardSize - 1] = new Bishop(0, (boardSize / 2) - 2, boardSize - 1, this);
    chessBoard[(boardSize / 2) + 1][boardSize - 1] = new Bishop(0, (boardSize / 2) + 1, boardSize - 1, this);
    chessBoard[boardSize / 2][boardSize - 1] = new King(0, boardSize / 2, boardSize - 1, this);
    chessBoard[(boardSize / 2) - 1][boardSize - 1] = new Queen(0, (boardSize / 2) - 1, boardSize - 1, this);
    
    //Creates the black pawns.
    for(int i = 0; i < boardSize; i++){
      chessBoard[i][1] = new Pawn(1, i, 1, this, score);
    }
    
    //Creates the white pawns.
    for(int i = 0; i < boardSize; i++){
      chessBoard[i][boardSize - 2] = new Pawn(0, i, boardSize - 2, this, score);
    }
  }
  
  public ChessPieceClass[][] getMatrix(){
    return chessBoard;
  }
  
  public int getValue(int x, int y){
    if(chessBoard[x][y] != null){
      return chessBoard[x][y].getValue();
    }
    return -1;
  }
  
  public void setMatrix(ChessPieceClass[][] other){
    for(int i = 0; i < boardSize; i++){
      for(int j = 0; j < boardSize; j++){
        chessBoard[i][j] = other[i][j];
      }
    }
  }
  
  public void undoCastle(int team){
    if(justCastled){
      
      if(team == 0){
        if(chessBoard[2][boardSize - 1] != null && chessBoard[2][boardSize - 1].getType() == "King"){
          chessBoard[3][boardSize - 1].setPosition(0, 7);
          setMatrix(previousMoveBoard.getMatrix());
          chessBoard[0][boardSize - 1] = chessBoard[3][boardSize - 1];
          chessBoard[3][boardSize - 1] = null;
        } else {
          chessBoard[5][boardSize - 1].setPosition(7, 7);
          setMatrix(previousMoveBoard.getMatrix());
          chessBoard[boardSize - 1][boardSize - 1] = chessBoard[5][boardSize - 1];
          chessBoard[5][boardSize - 1] = null;
        }
      } else {
        if(chessBoard[2][0] != null && chessBoard[2][0].getType() == "King"){
          chessBoard[3][0].setPosition(0, 0);
          setMatrix(previousMoveBoard.getMatrix());
          chessBoard[0][0] = chessBoard[3][0];
          chessBoard[3][0] = null;
        } else {
          chessBoard[5][0].setPosition(7, 0);
          setMatrix(previousMoveBoard.getMatrix());
          chessBoard[boardSize - 1][0] = chessBoard[5][0];
          chessBoard[5][0] = null;
        }
      }
      
      justCastled = false;
    }
  }
  
  public void spawnNewPiece(int x, int y, int team, String type){
    switch(type){
      case "pawn":
        chessBoard[x][y] = new Pawn(team, x, y, this, score);
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
