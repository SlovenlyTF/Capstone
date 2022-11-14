public class Game {
  
  public ChessBoard board;
  public ChessBoard previousMoveBoard;
  public ScoreBoard score;
  public SaveAndLoad saveAndLoad;
  
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
  
  public Game(SaveAndLoad tempSaveAndLoadData){
    saveAndLoad = tempSaveAndLoadData;
  }
  
  public int getTurn(){
    return turn;
  }
  
  public void setTurn(int i){
    turn = i;
  }
  
  public boolean getWon(int i){
    return won[i];
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
  
  public void startGame(boolean newGame){
    
    cellSize = 800 / boardSize;
    
    won[0] = false;
    won[1] = false;
    undo = false;
    
    board = new ChessBoard();
    score = new ScoreBoard();
    previousMoveBoard = new ChessBoard();
    
    if(newGame){
      board.setUp(gameMode);
    }
    
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
            saveAndLoad.saveData(this);
              
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
      
      //Reduce the turn variable, so it maches and doesn't mess up the turn order. 
      turn--;
      
      //Checks to see if the board has just castled, since it moves to spaces, and hos to do something extra to undo that.
      if(board.getJustCastled()){
        board.undoCastle(turn % 2);
      } else {
        board.setMatrix(previousMoveBoard.getMatrix()); //Rewinds the board matrix to a matrix saved the previous turn.
      }
      
      //There is a couple moves you can only do if a piece hasn't moved before. Here we revert it, so it still "hasn't moved" if it hadn't before the this turn.
      if(!board.getChessPiece(prevMovePos[0], prevMovePos[1]).getPrevHasMoved()){
        board.getChessPiece(prevMovePos[0], prevMovePos[1]).setHasMoved(false);
      }
      
      //Resets the moved piece internal position.
      board.getChessPiece(prevMovePos[0], prevMovePos[1]).setPosition(prevMovePos[0], prevMovePos[1]);
      
      //Runs an undo function in the score class, which undo the anything that happend to the score this turn.
      score.undo(turn % 2);
      
      //Sets the boolean to false, since you can't undo more than one move.
      undo = false;
      
      //Saves the data, so the save data file is the turn before the current turn that has just been undone.
      saveAndLoad.saveData(this);
    }
  }
  
  //If the key z is pressed, it also undo the last turn.
  void gameKeyPressed() {
    if(key == 'z' && !board.getPieceSelection() && !board.getPieceSelectionPawn()){
      undo();
    }
  }
  
  
  //Display the image of all the pieces.
  void drawChessPieces(){
    for(int i = 0; i < boardSize; i++){
      for(int j = 0; j < boardSize; j++){
        if(board.getChessPiece(i, j) != null){
          board.getChessPiece(i, j).displayImage();
        }
      }
    }
  }
  
  
  //Display the checkers pattern that a chessboard has.
  void chessBoardSquares(){
    boolean white = false;
    
    //Loops through the y-axis.
    for(int i = 0; i < boardSize; i++){
      
      if(white){ //Since every other row is offset, do we have to put in this "switch" to offset it.
          white = false;
        } else {
          white = true;
        }
        
      //Loops through the x-axis.
      for(int j = 0; j < boardSize; j++){
        
        if(white){ //Sets the color for the black and white squars.
          fill(255, 255, 255, 60); //Sets the color to white with quite a high transparancy. 
          white = false;
        } else {
          fill(0, 0, 0, 60); //Sets the color to black with quite a high transparancy. 
          white = true;
        }      
        
        //This is the actual squars that is created.
        rect(j*cellSize, i*cellSize, cellSize, cellSize);
      }
    }
  }
}
