package src;

import processing.core.PApplet;

import java.util.ArrayList;


public class Game extends PApplet {

  private PApplet sketch;
  private ChessBoard board;
  private ChessBoard previousMoveBoard;
  private ScoreBoard score;
  private SaveAndLoad saveAndLoad;
  private Main_MySketch mainMySketch;
  private boolean pickedUpPiece = false;
  private boolean undo = false;
  private ArrayList<Boolean> won = new ArrayList<Boolean>();
  private int turn = 0;
  private Vector2D prevMovedPos = new Vector2D(0, 0);
  
  //Mousepress variables
  private Vector2D prevMouse = new Vector2D(0, 0);
  private Vector2D newMouse = new Vector2D(0, 0);
  
  private int gameMode = 0;
  private int boardSize = 8;
  private int cellSize;
  
  public Game(SaveAndLoad tempSaveAndLoadData, Main_MySketch mainMySketch, PApplet sketch){
    saveAndLoad = tempSaveAndLoadData;
    this.mainMySketch = mainMySketch;
    this.sketch = sketch;
  }
  
  public int getTurn(){
    return turn;
  }
  
  public void setTurn(int i){
    turn = i;
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

  public Vector2D getNewMouse(){
    return newMouse;
  }

  public ScoreBoard getScore(){
    return score;
  }

  public ChessBoard getBoard() {
    return board;
  }

  public ChessBoard getPreviousMoveBoard() {
    return previousMoveBoard;
  }

  public void setBoard(ChessBoard board) {
    this.board = board;
  }

  public void setPreviousMoveBoard(ChessBoard previousMoveBoard) {
    this.previousMoveBoard = previousMoveBoard;
  }

  public void gameSetup(){
    won.add(false);
    won.add(false);
  
    if(boardSize < 8 || boardSize % 2 == 1){
      boardSize = 8;
      cellSize = 800 / boardSize;
      System.out.println("Error in board size, switched to default.");
    }
  }
  
  public void startGame(boolean newGame){
    
    cellSize = 800 / boardSize;
    
    won.set(0, false);
    won.set(1, false);
    undo = false;
    
    board = new ChessBoard(this, sketch);
    score = new ScoreBoard(sketch);
    previousMoveBoard = new ChessBoard(this, sketch);


    mainMySketch.getTesting().setOnGameboardSetup(board, score, previousMoveBoard);
    mainMySketch.getTesting().testOnGameboardSetup();
    
    if(newGame){
      board.setUp(gameMode);
    }
    
    mainMySketch.setStartScreen(false);
    
  }
  
  /**Runs each frame.
  *  Runs primarily all the visual code.
  *  Sets the background and checkers squares.
  *  Draws the individual chesspieces.
  *  Draws the score.
  */
  public void drawGame(int mouseY, int mouseX){
    chessBoardSquares();
    
    drawChessPieces(mouseX, mouseY);
    
    //Updates the score display.
    if(!board.getPieceSelection() && !board.getPieceSelectionPawn()){
      score.displayPieces();
      score.displayScore();
      
      //Creates the visual triangle, which is the undo button, on the side.
      sketch.fill(0, 0, 0, 150);
      sketch.triangle(825,400,875,380,875,420);

      sketch.fill(0, 0, 0);
      sketch.text(turn, 850, 375); //Display the turn counter.
    }
    
    
    //Display win text.
    if(won.get(0)){
      sketch.fill(0, 0, 0);
      sketch.textSize(150);
      sketch.text("Black Won", 400, 450);
    } else if (won.get(1)){
      sketch.fill(0, 0, 0);
      sketch.textSize(150);
      sketch.text("White Won", 400, 450);
    }
    
    if(board.getPieceSelection() || board.getPieceSelectionPawn()){
      board.drawSelectionBar(mouseY, mouseX);
    }
    
  }
  
  
  void gameMousePressed(int mouseY, int mouseX){
    
    prevMouse.setX(newMouse.getX());
    prevMouse.setY(newMouse.getY());
    newMouse.setX((int) Math.floor(mouseX / cellSize));
    newMouse.setY((int) Math.floor(mouseY / cellSize));
    
    
    //If the player has to select a piece from the sidebar.
    if(board.getPieceSelection()){
      board.mousePressedSelectionBar(mouseY, mouseX);
      return;
    }
    
    
    //If the player has gotten a pawn to the end of the oppiste side. 
    if(board.getPieceSelectionPawn()){
      board.mousePressedSelectionBarPawn(mouseY, mouseX);
      return;
    }
    
    
    //Checks if the curser is where the undo button is, when it is pressed.
    if(mouseX > 800 && mouseX < 900 && mouseY > 375 && mouseY < 425){
      undo();
      return;
    }


    /*
    Makes sure that the curser is inside the chessboard.
    This is because if the board is not a perfect division of 8, are there a tiny gap at some of the egdes.
    This crashes the program, if the mouse is clicked in that space. */
    if(!(mouseX < cellSize * boardSize && mouseY < cellSize * boardSize)){
      return;
    }


    mainMySketch.getTesting().testOnPieceMoveAttempt(prevMouse, newMouse);
      
    //Checks if the user has picked up a piece.
    if(!pickedUpPiece){
      
      //Checks if the mouse is where a legal piece is.
      if(board.getChessPiece(newMouse) != null && board.getChessPiece(newMouse).getTeam() == turn % 2){
        board.getChessPiece(newMouse).setIsPickedUp(true); //Tells the piece that it is picked up.
        pickedUpPiece = true;
      }
      return;
    }
    
    
    //When a user already has a piece picked up.
    //if the chosen chesspiece can move in that way.
    if(!board.getChessPiece(prevMouse).movement(newMouse)){
      board.getChessPiece(prevMouse).setIsPickedUp(false); //Lets the picked up piece know that it is not picked up anymore.
      pickedUpPiece = false;
      return;
    }
    
    
    //There is an error with Passant removing a piece before the board can be saved, so in those cases, do we save the board in the passant function.
    if(!board.getChessPiece(prevMouse).getPerformedPassant()){
      previousMoveBoard.setChessPieceClassMatrix(board.getChessPieceClassMatrix()); //saves the previous move.
    }
    
    
    prevMovedPos.setX(board.getChessPiece(prevMouse).getPositionX());
    prevMovedPos.setY(board.getChessPiece(prevMouse).getPositionY());
    
    
    //If the piece kills another.
    if(board.getChessPiece(newMouse) != null){
      if(board.getChessPiece(newMouse).getType() == "King"){
        won.set(board.getChessPiece(newMouse).getTeam(), true);
      }
      score.addTeamScore(board.getChessPiece(newMouse).getValue(), turn % 2);
      score.addChessPieceType(board.getChessPiece(newMouse).getType(), turn % 2);
      score.setJustKilledPiece(true);
      
    } else if(board.getChessPiece(prevMouse).getPerformedPassant()){
      score.setJustKilledPiece(true);
      
    } else {
      score.setJustKilledPiece(false);
    }
    
    board.getChessPiece(prevMouse).setIsPickedUp(false); //Lets the picked up piece know that it is not picked up anymore.
    board.setChessPiece(prevMouse, newMouse); //Puts the picked up piece into the cell that matches its new spot.
    board.getChessPiece(prevMouse).setPosition(newMouse); //Sets the piece position inside the piece object.
    board.removeChessPiece(prevMouse); //Remove the pointer to the piece in the previous spot.


    mainMySketch.getTesting().testOnPieceMove(prevMouse, newMouse); //Only used for testing and debugging.
    turn++; //increases the turn number
    undo = true;
    saveAndLoad.saveData(this);
    
    pickedUpPiece = false;
    
  }
  
  //Undo the last move.
  void undo(){
    if(!undo){ //Just a failsafe, so it can't undo multiple times in a row.
      return;
    }
      
    //Reduce the turn variable, so it matches and doesn't mess up the turn order.
    turn--;
    
    //Checks to see if the board has just castled, since it moves to spaces, and hos to do something extra to undo that.
    if(board.getJustCastled()){
      board.undoCastle(turn % 2);
    } else {
      board.setChessPieceClassMatrix(previousMoveBoard.getChessPieceClassMatrix()); //Rewinds the board matrix to a matrix saved the previous turn.
    }
    
    //There is a couple moves you can only do if a piece hasn't moved before. Here we revert it, so it still "hasn't moved" if it hadn't before the this turn.
    if(!board.getChessPiece(prevMovedPos).getPrevHasMoved()){
      board.getChessPiece(prevMovedPos).setHasMoved(false);
    }
    
    //Resets the moved piece internal position.
    board.getChessPiece(prevMovedPos).setPosition(prevMovedPos);
    
    //Runs an undo function in the score class, which undo the anything that happend to the score this turn.
    score.undo(turn % 2);
    
    //Sets the boolean to false, since you can't undo more than one move.
    undo = false;
    
    //Saves the data, so the save data file is the turn before the current turn that has just been undone.
    saveAndLoad.saveData(this);
  }
  
  //If the key z is pressed, it also undo the last turn.
  void gameKeyPressed(char key) {
    if(key == 'z' && !board.getPieceSelection() && !board.getPieceSelectionPawn()){
      undo();
    }
  }
  
  
  //Display the image of all the pieces.
  void drawChessPieces(int mouseX, int mouseY){
    for(int i = 0; i < boardSize; i++){
      for(int j = 0; j < boardSize; j++){
        if(board.getChessPiece(new Vector2D(i, j)) != null){
          board.getChessPiece(new Vector2D(i, j)).displayImage(mouseX, mouseY);
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
          sketch.fill(255, 255, 255, 60); //Sets the color to white with quite a high transparancy.
          white = false;
        } else {
          sketch.fill(0, 0, 0, 60); //Sets the color to black with quite a high transparancy.
          white = true;
        }      
        
        //This is the actual squars that is created.
        sketch.rect(j*cellSize, i*cellSize, cellSize, cellSize);
      }
    }
  }
}
