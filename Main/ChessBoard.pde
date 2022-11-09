public class ChessBoard{
  
  boolean justCastled = false;
  
  /**
  *  Stores an int if there is a chess piece is in the square matching the matrix.
  *  The int represent which team it belongs to, so team 0 is white, team 1 is black.
  */
  private ChessPieceClass chessBoard[][] = new ChessPieceClass[8][8];
  
  
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
  
  //Runs the setup function that matches the selected mode.
  public void setUp(String mode){
    switch(mode){
      
      case "standard":
        standardSetUp();
        break;
      
      default:
        break;
    }
  }
  
  //Sets up a standard game of chess.
  private void standardSetUp(){
    
    //Creates Black special pieces
    chessBoard[0][0] = new Rook(1, 0, 0, this);
    chessBoard[7][0] = new Rook(1, 7, 0, this);
    chessBoard[1][0] = new Knight(1, 1, 0, this);
    chessBoard[6][0] = new Knight(1, 6, 0, this);
    chessBoard[2][0] = new Bishop(1, 2, 0, this);
    chessBoard[5][0] = new Bishop(1, 5, 0, this);
    chessBoard[4][0] = new King(1, 4, 0, this);
    chessBoard[3][0] = new Queen(1, 3, 0, this);
    
    
    //Creates White special pieces
    chessBoard[0][7] = new Rook(0, 0, 7, this);
    chessBoard[7][7] = new Rook(0, 7, 7, this);
    //chessBoard[1][7] = new Knight(0, 1, 7, this);
    //chessBoard[6][7] = new Knight(0, 6, 7, this);
    //chessBoard[2][7] = new Bishop(0, 2, 7, this);
    //chessBoard[5][7] = new Bishop(0, 5, 7, this);
    chessBoard[4][7] = new King(0, 4, 7, this);
    //chessBoard[3][7] = new Queen(0, 3, 7, this);
    
    //Creates the black pawns.
    for(int i = 0; i <= 7; i++){
      chessBoard[i][1] = new Pawn(1, i, 1, this);
    }
    
    //Creates the white pawns.
    for(int i = 0; i <= 7; i++){
      chessBoard[i][6] = new Pawn(0, i, 6, this);
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
    for(int i = 0; i < 8; i++){
      for(int j = 0; j < 8; j++){
        chessBoard[i][j] = other[i][j];
      }
    }
  }
  
  public void undoCastle(int team){
    if(justCastled){
      
      if(team == 0){
        if(chessBoard[2][7] != null && chessBoard[2][7].getType() == "King"){
          chessBoard[3][7].setPosition(0, 7);
          setMatrix(previousMoveBoard.getMatrix());
          chessBoard[0][7] = chessBoard[3][7];
          chessBoard[3][7] = null;
        } else {
          chessBoard[5][7].setPosition(7, 7);
          setMatrix(previousMoveBoard.getMatrix());
          chessBoard[7][7] = chessBoard[5][7];
          chessBoard[5][7] = null;
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
          chessBoard[7][0] = chessBoard[5][0];
          chessBoard[5][0] = null;
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
