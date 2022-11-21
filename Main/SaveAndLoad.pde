public class SaveAndLoad {
  
  XML Data;
  
  
  public void loadData(Game game){
    Data = loadXML("Data.xml");
    
    XML gameData = Data.getChild("gameData");
    
    
    game.setTurn(gameData.getInt("turn"));
    game.setBoardSize(gameData.getInt("boardSize"));
    game.startGame(false);
    
    
    XML cellData[] = Data.getChildren("boardData/cellData");
    
    for(int i = 0; i < game.getBoardSize(); i++){
      for(int j = 0; j < game.getBoardSize(); j++){
        
        //Gets what type of piece it is.
        String type = cellData[(i * game.getBoardSize()) + j].getString("type");
        
        switch(type){ //Creates the piece on the board to match the type found.
          case "Pawn":
            game.board.chessBoard[j][i] = new Pawn(cellData[(i * game.getBoardSize()) + j].getInt("team"), new Vector2D(j, i), game.board);
            break;
            
          case "Bishop":
            game.board.chessBoard[j][i] = new Bishop(cellData[(i * game.getBoardSize()) + j].getInt("team"), new Vector2D(j, i), game.board);
            break;
            
          case "Knight":
            game.board.chessBoard[j][i] = new Knight(cellData[(i * game.getBoardSize()) + j].getInt("team"), new Vector2D(j, i), game.board);
            break;
            
          case "Rook":
            game.board.chessBoard[j][i] = new Rook(cellData[(i * game.getBoardSize()) + j].getInt("team"), new Vector2D(j, i), game.board);
            break;
            
          case "Queen":
            game.board.chessBoard[j][i] = new Queen(cellData[(i * game.getBoardSize()) + j].getInt("team"), new Vector2D(j, i), game.board);
            break;
            
          case "King":
            game.board.chessBoard[j][i] = new King(cellData[(i * game.getBoardSize()) + j].getInt("team"), new Vector2D(j, i), game.board);
            break;
            
          default:
            game.board.chessBoard[j][i] = null;
            break;
        }
        
        //Sets if it has moved or not.
        if(game.board.getChessPiece(new Vector2D(j, i)) != null){
          if(cellData[(i * game.getBoardSize()) + j].getInt("hasMoved") == 0){
            game.board.getChessPiece(new Vector2D(j, i)).setHasMoved(true);
          } else {
            game.board.getChessPiece(new Vector2D(j, i)).setHasMoved(false);
          }
        }
      }
    }
    
    //Finds the place where the data is stored from the scoreboard.
    XML scoreData = Data.getChild("scoreData");
    
    //Get the child that holds all the pieces white has killed. :(
    XML whiteKilled = scoreData.getChild("whiteKilled");
    XML whiteCasualty[] = whiteKilled.getChildren("casualty");
    for(int i = 0; i < whiteCasualty.length; i++){ //Loops through the children.
      game.score.addChessPieceType(whiteCasualty[i].getContent(), 0);
    }
    
    //Get the child that holds all the pieces black has killed. :(
    XML blackKilled = scoreData.getChild("blackKilled");
    XML blackCasualty[] = blackKilled.getChildren("casualty");
    for(int i = 0; i < blackCasualty.length; i++){ //Loops through the children.
      game.score.addChessPieceType(blackCasualty[i].getContent(), 1);
    }
    
    //Sets the points for scoreboard. 
    XML points = scoreData.getChild("points");
    game.score.setTeamScore(points.getInt("white"), 0);
    game.score.setTeamScore(points.getInt("black"), 1);
    
    
  }

  
  public void saveData(Game game){
    
    XML TemplateData = loadXML("Template Data.xml");
    
    if(TemplateData == null){
      //Creates the file.
      PrintWriter NewSave = createWriter(sketchPath("Data/Template Data.xml"));
      NewSave.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
      NewSave.println("<Data>");
      NewSave.println("</Data>");
      NewSave.close();
      
      //Just loads the newly created fil, so we have XML variable to edit.
      TemplateData = loadXML("Template Data.xml");
      
      TemplateData.addChild("gameData");
      TemplateData.addChild("boardData");
      XML tempScore = TemplateData.addChild("scoreData");
      tempScore.addChild("whiteKilled");
      tempScore.addChild("blackKilled");
      tempScore.addChild("points");
      
      saveXML(TemplateData, "Data/Template Data.xml");
    }
    
    //Saves the turn and boardsize.
    XML gameData = TemplateData.getChild("gameData");
    gameData.setInt("boardSize", game.getBoardSize());
    gameData.setInt("turn", game.getTurn());
    
    //Is the parent for the board, where all the cells will be saved.
    XML boardData = TemplateData.getChild("boardData");
    
    //Loops through all the cells.
    for(int i = 0; i < game.getBoardSize(); i++){
      for(int j = 0; j < game.getBoardSize(); j++){
        
        //Creates the cell for data to be stored.
        XML cellData = boardData.addChild("cellData");
        
        //In case the cell is empty.
        if(game.board.getChessPiece(new Vector2D(j, i)) == null){
          cellData.setString("type", "Empty");
        } else {
          
          
          cellData.setString("type", game.board.getChessPiece(new Vector2D(j, i)).getType()); //Saves the type.
          cellData.setInt("team", game.board.getChessPiece(new Vector2D(j, i)).getTeam()); //Saves which team it is on.
          if(game.board.getChessPiece(new Vector2D(j, i)).getHasMoved()){ //It can't save booleans, so I'll just save 0 for false and 1 for true.
            cellData.setInt("hasMoved", 1);
          } else {
            cellData.setInt("hasMoved", 0);
          }
          
        }
      }
    }
    
    //Creates a place to store the data from the scoreboard.
    XML scoreData = TemplateData.getChild("scoreData");
    
    //Creates a child to hold all the pieces white has killed. :(
    XML whiteKilled = scoreData.getChild("whiteKilled");
    for(int i = 0; i < game.score.killedChessPiecesTeamWhite.size(); i++){ //Loops through the string list.
      XML casualty = whiteKilled.addChild("casualty");
      casualty.setContent(game.score.killedChessPiecesTeamWhite.get(i));
    }
    
    //Creates a child to hold all the pieces black has killed. :(
    XML blackKilled = scoreData.getChild("blackKilled");
    for(int i = 0; i < game.score.killedChessPiecesTeamBlack.size(); i++){ //Loops through the string list.
      XML casualty = blackKilled.addChild("casualty");
      casualty.setContent(game.score.killedChessPiecesTeamBlack.get(i));
    }
    
    XML points = scoreData.getChild("points");
    points.setInt("white", game.score.getTeamScore(0));
    points.setInt("black", game.score.getTeamScore(1));
    
    saveXML(TemplateData, "Data/Data.xml");
  }
}
