public class ChessBoard{
  
  private boolean pawnDoubleMoveWhite = false; //Is a check for if the previous move was a white pawn that moved two spaces.
  private boolean pawnDoubleMoveBlack = false; //Is a check for if the previous move was a white pawn that moved two spaces.
  private boolean justCastled = false; //Is a check for if the previous move was a castle.
  
  //For selecting what the pawn gets transformed into.
  private boolean pieceSelectionPawn = false;
  private Vector2D pawnPosition = new Vector2D(0, 0);
  
  //For selection of pieces in point buy gamemode.
  private boolean pieceSelection = false;
  private int teamTurn = 0;
  private IntList points = new IntList(39, 39);
  private IntList piecesPlaced = new IntList(0, 0);
  private String selectedType;
  private int selectionCost;
  private PImage whitePawnImg;
  private PImage whiteBishopImg;
  private PImage whiteKnightImg;
  private PImage whiteRookImg;
  private PImage whiteQueenImg;
  private PImage whiteKingImg;
  private PImage blackPawnImg;
  private PImage blackBishopImg;
  private PImage blackKnightImg;
  private PImage blackRookImg;
  private PImage blackQueenImg;
  private PImage blackKingImg;
  private PImage SelectedPieceImg;
  
  //game.getNewMouse()
  private Vector2D mousePosition = new Vector2D(0, 0);
  
  private GameModes gameModes = new GameModes(this);
  
  /**
  *  Stores an int if there is a chess piece is in the square matching the matrix.
  *  The int represent which team it belongs to, so team 0 is white, team 1 is black.
  */
  public ChessPieceClass chessBoard[][] = new ChessPieceClass[game.getBoardSize()][game.getBoardSize()];
  
  public ChessPieceClass getChessPiece(Vector2D coords){
    return chessBoard[coords.getX()][coords.getY()];
  }
  
  public void setChessPiece(Vector2D prevCoords, Vector2D coords){
    chessBoard[coords.getX()][coords.getY()] = chessBoard[prevCoords.getX()][prevCoords.getY()];
  }
  
  public void removeChessPiece(Vector2D coords){
    chessBoard[coords.getX()][coords.getY()] = null;
  }
  
  public void setJustCastled(boolean i){
    justCastled = i;
  }
  
  public boolean getJustCastled(){
    return justCastled;
  }
  
  public void setPieceSelection(boolean i){
    pieceSelection = i;
  }
  
  public boolean getPieceSelection(){
    return pieceSelection;
  }
  
  public void setPieceSelectionPawn(boolean i){
    pieceSelectionPawn = i;
  }
  
  public boolean getPieceSelectionPawn(){
    return pieceSelectionPawn;
  }
  
  public void setPawnPosition(Vector2D coords){
    pawnPosition = coords;
  }
  
  public void setSelectedType(String i){
    selectedType = i;
  }
  
  public String getSelectedType(){
    return selectedType;
  }
  
  public void setPoints(int i){
    points.set(0, i);
    points.set(1, i);
  }
  
  public ChessBoard(){
    whitePawnImg = loadImage("Images/White Pawn.png");
    whiteBishopImg = loadImage("Images/White Bishop.png");
    whiteKnightImg = loadImage("Images/White Knight.png");
    whiteRookImg = loadImage("Images/White Rook.png");
    whiteQueenImg = loadImage("Images/White Queen.png");
    whiteKingImg = loadImage("Images/White King.png");
    
    blackPawnImg = loadImage("Images/Black Pawn.png");
    blackBishopImg = loadImage("Images/Black Bishop.png");
    blackKnightImg = loadImage("Images/Black Knight.png");
    blackRookImg = loadImage("Images/Black Rook.png");
    blackQueenImg = loadImage("Images/Black Queen.png");
    blackKingImg = loadImage("Images/Black King.png");
  }
  
  
  /**Sets the pawn boolean, but also sets all pawns in the row for the double move to equal false.
  *  There are two, one for white and one for black, because there was an error when trying to undo, and not being able to passant after.
  */
  public void setPawnDoubleMoveWhite(boolean setBool){
    
    //If a pawn double moved last move.
    if(pawnDoubleMoveWhite){
      for(int j = game.getBoardSize() - 2; j > (game.getBoardSize() / 2) - 2; j--){
        for(int i = 0; i < game.getBoardSize(); i++){
          
          //Checks for white. Makes sure that it's a pawn in the spot it checks.
          if(game.board.getChessPiece(new Vector2D(i, j)) != null && game.board.getChessPiece(new Vector2D(i, j)).getType() == "Pawn"){
            game.board.getChessPiece(new Vector2D(i, j)).setJustDoublePawn(false);
          }
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
      for(int j = 2; j < (game.getBoardSize() / 2) + 2; j++){
        for(int i = 0; i < game.getBoardSize(); i++){
          //Checks for black. Makes sure that it's a pawn in the spot it checks.
          if(game.board.getChessPiece(new Vector2D(i, j)) != null && game.board.getChessPiece(new Vector2D(i, j)).getType() == "Pawn"){
            game.board.getChessPiece(new Vector2D(i, j)).setJustDoublePawn(false);
          }
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
  
  
  public int getValue(Vector2D coords){
    if(chessBoard[coords.getY()][coords.getY()] != null){ //Makes sure that there is a piece to get the value from.
      return chessBoard[coords.getY()][coords.getY()].getValue();
    }
    return -1;
  }
  
  
  //Runs through the matrix and copies each field.
  public void setMatrix(ChessPieceClass[][] otherBoard){
    for(int i = 0; i < game.getBoardSize(); i++){
      for(int j = 0; j < game.getBoardSize(); j++){
        chessBoard[i][j] = otherBoard[i][j];
      }
    }
  }
  
  
  public void undoCastle(int team){
    if(justCastled){
      
      if(team == 0){ //Checks if team is white.
        if(chessBoard[(game.getBoardSize() / 2) - 2][game.getBoardSize() - 1] != null && chessBoard[(game.getBoardSize() / 2) - 2][game.getBoardSize() - 1].getType() == "King"){ //Checks if the king is moved to the left in the castle.
          chessBoard[(game.getBoardSize() / 2) - 1][game.getBoardSize() - 1].setPosition(new Vector2D(0, game.getBoardSize() - 1)); //Sets the rook object position back.
          setMatrix(game.previousMoveBoard.getMatrix()); //Reverts the board matrix back for the king.
          chessBoard[0][game.getBoardSize() - 1] = chessBoard[(game.getBoardSize() / 2) - 1][game.getBoardSize() - 1]; //Puts the rook back in the chessboard matrix because the previousMoveBoard didn't save it, since it's only made for one piece to move at a time.
          chessBoard[(game.getBoardSize() / 2) - 1][game.getBoardSize() - 1] = null; //Deletes the rook from it's castle position.
        } else { //If the king is moved to the Right in the castle.
          chessBoard[(game.getBoardSize() / 2) + 1][game.getBoardSize() - 1].setPosition(new Vector2D(game.getBoardSize() - 1, game.getBoardSize() - 1)); //Sets the rook object position back.
          setMatrix(game.previousMoveBoard.getMatrix()); //Reverts the board matrix back for the king.
          chessBoard[game.getBoardSize() - 1][game.getBoardSize() - 1] = chessBoard[(game.getBoardSize() / 2) + 1][game.getBoardSize() - 1]; //Puts the rook back in the chessboard matrix because the previousMoveBoard didn't save it, since it's only made for one piece to move at a time.
          chessBoard[(game.getBoardSize() / 2) + 1][game.getBoardSize() - 1] = null; //Deletes the rook from it's castle position.
        }
      } else { //Checks if team is black.
        if(chessBoard[(game.getBoardSize() / 2) - 2][0] != null && chessBoard[(game.getBoardSize() / 2) - 2][0].getType() == "King"){ //Checks if the king is moved to the left in the castle.
          chessBoard[(game.getBoardSize() / 2) - 1][0].setPosition(new Vector2D(0, 0)); //Sets the rook object position back.
          setMatrix(game.previousMoveBoard.getMatrix()); //Reverts the board matrix back for the king.
          chessBoard[0][0] = chessBoard[(game.getBoardSize() / 2) - 1][0]; //Puts the rook back in the chessboard matrix because the previousMoveBoard didn't save it, since it's only made for one piece to move at a time.
          chessBoard[(game.getBoardSize() / 2) - 1][0] = null; //Deletes the rook from it's castle position.
        } else { //If the king is moved to the Right in the castle.
          chessBoard[(game.getBoardSize() / 2) + 1][0].setPosition(new Vector2D(game.getBoardSize() - 1, 0)); //Sets the rook object position back.
          setMatrix(game.previousMoveBoard.getMatrix()); //Reverts the board matrix back for the king.
          chessBoard[game.getBoardSize() - 1][0] = chessBoard[(game.getBoardSize() / 2) + 1][0]; //Puts the rook back in the chessboard matrix because the previousMoveBoard didn't save it, since it's only made for one piece to move at a time.
          chessBoard[(game.getBoardSize() / 2) + 1][0] = null; //Deletes the rook from it's castle position.
        }
      }
      
      justCastled = false;
    }
  }
  
  
  public void drawSelectionBar(){
    fill(0,0,0);
    
    if(pieceSelectionPawn){ //If it is mid game and it is because a pawn moved to the end of the board.
      if((game.getTurn() % 2) - 1 == 0){
        image(whitePawnImg, 800, 100, 100, 100); //Pawn
        image(whiteBishopImg, 800, 225, 100, 100); //Bishop
        image(whiteKnightImg, 800, 350, 100, 100); //Knight
        image(whiteRookImg, 800, 475, 100, 100); //Rook
        image(whiteQueenImg, 800, 600, 100, 100); //Queen
      } else {
        image(blackPawnImg, 800, 100, 100, 100); //Pawn
        image(blackBishopImg, 800, 225, 100, 100); //Bishop
        image(blackKnightImg, 800, 350, 100, 100); //Knight
        image(blackRookImg, 800, 475, 100, 100); //Rook
        image(blackQueenImg, 800, 600, 100, 100); //Queen
      }
    } else { //If it is in the point buy game mode.
      
      if(piecesPlaced.get(teamTurn) == (game.getBoardSize() * (game.getBoardSize() / 2 - 1)) - 1 && points.get(teamTurn) >= 0){
        points.set(teamTurn, 0);
      }
      
      if(points.get(0) == 0 && points.get(1) == 0){
        points.set(0, -1);
        points.set(1, -1);
        teamTurn = 0;
        game.setPickedUpPiece(true);
        selectedType = "King";
        SelectedPieceImg = whiteKingImg;
      } else if (teamTurn == 0 && points.get(0) == 0){
        teamTurn = 1;
      } else if (teamTurn == 1 && points.get(1) == 0){
        teamTurn = 0;
      }
      
      textSize(40);
      if(points.get(teamTurn) > 0){
        text(points.get(teamTurn), 850, 50);
      }
      if(teamTurn == 0 && points.get(teamTurn) > 0){
        textSize(25);
        image(whitePawnImg, 800, 100, 100, 100); //Pawn
        text("1", 850, 207);
        image(whiteBishopImg, 800, 225, 100, 100); //Bishop
        text("3", 850, 332);
        image(whiteKnightImg, 800, 350, 100, 100); //Knight
        text("3", 850, 457);
        image(whiteRookImg, 800, 475, 100, 100); //Rook
        text("5", 850, 582);
        image(whiteQueenImg, 800, 600, 100, 100); //Queen
        text("9", 850, 707);
        
        
      } else if(points.get(teamTurn) > 0){
        textSize(25);
        image(blackPawnImg, 800, 100, 100, 100); //Pawn
        text("1", 850, 207);
        image(blackBishopImg, 800, 225, 100, 100); //Bishop
        text("3", 850, 332);
        image(blackKnightImg, 800, 350, 100, 100); //Knight
        text("3", 850, 457);
        image(blackRookImg, 800, 475, 100, 100); //Rook
        text("5", 850, 582);
        image(blackQueenImg, 800, 600, 100, 100); //Queen
        text("9", 850, 707);
      }
      
      
      if(selectedType != null){
        fill(0, 0, 0, 100);
        if(teamTurn == 0){
          rect(0, 0, game.getCellSize() * game.getBoardSize(), game.getCellSize() * (game.getBoardSize() / 2 + 1));
        } else {
          rect(0, game.getCellSize() * (game.getBoardSize() / 2 - 1), game.getCellSize() * game.getBoardSize(), game.getCellSize() * (game.getBoardSize() / 2 + 1));
        }
        image(SelectedPieceImg, mouseX - (game.getCellSize() / 2), mouseY - (game.getCellSize() / 2), game.getCellSize(), game.getCellSize());
      }
    }
    
    
    //This was just to see the hitbox for the selection bar.
    /*
    fill(0,0,0,50);
    rect(800,100,100,100); //Pawn
    rect(800,225,100,100); //Bishop
    rect(800,350,100,100); //Knight
    rect(800,475,100,100); //Rook
    rect(800,600,100,100); //Queen
    */
  }
  
  public void mousePressedSelectionBarPawn(){
    if(mouseX > 800 && mouseX < 900 && mouseY > 100 && mouseY < 200){
      selectedType = "Pawn";
      chessBoard[pawnPosition.getX()][pawnPosition.getY()].convert(pawnPosition);
      
    } else if (mouseX > 800 && mouseX < 900 && mouseY > 225 && mouseY < 325){
      selectedType = "Bishop";
      chessBoard[pawnPosition.getX()][pawnPosition.getY()].convert(pawnPosition);
      
    } else if (mouseX > 800 && mouseX < 900 && mouseY > 350 && mouseY < 450){
      selectedType = "Knight";
      chessBoard[pawnPosition.getX()][pawnPosition.getY()].convert(pawnPosition);
      
    } else if (mouseX > 800 && mouseX < 900 && mouseY > 475 && mouseY < 575){
      selectedType = "Rook";
      chessBoard[pawnPosition.getX()][pawnPosition.getY()].convert(pawnPosition);
      
    } else if (mouseX > 800 && mouseX < 900 && mouseY > 600 && mouseY < 700){
      selectedType = "Queen";
      chessBoard[pawnPosition.getX()][pawnPosition.getY()].convert(pawnPosition);
    }
    
  }
  
  public void selectPiecePointBuy(String type, int cost, PImage whiteTeam, PImage BlackTeam){
    selectedType = type;
    selectionCost = cost;
    game.setPickedUpPiece(true);
    if(teamTurn == 0){
      SelectedPieceImg = whiteTeam;
    } else {
      SelectedPieceImg = BlackTeam;
    }
  }
  
  public void mousePressedSelectionBar(){
    
    
    if(mouseX > 800 && mouseX < 900 && mouseY > 100 && mouseY < 200 && points.get(teamTurn) > 0){
      
      selectPiecePointBuy("Pawn", 1, whitePawnImg, blackPawnImg);
      
    } else if (mouseX > 800 && mouseX < 900 && mouseY > 225 && mouseY < 325 && points.get(teamTurn) > 2){
      
      selectPiecePointBuy("Bishop", 3, whiteBishopImg, blackBishopImg);
      
    } else if (mouseX > 800 && mouseX < 900 && mouseY > 350 && mouseY < 450 && points.get(teamTurn) > 2){
      
      selectPiecePointBuy("Knight", 3, whiteKnightImg, blackKnightImg);
      
    } else if (mouseX > 800 && mouseX < 900 && mouseY > 475 && mouseY < 575 && points.get(teamTurn) > 4){
      
      selectPiecePointBuy("Rook", 5, whiteRookImg, blackRookImg);
      
    } else if (mouseX > 800 && mouseX < 900 && mouseY > 600 && mouseY < 700 && points.get(teamTurn) > 8){
      
      selectPiecePointBuy("Queen", 9, whiteQueenImg, blackQueenImg);
    }
    
    
    if(game.getPickedUpPiece() && (int) Math.floor(mouseX / game.getCellSize()) < game.getBoardSize() && chessBoard[mousePosition.getX()][mousePosition.getY()] == null){
      println(mousePosition.getX() + " " + mousePosition.getY());
      if(teamTurn == 0 && mousePosition.getY() > (game.getBoardSize() / 2) && points.get(0) >= 0){
        placeSelectedPiece();
        teamTurn = 1;
      }
      
      
      if(teamTurn == 1 && mousePosition.getY() < (game.getBoardSize() / 2) - 1 && points.get(1) >= 0){
        placeSelectedPiece();
        teamTurn = 0;
      }
      
      println((game.getBoardSize() * (game.getBoardSize() / 2 - 1)) - 1);
      println("placed: " + piecesPlaced.get(teamTurn));
      
      //When both players have put all their pieces down.
      if(points.get(0) == -1 && points.get(1) == -1){
        
        if(teamTurn == 0 && mousePosition.getY() > (game.getBoardSize() / 2)){
          spawnNewPiece(mousePosition, 0, selectedType);
          SelectedPieceImg = blackKingImg;
          teamTurn = 1;
        }
        
        if(teamTurn == 1 && mousePosition.getY() < (game.getBoardSize() / 2) - 1){
          spawnNewPiece(mousePosition, 1, selectedType);
          game.setPickedUpPiece(false);
          pieceSelection = false;
        }
      }
      
    }
    
  }
  
  //Places the selected piece if it is possible and legal in the point buy gamemode.
  public void placeSelectedPiece(){
    spawnNewPiece(mousePosition, teamTurn, selectedType); //Spawns the piece on the board.
    game.setPickedUpPiece(false); //Sets so the player hasn't automatically a piece picked. 
    selectedType = null; //So the player doesn't accidentally place a piece they didn't select.
    piecesPlaced.set(teamTurn, piecesPlaced.get(teamTurn) + 1); //Keeps track of the amount of pieces the player has put down.
    points.set(teamTurn, points.get(teamTurn) - selectionCost); //Subtracks the cost of the selected piece from the points available.
  }
  
  
  public void spawnNewPiece(Vector2D coords, int team, String type){
    switch(type){
      case "Pawn":
        chessBoard[coords.getX()][coords.getY()] = new Pawn(team, coords, this);
        break;
      
      case "Bishop":
        chessBoard[coords.getX()][coords.getY()] = new Bishop(team, coords, this);
        break;
        
      case "Knight":
        chessBoard[coords.getX()][coords.getY()] = new Knight(team, coords, this);
        break;
        
      case "Rook":
        chessBoard[coords.getX()][coords.getY()] = new Rook(team, coords, this);
        break;
        
      case "Queen":
        chessBoard[coords.getX()][coords.getY()] = new Queen(team, coords, this);
        break;
        
      case "King":
        chessBoard[coords.getX()][coords.getY()] = new King(team, coords, this);
        break;
    }
  }
  
}
