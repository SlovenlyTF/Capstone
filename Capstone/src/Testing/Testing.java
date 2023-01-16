//Tobias Friese
//tfries21@student.aau.dk
//06-01-2023
//OOP Software AAU Semester 3

package Testing;

import Main.*;
import ChessPieces.*;

public class Testing {

    private Game game;
    private ScoreBoard scoreBoard;
    private StartMenu startMenu;
    private ChessBoard board;
    private ChessBoard previousMoveBoard;
    private ChessPieceClass chessPieceClass[][];

    public Testing(Game game, StartMenu startMenu){
        this.game = game;
        this.startMenu = startMenu;
    }

    public void setOnGameboardSetup(ChessBoard board, ScoreBoard scoreBoard, ChessBoard previousMoveBoard){
        this.board = board;
        this.scoreBoard = scoreBoard;
        this.previousMoveBoard = previousMoveBoard;
        this.chessPieceClass = board.getChessPieceClassMatrix();
    }



    /**
     * Gets run on program startup.
     */
    public void testStartup(){

    }

    /**
     * Gets run on game startup
     */
    public void testOnGameboardSetup(){

    }

    /**
     * Gets run on every click on the board
     * @param prevMouse The previous mouse clicked location
     * @param newMouse The current mouse clicked location
     */
    public void testOnPieceMoveAttempt(Vector2D prevMouse, Vector2D newMouse){


        debugTextBoardClick(prevMouse, newMouse);
    }

    /**
     * Gets run on every succesful piece move
     * @param prevMouse The previous mouse clicked location
     * @param newMouse The current mouse clicked location
     */
    public void testOnPieceMove(Vector2D prevMouse, Vector2D newMouse){
        //isChessPieceNull(chessPieceClass[newMouse.getX()][newMouse.getY()]);
    }



    /**
     * Just some information text of the current clicked piece
     * @param prevMouse The previous mouse clicked location
     * @param newMouse The current mouse clicked location
     */
    public void debugTextBoardClick(Vector2D prevMouse, Vector2D newMouse){
        System.out.println("");
        System.out.println("Prev: " + "(" + prevMouse.getX() + "," + prevMouse.getY() + ")");
        System.out.println("New: " + "(" + newMouse.getX() + "," + newMouse.getY() + ")");
        if(board.getChessPiece(newMouse) != null){
            System.out.println("type: " + board.getChessPiece(newMouse).getType());
            System.out.println("Team: " + board.getChessPiece(newMouse).getTeam());
            System.out.println("Has moved: " + board.getChessPiece(newMouse).getHasMoved());
        } else {
            System.out.println("null");
        }
    }


    // ↓ ↓ ---: Unit Tests :--- ↓ ↓

    //null
    public void isChessPieceNull(ChessPieceClass input){
        if (input == null){
            System.out.println("Expected to be: NULL." + "The object is: NULL");
            System.out.println("The result matches.");
        } else {
            System.out.println("Expected to be: NULL." + "The object is: " + input);
        }
    }

    //non-null
    public void isChessPieceNonNull(ChessPieceClass input){
        if (input != null){
            System.out.println("Expected to be: non-NULL. " + "The object is: " + input);
        } else {
            System.out.println("Expected to be: non-NULL. " + "The object is: NULL");
            System.out.println("The result matches.");
        }
    }

    //number
    public void expectedNumber(int input, int expected){
        System.out.println("Expected to be: " + expected + ". " + "The object is: " + input);
        if (input == expected){
            System.out.println("The result matches.");
        }
    }

    //Within range
    public void isItWithinRange(int input, int expectedLow, int expectedHigh){
        System.out.println("Expected to be within: " + expectedLow + " and " + expectedHigh + ". " + "The object is: " + input);
        if (input >= expectedLow && input <= expectedHigh){
            System.out.println("The result matches.");
        }
    }

    //Within boardsize
    public void isItWithinBoardsize(int input){
        int expectedLow = 0;
        int expectedHigh = game.getBoardSize() - 1;
        System.out.println("Expected to be within: " + expectedLow + " and " + expectedHigh + ". " + "The object is: " + input);
        if (input >= expectedLow && input <= expectedHigh){
            System.out.println("The result matches.");
        }
    }

    //true
    public void isItTrue(boolean input){
        System.out.println("Expected to be within: True. " + "The object is: " + input);
        if (input == true){
            System.out.println("The result matches.");
        }
    }

    //false
    public void isItFalse(boolean input){
        System.out.println("Expected to be within: False. " + "The object is: " + input);
        if (input == false){
            System.out.println("The result matches.");
        }
    }

}
