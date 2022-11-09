PImage background;

ChessBoard board;
ChessBoard previousMoveBoard;
ScoreBoard score;

boolean pickedUpPiece = false;
boolean undo = false;
int prevMovePos[] = new int[2];

int turn = 0;

//Mousepress variables
int prevMouseX;
int prevMouseY;
int newMouseX;
int newMouseY;


//Is run once when the program is launched.
void setup() {
  size(900, 800); //Sets the window size.
  frameRate(30); //Sets the framerate.
  
  background = loadImage("Images/Marble Background.png"); //Loads in the image for the background.
  
  board = new ChessBoard();
  score = new ScoreBoard();
  previousMoveBoard = new ChessBoard();
  
  board.setUp("standard");
}


/**Runs each frame.
*  Runs primarily all the visual code.
*  Sets the background and checkers squares.
*  Draws the individual chesspieces.
*  Draws the score.
*/
void draw(){
  image(background, 0, 0, width, height);
  chessBoardSquares();
  
  drawChessPieces();
  
  score.displayPieces();
  score.displayScore();
  
  fill(0, 0, 0, 150);
  triangle(825,400,875,380,875,420);
}


void mousePressed(){
  
  if(mouseX > 800 && mouseX < 900 && mouseY > 375 && mouseY < 425){
    undo();
  }
  
  if((int) Math.floor(mouseX / 100) < 8){
    
    prevMouseX = newMouseX;
    prevMouseY = newMouseY;
    newMouseX = (int) Math.floor(mouseX / 100);
    newMouseY = (int) Math.floor(mouseY / 100);
    
    
    if(!pickedUpPiece){
      
      if(board.getChessPiece(newMouseX, newMouseY) != null && board.getChessPiece(newMouseX, newMouseY).getTeam() == turn % 2){
        board.getChessPiece(newMouseX, newMouseY).setIsPickedUp(true);
        pickedUpPiece = true;
      }
      
    } else {
    
      //if the chosen chesspiece can move in that way.
      if(board.getChessPiece(prevMouseX, prevMouseY).movement(prevMouseX, prevMouseY, newMouseX, newMouseY)){
        
        //If there isn't a chesspiece in the space moved to.
        if((board.getChessPiece(newMouseX, newMouseY) == null) || (board.getChessPiece(newMouseX, newMouseY).getTeam() != board.getChessPiece(prevMouseX, prevMouseY).getTeam())){
          
          //saves the previous move.
          previousMoveBoard.setMatrix(board.getMatrix());
          prevMovePos[0] = board.getChessPiece(prevMouseX, prevMouseY).getPosition(0);
          prevMovePos[1] = board.getChessPiece(prevMouseX, prevMouseY).getPosition(1);
          
          //If the piece kills another.
          if(board.getChessPiece(newMouseX, newMouseY) != null){
            score.editTeamScore(board.getChessPiece(newMouseX, newMouseY).getValue(), turn % 2, "add");
            score.addChessPieceType(board.getChessPiece(newMouseX, newMouseY).getType(), turn % 2);
          }
          
          board.getChessPiece(prevMouseX, prevMouseY).setIsPickedUp(false); //Lets the picked up piece know that it is not picked up anymore.
          board.setChessPiece(prevMouseX, prevMouseY, newMouseX, newMouseY); //Puts the picked up piece into the cell that matches its new spot.
          board.getChessPiece(prevMouseX, prevMouseY).setPosition(newMouseX, newMouseY); //Sets the piece position inside the piece object.
          board.removeChessPiece(prevMouseX, prevMouseY); //Remove the pointer to the piece in the previous spot.
          turn++;
          undo = true;
          
        //If there is a chessPiece in the space moved to but it's your own.
        } else {
          board.getChessPiece(prevMouseX, prevMouseY).setIsPickedUp(false); //Lets the picked up piece know that it is not picked up anymore.
        }
      } else {
        board.getChessPiece(prevMouseX, prevMouseY).setIsPickedUp(false); //Lets the picked up piece know that it is not picked up anymore.
      }
      
      pickedUpPiece = false;
    }
    
    println("x: " + newMouseX + " " + prevMouseX);
    println("y: " + newMouseY + " " + prevMouseY);
    println(pickedUpPiece);
  }
}

//Undo the last move.
void undo(){
  if(undo){ //Just a fail safe, so it can't undo multiple times in a row.
    board.setMatrix(previousMoveBoard.getMatrix()); //Rewinds the board matrix to a matrix saved the previous turn. 
    board.getChessPiece(prevMovePos[0], prevMovePos[1]).setPosition(prevMovePos[0], prevMovePos[1]);
    
    turn--;
    
    score.editTeamScore(score.getPrevScore(), turn % 2, "remove");
    score.removeChessPieceType(turn % 2);
    
    undo = false;
  }
}

void keyPressed() {
  if(key == 'z'){
    undo();
  }
}


void drawChessPieces(){
  for(int i = 0; i < 8; i++){
    for(int j = 0; j < 8; j++){
      if(board.getChessPiece(i, j) != null){
        board.getChessPiece(i, j).displayImage();
      }
    }
  }
}


void chessBoardSquares(){
  boolean white = false;
  
  for(int i = 0; i < 8; i++){
    if(white){
        white = false;
      } else {
        white = true;
      }
    for(int j = 0; j < 8; j++){
      
      if(white){
        fill(255, 255, 255, 60);
        white = false;
      } else {
        fill(0, 0, 0, 60);
        white = true;
      }      
      
      rect(j*100, i*100, 100, 100);
    }
  }
}
