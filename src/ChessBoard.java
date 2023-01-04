package src;

import processing.core.PApplet;
import processing.core.PImage;
import processing.data.IntList;

public class ChessBoard extends PApplet {

  private Game game;

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
  
  private GameModes gameModes;
  private PApplet sketch;
  
  //Stores the chesspiece objects from the board.
  public ChessPieceClass chessBoard[][];
  
  
  
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

  public ChessBoard(Game game, PApplet sketch){
    this.game = game;
    this.sketch = sketch;

    whitePawnImg = loadImage(sketchPath("Data/Images/White Pawn.png"));
    whiteBishopImg = loadImage(sketchPath("Data/Images/White Bishop.png"));
    whiteKnightImg = loadImage(sketchPath("Data/Images/White Knight.png"));
    whiteRookImg = loadImage(sketchPath("Data/Images/White Rook.png"));
    whiteQueenImg = loadImage(sketchPath("Data/Images/White Queen.png"));
    whiteKingImg = loadImage(sketchPath("Data/Images/White King.png"));

    blackPawnImg = loadImage(sketchPath("Data/Images/Black Pawn.png"));
    blackBishopImg = loadImage(sketchPath("Data/Images/Black Bishop.png"));
    blackKnightImg = loadImage(sketchPath("Data/Images/Black Knight.png"));
    blackRookImg = loadImage(sketchPath("Data/Images/Black Rook.png"));
    blackQueenImg = loadImage(sketchPath("Data/Images/Black Queen.png"));
    blackKingImg = loadImage(sketchPath("Data/Images/Black King.png"));

    chessBoard = new ChessPieceClass[game.getBoardSize()][game.getBoardSize()];
    gameModes = new GameModes(this, game, sketch);
  }

  
  /**Sets the pawn boolean, but also sets all pawns in the row for the double move to equal false.
  *  There are two, one for white and one for black, because there was an error when trying to undo, and not being able to passant after.
  */
  public void setPawnDoubleMoveWhite(boolean setBool){
    
    //If a pawn double moved last move.
    if(!pawnDoubleMoveWhite){
      pawnDoubleMoveWhite = setBool;
      return;
    }
    
    
    for(int j = game.getBoardSize() - 2; j > (game.getBoardSize() / 2) - 2; j--){
      for(int i = 0; i < game.getBoardSize(); i++){
        
        //Checks for white. Makes sure that it's a pawn in the spot it checks.
        if(game.getBoard().getChessPiece(new Vector2D(i, j)) != null && game.getBoard().getChessPiece(new Vector2D(i, j)).getType() == "Pawn"){
          game.getBoard().getChessPiece(new Vector2D(i, j)).setJustDoublePawn(false);
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
    if(!pawnDoubleMoveBlack){
      pawnDoubleMoveBlack = setBool;
      return;
    }
    
    for(int j = 2; j < (game.getBoardSize() / 2) + 2; j++){
      for(int i = 0; i < game.getBoardSize(); i++){
        
        //Checks for black. Makes sure that it's a pawn in the spot it checks.
        if(game.getBoard().getChessPiece(new Vector2D(i, j)) != null && game.getBoard().getChessPiece(new Vector2D(i, j)).getType() == "Pawn"){
          game.getBoard().getChessPiece(new Vector2D(i, j)).setJustDoublePawn(false);
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
  
  
  
  public ChessPieceClass[][] getChessPieceClassMatrix(){
    return chessBoard;
  }
 
  
  
  public int getValue(Vector2D coords){
    if(chessBoard[coords.getY()][coords.getY()] != null){ //Makes sure that there is a piece to get the value from.
      return chessBoard[coords.getY()][coords.getY()].getValue();
    }
    return -1;
  }
  
  
  
  //Runs through the matrix and copies each field.
  public void setChessPieceClassMatrix(ChessPieceClass[][] otherBoard){
    for(int i = 0; i < game.getBoardSize(); i++){
      for(int j = 0; j < game.getBoardSize(); j++){
        chessBoard[i][j] = otherBoard[i][j];
      }
    }
  }
  
  
  
  public void undoCastle(int team){
    if(!justCastled){
      return;
    }
      
    if(team == 0){ //Checks if team is white.
      if(chessBoard[(game.getBoardSize() / 2) - 2][game.getBoardSize() - 1] != null && chessBoard[(game.getBoardSize() / 2) - 2][game.getBoardSize() - 1].getType() == "King"){ //Checks if the king is moved to the left in the castle.
        chessBoard[(game.getBoardSize() / 2) - 1][game.getBoardSize() - 1].setPosition(new Vector2D(0, game.getBoardSize() - 1)); //Sets the rook object position back.
        setChessPieceClassMatrix(game.getPreviousMoveBoard().getChessPieceClassMatrix()); //Reverts the board matrix back for the king.
        chessBoard[0][game.getBoardSize() - 1] = chessBoard[(game.getBoardSize() / 2) - 1][game.getBoardSize() - 1]; //Puts the rook back in the chessboard matrix because the previousMoveBoard didn't save it, since it's only made for one piece to move at a time.
        chessBoard[(game.getBoardSize() / 2) - 1][game.getBoardSize() - 1] = null; //Deletes the rook from it's castle position.
      } else { //If the king is moved to the Right in the castle.
        chessBoard[(game.getBoardSize() / 2) + 1][game.getBoardSize() - 1].setPosition(new Vector2D(game.getBoardSize() - 1, game.getBoardSize() - 1)); //Sets the rook object position back.
        setChessPieceClassMatrix(game.getPreviousMoveBoard().getChessPieceClassMatrix()); //Reverts the board matrix back for the king.
        chessBoard[game.getBoardSize() - 1][game.getBoardSize() - 1] = chessBoard[(game.getBoardSize() / 2) + 1][game.getBoardSize() - 1]; //Puts the rook back in the chessboard matrix because the previousMoveBoard didn't save it, since it's only made for one piece to move at a time.
        chessBoard[(game.getBoardSize() / 2) + 1][game.getBoardSize() - 1] = null; //Deletes the rook from it's castle position.
      }
      
    } else { //Checks if team is black.
      if(chessBoard[(game.getBoardSize() / 2) - 2][0] != null && chessBoard[(game.getBoardSize() / 2) - 2][0].getType() == "King"){ //Checks if the king is moved to the left in the castle.
        chessBoard[(game.getBoardSize() / 2) - 1][0].setPosition(new Vector2D(0, 0)); //Sets the rook object position back.
        setChessPieceClassMatrix(game.getPreviousMoveBoard().getChessPieceClassMatrix()); //Reverts the board matrix back for the king.
        chessBoard[0][0] = chessBoard[(game.getBoardSize() / 2) - 1][0]; //Puts the rook back in the chessboard matrix because the previousMoveBoard didn't save it, since it's only made for one piece to move at a time.
        chessBoard[(game.getBoardSize() / 2) - 1][0] = null; //Deletes the rook from it's castle position.
      } else { //If the king is moved to the Right in the castle.
        chessBoard[(game.getBoardSize() / 2) + 1][0].setPosition(new Vector2D(game.getBoardSize() - 1, 0)); //Sets the rook object position back.
        setChessPieceClassMatrix(game.getPreviousMoveBoard().getChessPieceClassMatrix()); //Reverts the board matrix back for the king.
        chessBoard[game.getBoardSize() - 1][0] = chessBoard[(game.getBoardSize() / 2) + 1][0]; //Puts the rook back in the chessboard matrix because the previousMoveBoard didn't save it, since it's only made for one piece to move at a time.
        chessBoard[(game.getBoardSize() / 2) + 1][0] = null; //Deletes the rook from it's castle position.
      }
    }
    
    justCastled = false;
    
  }
  
  
  
  public void drawSelectionBar(int mouseY, int mouseX){
    sketch.fill(0,0,0);
    
    if(pieceSelectionPawn){ //If it is mid game and it is because a pawn moved to the end of the board.
      if((game.getTurn() % 2) - 1 == 0){
        sketch.image(whitePawnImg, 800, 100, 100, 100); //Pawn
        sketch.image(whiteBishopImg, 800, 225, 100, 100); //Bishop
        sketch.image(whiteKnightImg, 800, 350, 100, 100); //Knight
        sketch.image(whiteRookImg, 800, 475, 100, 100); //Rook
        sketch.image(whiteQueenImg, 800, 600, 100, 100); //Queen
      } else {
        sketch.image(blackPawnImg, 800, 100, 100, 100); //Pawn
        sketch.image(blackBishopImg, 800, 225, 100, 100); //Bishop
        sketch.image(blackKnightImg, 800, 350, 100, 100); //Knight
        sketch.image(blackRookImg, 800, 475, 100, 100); //Rook
        sketch.image(blackQueenImg, 800, 600, 100, 100); //Queen
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

      sketch.textSize(40);
      if(points.get(teamTurn) > 0){
        sketch.text(points.get(teamTurn), 850, 50);
      }
      if(teamTurn == 0 && points.get(teamTurn) > 0){
        sketch.textSize(25);
        sketch.image(whitePawnImg, 800, 100, 100, 100); //Pawn
        sketch.text("1", 850, 207);
        sketch.image(whiteBishopImg, 800, 225, 100, 100); //Bishop
        sketch.text("3", 850, 332);
        sketch.image(whiteKnightImg, 800, 350, 100, 100); //Knight
        sketch.text("3", 850, 457);
        sketch.image(whiteRookImg, 800, 475, 100, 100); //Rook
        sketch.text("5", 850, 582);
        sketch.image(whiteQueenImg, 800, 600, 100, 100); //Queen
        sketch.text("9", 850, 707);
        
        
      } else if(points.get(teamTurn) > 0){
        sketch.textSize(25);
        sketch.image(blackPawnImg, 800, 100, 100, 100); //Pawn
        sketch.text("1", 850, 207);
        sketch.image(blackBishopImg, 800, 225, 100, 100); //Bishop
        sketch.text("3", 850, 332);
        sketch.image(blackKnightImg, 800, 350, 100, 100); //Knight
        sketch.text("3", 850, 457);
        sketch.image(blackRookImg, 800, 475, 100, 100); //Rook
        sketch.text("5", 850, 582);
        sketch.image(blackQueenImg, 800, 600, 100, 100); //Queen
        sketch.text("9", 850, 707);
      }
      
      
      if(selectedType != null){
        sketch.fill(0, 0, 0, 100);
        if(teamTurn == 0){
          sketch.rect(0, 0, game.getCellSize() * game.getBoardSize(), game.getCellSize() * (game.getBoardSize() / 2 + 1));
        } else {
          sketch.rect(0, game.getCellSize() * (game.getBoardSize() / 2 - 1), game.getCellSize() * game.getBoardSize(), game.getCellSize() * (game.getBoardSize() / 2 + 1));
        }
        sketch.image(SelectedPieceImg, mouseX - (game.getCellSize() / 2), mouseY - (game.getCellSize() / 2), game.getCellSize(), game.getCellSize());
      }
    }

  }
  
  
  
  public void mousePressedSelectionBarPawn(int mouseY, int mouseX){
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
  
  
  
  public void mousePressedSelectionBar(int mouseY, int mouseX){
    
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
    
    
    if(game.getPickedUpPiece() && (int) Math.floor(mouseX / game.getCellSize()) < game.getBoardSize() && chessBoard[game.getNewMouse().getX()][game.getNewMouse().getY()] == null){
      System.out.println(game.getNewMouse().getX() + " " + game.getNewMouse().getY());
      if(teamTurn == 0 && game.getNewMouse().getY() > (game.getBoardSize() / 2) && points.get(0) >= 0){
        placeSelectedPiece();
        teamTurn = 1;
      }
      
      
      if(teamTurn == 1 && game.getNewMouse().getY() < (game.getBoardSize() / 2) - 1 && points.get(1) >= 0){
        placeSelectedPiece();
        teamTurn = 0;
      }
      
      System.out.println((game.getBoardSize() * (game.getBoardSize() / 2 - 1)) - 1);
      System.out.println("placed: " + piecesPlaced.get(teamTurn));
      
      //When both players have put all their pieces down.
      if(points.get(0) == -1 && points.get(1) == -1){
        
        if(teamTurn == 0 && game.getNewMouse().getY() > (game.getBoardSize() / 2)){
          spawnNewPiece(game.getNewMouse(), 0, selectedType);
          SelectedPieceImg = blackKingImg;
          teamTurn = 1;
        }
        
        if(teamTurn == 1 && game.getNewMouse().getY() < (game.getBoardSize() / 2) - 1){
          spawnNewPiece(game.getNewMouse(), 1, selectedType);
          game.setPickedUpPiece(false);
          pieceSelection = false;
        }
      }
      
    }
    
  }
  
  
  
  //Places the selected piece if it is possible and legal in the point buy gamemode.
  public void placeSelectedPiece(){
    spawnNewPiece(game.getNewMouse(), teamTurn, selectedType); //Spawns the piece on the board.
    game.setPickedUpPiece(false); //Sets so the player hasn't automatically a piece picked. 
    selectedType = null; //So the player doesn't accidentally place a piece they didn't select.
    piecesPlaced.set(teamTurn, piecesPlaced.get(teamTurn) + 1); //Keeps track of the amount of pieces the player has put down.
    points.set(teamTurn, points.get(teamTurn) - selectionCost); //Subtracks the cost of the selected piece from the points available.
  }
  
  
  
  public void spawnNewPiece(Vector2D coords, int team, String type){
    switch(type){
      case "Pawn":
        chessBoard[coords.getX()][coords.getY()] = new Pawn(team, coords, this, game, sketch);
        break;
      
      case "Bishop":
        chessBoard[coords.getX()][coords.getY()] = new Bishop(team, coords, this, game, sketch);
        break;
        
      case "Knight":
        chessBoard[coords.getX()][coords.getY()] = new Knight(team, coords, this, game, sketch);
        break;
        
      case "Rook":
        chessBoard[coords.getX()][coords.getY()] = new Rook(team, coords, this, game, sketch);
        break;
        
      case "Queen":
        chessBoard[coords.getX()][coords.getY()] = new Queen(team, coords, this, game, sketch);
        break;
        
      case "King":
        chessBoard[coords.getX()][coords.getY()] = new King(team, coords, this, game, sketch);
        break;
    }
  }
  
}
