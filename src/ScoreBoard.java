package src;

import processing.core.PApplet;
import processing.core.PImage;
import processing.data.IntList;
import processing.data.StringList;

public class ScoreBoard extends PApplet {

  private PImage blackPawn;
  private PImage whitePawn;
  private PImage blackBishop;
  private PImage whiteBishop;
  private PImage blackRook;
  private PImage whiteRook;
  private PImage blackKnight;
  private PImage whiteKnight;
  private PImage blackQueen;
  private PImage whiteQueen;
  private PImage blackKing;
  private PImage whiteKing;
  private PApplet sketch;

  private int prevScore;
  private IntList teamScore = new IntList(0, 0);
  private StringList killedChessPiecesTeamWhite;
  private StringList killedChessPiecesTeamBlack;
  private boolean justKilledPiece = false;



  public ScoreBoard(PApplet sketch){
    killedChessPiecesTeamWhite = new StringList();
    killedChessPiecesTeamBlack = new StringList();
    loadImages();
    this.sketch = sketch;
  }



  public int getTeamScore(int team){
    return teamScore.get(team);
  }

  public int getPrevScore(){
    return prevScore;
  }

  public void setJustKilledPiece(boolean i){
    justKilledPiece = i;
  }

  public boolean getJustKilledPiece(){
    return justKilledPiece;
  }

  public StringList getKilledChessPiecesTeamWhite() {
    return killedChessPiecesTeamWhite;
  }

  public StringList getKilledChessPiecesTeamBlack() {
    return killedChessPiecesTeamBlack;
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



  public void undo(int team){
    if(justKilledPiece){
      addTeamScore(-prevScore, team);
      removeChessPieceType(team);
    }
  }



  public void setTeamScore(int score, int team){
    teamScore.set(team, score);
  }



  public void addTeamScore(int score, int team){
    //saves the score that passes through, in case of an undo.
    prevScore = score;

    teamScore.set(team, teamScore.get(team) + score);
  }



  public void displayScore(){
    sketch.fill(0, 0, 0);
    //textAlign(CENTER);
    sketch.textSize(40);
    sketch.text(teamScore.get(0), 850, 50);
    sketch.text(teamScore.get(1), 850, 780);
  }



  public void displayPieces(){

    for(int i = 0; i < killedChessPiecesTeamBlack.size(); i++){
      switch(killedChessPiecesTeamBlack.get(i)){
        case "Pawn":
          sketch.image(whitePawn, (float) (805 + (30 * (i%3))), (float) (60 + (30 * (Math.floor(i / 3)))), (float) 28, (float) 28);
          break;

        case "Bishop":
          sketch.image(whiteBishop, (float) (805 + (30 * (i%3))), (float) (60 + (30 * (Math.floor(i / 3)))), (float) 28, (float) 28);
          break;

        case "Knight":
          sketch.image(whiteKnight, (float) (805 + (30 * (i%3))), (float) (60 + (30 * (Math.floor(i / 3)))), (float) 28, (float) 28);
          break;

        case "Rook":
          sketch.image(whiteRook, (float) (805 + (30 * (i%3))), (float) (60 + (30 * (Math.floor(i / 3)))), (float) 28, (float) 28);
          break;

        case "Queen":
          sketch.image(whiteQueen, (float) (805 + (30 * (i%3))), (float) (60 + (30 * (Math.floor(i / 3)))), (float) 28, (float) 28);
          break;

        case "King":
          sketch.image(whiteKing, (float) (805 + (30 * (i%3))), (float) (60 + (30 * (Math.floor(i / 3)))), (float) 28, (float) 28);
          break;
      }
    }

    for(int i = 0; i < killedChessPiecesTeamWhite.size(); i++){
      switch(killedChessPiecesTeamWhite.get(i)){
        case "Pawn":
          sketch.image(blackPawn, (float) (805 + (30 * (i%3))), (float) (710 - (30 * (Math.floor(i / 3)))), (float) 28, (float) 28);
          break;

        case "Bishop":
          sketch.image(blackBishop, (float) (805 + (30 * (i%3))), (float) (710 - (30 * (Math.floor(i / 3)))), (float) 28, (float) 28);
          break;

        case "Knight":
          sketch.image(blackKnight, (float) (805 + (30 * (i%3))), (float) (710 - (30 * (Math.floor(i / 3)))), (float) 28, (float) 28);
          break;

        case "Rook":
          sketch.image(blackRook, (float) (805 + (30 * (i%3))), (float) (710 - (30 * (Math.floor(i / 3)))), (float) 28, (float) 28);
          break;

        case "Queen":
          sketch.image(blackQueen, (float) (805 + (30 * (i%3))), (float) (710 - (30 * (Math.floor(i / 3)))), (float) 28, (float) 28);
          break;

        case "King":
          sketch.image(blackKing, (float) (805 + (30 * (i%3))), (float) (710 - (30 * (Math.floor(i / 3)))), (float) 28, (float) 28);
          break;
      }
    }
  }



  public void loadImages(){
    blackPawn = loadImage(sketchPath("Data/Images/Black Pawn.png"));
    whitePawn = loadImage(sketchPath("Data/Images/White Pawn.png"));
    blackBishop = loadImage(sketchPath("Data/Images/Black Bishop.png"));
    whiteBishop = loadImage(sketchPath("Data/Images/White Bishop.png"));
    blackRook = loadImage(sketchPath("Data/Images/Black Rook.png"));
    whiteRook = loadImage(sketchPath("Data/Images/White Rook.png"));
    blackKnight = loadImage(sketchPath("Data/Images/Black Knight.png"));
    whiteKnight = loadImage(sketchPath("Data/Images/White Knight.png"));
    blackQueen = loadImage(sketchPath("Data/Images/Black Queen.png"));
    whiteQueen = loadImage(sketchPath("Data/Images/White Queen.png"));
    blackKing = loadImage(sketchPath("Data/Images/Black King.png"));
    whiteKing = loadImage(sketchPath("Data/Images/White King.png"));
  }



  public void resetScoreboard(){
    for(int i = 0; i < killedChessPiecesTeamWhite.size(); i++){
      killedChessPiecesTeamWhite.remove(killedChessPiecesTeamWhite.size() - 1);
    }
    for(int i = 0; i < killedChessPiecesTeamBlack.size(); i++){
      killedChessPiecesTeamBlack.remove(killedChessPiecesTeamBlack.size() - 1);
    }
    teamScore.set(0, 0);
    teamScore.set(1, 0);
  }
}
