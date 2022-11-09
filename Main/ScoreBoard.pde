public class ScoreBoard{
    
  PImage blackPawn;
  PImage whitePawn;
  PImage blackBishop;
  PImage whiteBishop;
  PImage blackRook;
  PImage whiteRook;
  PImage blackKnight;
  PImage whiteKnight;
  PImage blackQueen;
  PImage whiteQueen;
  PImage blackKing;
  PImage whiteKing;
  
  private int prevScore;
  private int teamScore[] = {0, 0};
  private StringList killedChessPiecesTeamWhite;
  private StringList killedChessPiecesTeamBlack;
  
  ScoreBoard(){
    killedChessPiecesTeamWhite = new StringList();
    killedChessPiecesTeamBlack = new StringList();
    loadImages();
  }
  
  public int getTeamScore(int team){
    return teamScore[team];
  }
  
  public int getPrevScore(){
    return prevScore;
  }
  
  public void addChessPieceType(String piece, int team){
    if(team == 0){
      killedChessPiecesTeamWhite.append(piece);
    } else {
      killedChessPiecesTeamBlack.append(piece);
    }
  }
  
  public void removeChessPieceType(int team){
    if(team == 0){
      killedChessPiecesTeamWhite.remove(killedChessPiecesTeamWhite.size() - 1);
    } else {
      killedChessPiecesTeamBlack.remove(killedChessPiecesTeamBlack.size() - 1);
    }
  }
  
  
  public void editTeamScore(int score, int team, String type){
    //saves the score that passes through, in case of an undo.
    prevScore = score;
    
    switch (type){
      case "set":
        teamScore[team] = score;
        break;
        
      case "add":
        teamScore[team] += score;
        break;
        
      case "remove":
        teamScore[team] -= score;
        break;
      
      case "reset":
        teamScore[team] = 0;
        break;
        
      default:
        break;
    }
  }
  
  void displayScore(){
    fill(0, 0, 0);
    textAlign(CENTER);
    textSize(40);
    text(teamScore[1], 850, 50);
    text(teamScore[0], 850, 780);
  }
  
  
  void displayPieces(){
    
    for(int i = 0; i < killedChessPiecesTeamBlack.size(); i++){
      switch(killedChessPiecesTeamBlack.get(i)){
        case "Pawn":
          image(whitePawn, (float) (805 + (30 * (i%3))), (float) (60 + (30 * (Math.floor(i / 3)))), (float) 28, (float) 28);
          break;
        case "Bishop":
          image(whiteBishop, (float) (805 + (30 * (i%3))), (float) (60 + (30 * (Math.floor(i / 3)))), (float) 28, (float) 28);
          break;
        case "Knight":
          image(whiteKnight, (float) (805 + (30 * (i%3))), (float) (60 + (30 * (Math.floor(i / 3)))), (float) 28, (float) 28);
          break;
        case "Rook":
          image(whiteRook, (float) (805 + (30 * (i%3))), (float) (60 + (30 * (Math.floor(i / 3)))), (float) 28, (float) 28);
          break;
        case "Queen":
          image(whiteQueen, (float) (805 + (30 * (i%3))), (float) (60 + (30 * (Math.floor(i / 3)))), (float) 28, (float) 28);
          break;
        case "King":
          image(whiteKing, (float) (805 + (30 * (i%3))), (float) (60 + (30 * (Math.floor(i / 3)))), (float) 28, (float) 28);
          break;
      }
    }
    
    for(int i = 0; i < killedChessPiecesTeamWhite.size(); i++){
      switch(killedChessPiecesTeamWhite.get(i)){
        case "Pawn":
          image(blackPawn, (float) (805 + (30 * (i%3))), (float) (710 - (30 * (Math.floor(i / 3)))), (float) 28, (float) 28);
          break;
        case "Bishop":
          image(blackBishop, (float) (805 + (30 * (i%3))), (float) (710 - (30 * (Math.floor(i / 3)))), (float) 28, (float) 28);
          break;
        case "Knight":
          image(blackKnight, (float) (805 + (30 * (i%3))), (float) (710 - (30 * (Math.floor(i / 3)))), (float) 28, (float) 28);
          break;
        case "Rook":
          image(blackRook, (float) (805 + (30 * (i%3))), (float) (710 - (30 * (Math.floor(i / 3)))), (float) 28, (float) 28);
          break;
        case "Queen":
          image(blackQueen, (float) (805 + (30 * (i%3))), (float) (710 - (30 * (Math.floor(i / 3)))), (float) 28, (float) 28);
          break;
        case "King":
          image(blackKing, (float) (805 + (30 * (i%3))), (float) (710 - (30 * (Math.floor(i / 3)))), (float) 28, (float) 28);
          break;
      }
    }
  }
  
  
  void loadImages(){
    blackPawn = loadImage("Images/Black Pawn.png");
    whitePawn = loadImage("Images/White Pawn.png");
    blackBishop = loadImage("Images/Black Bishop.png");
    whiteBishop = loadImage("Images/White Bishop.png");
    blackRook = loadImage("Images/Black Rook.png");
    whiteRook = loadImage("Images/White Rook.png");
    blackKnight = loadImage("Images/Black Knight.png");
    whiteKnight = loadImage("Images/White Knight.png");
    blackQueen = loadImage("Images/Black Queen.png");
    whiteQueen = loadImage("Images/White Queen.png");
    blackKing = loadImage("Images/Black King.png");
    whiteKing = loadImage("Images/White King.png");
  }
  
}
