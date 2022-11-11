public class Game {
  
  public ChessBoard board;
  public ChessBoard previousMoveBoard;
  public ScoreBoard score;
  
  private boolean pickedUpPiece = false;
  private boolean undo = false;
  private boolean won[] = {false, false};
  
  private int prevMovePos[] = new int[2];
  
  private int turn = 0;
  
  //Mousepress variables
  private int prevMouse[] = new int[2];
  private int newMouse[] = new int[2];
  
  private int gameMode = 0;
  private int boardSize = 8;
  private int cellSize;
  
  public int getTurn(){
    return turn;
  }
  
  public void setBoardSize(int i){
    boardSize = i;
  }
  
  public int getGameMode(){
    return gameMode;
  }
  
  public void setGameMode(int i){
    gameMode = i;
  }
  
  public int getBoardSize(){
    return boardSize;
  }
  
  public int getCellSize(){
    return cellSize;
  }
  
  public boolean getPickedUpPiece(){
    return pickedUpPiece;
  }
  
  public void setPickedUpPiece(boolean i){
    pickedUpPiece = i;
  }
  
  public int[] getNewMouse(){
    return newMouse;
  }
  
  
  public void gameSetup(){
    if(boardSize < 8 || boardSize % 2 == 1){
      boardSize = 8;
      cellSize = 800 / boardSize;
      println("Error in board size, switched to default.");
    }
  }
  
  public void startGame(){
    
    cellSize = 800 / boardSize;
    
    board = new ChessBoard();
    score = new ScoreBoard();
    previousMoveBoard = new ChessBoard();
    
    board.setUp(gameMode);
    startScreen = false;
    
  }
  
  /**Runs each frame.
  *  Runs primarily all the visual code.
  *  Sets the background and checkers squares.
  *  Draws the individual chesspieces.
  *  Draws the score.
  */
  public void drawGame(){
    chessBoardSquares();
    
    drawChessPieces();
    
    //Updates the score display.
    if(!board.getPieceSelection() && !board.getPieceSelectionPawn()){
      score.displayPieces();
      score.displayScore();
      
      //Creates the visual triangle, which is the undo button, on the side.
      fill(0, 0, 0, 150);
      triangle(825,400,875,380,875,420);
      
      fill(0, 0, 0);
      text(turn, 850, 375); //Display the turn counter.
    }
    
    
    //Display win text.
    if(won[0]){
      fill(0, 0, 0);
      textSize(150);
      text("Black Won", 400, 450);
    } else if (won[1]){
      fill(0, 0, 0);
      textSize(150);
      text("White Won", 400, 450);
    }
    
    if(board.getPieceSelection() || board.getPieceSelectionPawn()){
      board.drawSelectionBar();
    }
    
  }
  
  
  void gameMousePressed(){
    
    
    //Checks if the curser is where the undo button is, when it is pressed.
    if(mouseX > 800 && mouseX < 900 && mouseY > 375 && mouseY < 425 && !board.getPieceSelection() && !board.getPieceSelectionPawn()){
      undo();
    } else if(mouseX < cellSize * boardSize && mouseY < cellSize * boardSize && !board.getPieceSelection() && !board.getPieceSelectionPawn()){
      
      prevMouse[0] = newMouse[0];
      prevMouse[1] = newMouse[1];
      newMouse[0] = (int) Math.floor(mouseX / cellSize);
      newMouse[1] = (int) Math.floor(mouseY / cellSize);
    
    
      //makes sure that the curser is inside the chessboard.
      if((int) Math.floor(mouseX / cellSize) < boardSize){
        
        //Checks if the user will pick up a piece.
        if(!pickedUpPiece){
          
          //Checks if the mouse is where a legal piece is.
          if(board.getChessPiece(newMouse[0], newMouse[1]) != null && board.getChessPiece(newMouse[0], newMouse[1]).getTeam() == turn % 2){
            board.getChessPiece(newMouse[0], newMouse[1]).setIsPickedUp(true); //Tells the piece that it is picked up.
            pickedUpPiece = true;
          }
          
        } else { //When a user already has a piece picked up.
        
          //if the chosen chesspiece can move in that way.
          if(board.getChessPiece(prevMouse[0], prevMouse[1]).movement(newMouse[0], newMouse[1])){
            
            //There is an error with Passant removing a piece before the board can be saved, so in those cases, do we save the board in the passant function.
            if(!board.getChessPiece(prevMouse[0], prevMouse[1]).getPerformedPassant()){
              previousMoveBoard.setMatrix(board.getMatrix()); //saves the previous move.
            }
            
            prevMovePos[0] = board.getChessPiece(prevMouse[0], prevMouse[1]).getPosition(0);
            prevMovePos[1] = board.getChessPiece(prevMouse[0], prevMouse[1]).getPosition(1);
            
            
            //If the piece kills another.
            if(board.getChessPiece(newMouse[0], newMouse[1]) != null){
              if(board.getChessPiece(newMouse[0], newMouse[1]).getType() == "King"){
                won[board.getChessPiece(newMouse[0], newMouse[1]).getTeam()] = true;
              }
              score.addTeamScore(board.getChessPiece(newMouse[0], newMouse[1]).getValue(), turn % 2);
              score.addChessPieceType(board.getChessPiece(newMouse[0], newMouse[1]).getType(), turn % 2);
              score.setJustKilledPiece(true);
              
            } else if(board.getChessPiece(prevMouse[0], prevMouse[1]).getPerformedPassant()){
              println("test");
              score.setJustKilledPiece(true);
              
            } else {
              score.setJustKilledPiece(false);
            }
            
            board.getChessPiece(prevMouse[0], prevMouse[1]).setIsPickedUp(false); //Lets the picked up piece know that it is not picked up anymore.
            board.setChessPiece(prevMouse[0], prevMouse[1], newMouse[0], newMouse[1]); //Puts the picked up piece into the cell that matches its new spot.
            board.getChessPiece(prevMouse[0], prevMouse[1]).setPosition(newMouse[0], newMouse[1]); //Sets the piece position inside the piece object.
            board.removeChessPiece(prevMouse[0], prevMouse[1]); //Remove the pointer to the piece in the previous spot.
            
            
            turn++; //increases the turn number
            undo = true;
              
          } else {
            board.getChessPiece(prevMouse[0], prevMouse[1]).setIsPickedUp(false); //Lets the picked up piece know that it is not picked up anymore.
          }
          
          pickedUpPiece = false;
        }
        
        println("");
        println("x: " + newMouse[0] + " " + prevMouse[0]);
        println("y: " + newMouse[1] + " " + prevMouse[1]);
        println(pickedUpPiece);
        println(turn);
      }
      
      
    } else if(board.getPieceSelection()){
      
      newMouse[0] = (int) Math.floor(mouseX / cellSize);
      newMouse[1] = (int) Math.floor(mouseY / cellSize);
      
      board.mousePressedSelectionBar();
      
    } else if(board.getPieceSelectionPawn()){
      
      board.mousePressedSelectionBarPawn();
      
    }
    
  }
  
  //Undo the last move.
  void undo(){
    if(undo){ //Just a fail safe, so it can't undo multiple times in a row.
      
      turn--;
      if(board.getJustCastled()){
        board.undoCastle(turn % 2);
      } else {
        board.setMatrix(previousMoveBoard.getMatrix()); //Rewinds the board matrix to a matrix saved the previous turn.
      }
      if(!board.getChessPiece(prevMovePos[0], prevMovePos[1]).getPrevHasMoved()){
        board.getChessPiece(prevMovePos[0], prevMovePos[1]).setHasMoved(false);
      }
      
      board.getChessPiece(prevMovePos[0], prevMovePos[1]).setPosition(prevMovePos[0], prevMovePos[1]);
      
      
      score.undo(turn % 2);
      
      undo = false;
    }
  }
  
  void gameKeyPressed() {
    if(key == 'z' && !board.getPieceSelection() && !board.getPieceSelectionPawn()){
      undo();
    }
  }
  
  
  void drawChessPieces(){
    for(int i = 0; i < boardSize; i++){
      for(int j = 0; j < boardSize; j++){
        if(board.getChessPiece(i, j) != null){
          board.getChessPiece(i, j).displayImage();
        }
      }
    }
  }
  
  
  void chessBoardSquares(){
    boolean white = false;
    
    for(int i = 0; i < boardSize; i++){
      if(white){
          white = false;
        } else {
          white = true;
        }
      for(int j = 0; j < boardSize; j++){
        
        if(white){
          fill(255, 255, 255, 60);
          white = false;
        } else {
          fill(0, 0, 0, 60);
          white = true;
        }      
        
        rect(j*cellSize, i*cellSize, cellSize, cellSize);
      }
    }
  }
}
