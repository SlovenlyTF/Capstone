public class ChessBoard{
  
  /**
  *  Stores an int if there is a chess piece is in the square matching the matrix.
  *  The int represent which team it belongs to, so team 0 is white, team 1 is black.
  */
  private ChessPieceClass chessBoard[][] = new ChessPieceClass[8][8];
  
  
  ChessPieceClass getChessPiece(int x, int y){
    return chessBoard[x][y];
  }
  
  void setChessPiece(int prevX, int prevY, int x, int y){
    chessBoard[x][y] = chessBoard[prevX][prevY];
  }
  
  void removeChessPiece(int x, int y){
    chessBoard[x][y] = null;
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
  void standardSetUp(){
    
    //Creates Black special pieces
    chessBoard[0][0] = new Rook(1, 0, 0, board);
    chessBoard[7][0] = new Rook(1, 7, 0, board);
    chessBoard[1][0] = new Knight(1, 1, 0, board);
    chessBoard[6][0] = new Knight(1, 6, 0, board);
    chessBoard[2][0] = new Bishop(1, 2, 0, board);
    chessBoard[5][0] = new Bishop(1, 5, 0, board);
    chessBoard[3][0] = new King(1, 3, 0, board);
    chessBoard[4][0] = new Queen(1, 4, 0, board);
    
    
    //Creates White special pieces
    chessBoard[0][7] = new Rook(0, 0, 7, board);
    chessBoard[7][7] = new Rook(0, 7, 7, board);
    chessBoard[1][7] = new Knight(0, 1, 7, board);
    chessBoard[6][7] = new Knight(0, 6, 7, board);
    chessBoard[2][7] = new Bishop(0, 2, 7, board);
    chessBoard[5][7] = new Bishop(0, 5, 7, board);
    chessBoard[3][7] = new King(0, 3, 7, board);
    chessBoard[4][7] = new Queen(0, 4, 7, board);
    
    //Creates the black pawns.
    for(int i = 0; i <= 7; i++){
      chessBoard[i][1] = new Pawn(1, i, 1, board);
    }
    
    //Creates the white pawns.
    for(int i = 0; i <= 7; i++){
      chessBoard[i][6] = new Pawn(0, i, 6, board);
    }
  }
  
  ChessPieceClass[][] getMatrix(){
    return chessBoard;
  }
  
  int getValue(int x, int y){
    if(chessBoard[x][y] != null){
      return chessBoard[x][y].getValue();
    }
    return -1;
  }
  
  void setMatrix(ChessPieceClass[][] other){
    for(int i = 0; i < 8; i++){
      for(int j = 0; j < 8; j++){
        chessBoard[i][j] = other[i][j];
      }
    }
  }
  
}
