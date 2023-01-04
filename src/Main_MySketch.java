package src;

import processing.core.PApplet;
import processing.core.PImage;

public class Main_MySketch extends PApplet{

    private boolean startScreen = true;

    private PImage background;

    private static Main_MySketch mainMySketch;

    private SaveAndLoad saveAndLoadData;

    private Game game;

    private StartMenu startMenu;


    public void setStartScreen(boolean startScreen) {
        this.startScreen = startScreen;
    }

    public void settings(){
        size(900, 800); //Sets the window size.
        saveAndLoadData = new SaveAndLoad(this);
        game = new Game(saveAndLoadData, mainMySketch, this);
        startMenu = new StartMenu(game, saveAndLoadData, this);
    }

    //Is run once when the program is launched.
    public void setup() {
        frameRate(60); //Sets the framerate.

        textAlign(CENTER);
        background = loadImage(sketchPath("Data/Images/Marble Background.png")); //Loads in the image for the background.


        game.gameSetup();
        startMenu.startMenuSetup();
    }


    /**
     * Runs each frame.
     *  Runs primarily all the visual code.
     */
    public void draw(){

        image(background, 0, 0, width, height);

        if(startScreen){
            startMenu.startMenuDraw();
        } else {
            game.drawGame(mouseY, mouseX);
        }

    }



    public void mousePressed(){
        if(startScreen){
            startMenu.startMenuMousePressed(mouseY, mouseX);
        } else {
            game.gameMousePressed(mouseY, mouseX);
        }

    }



    public void keyPressed() {
        startMenu.setKeyCodeVar(keyCode);
        if(!startScreen){
            game.gameKeyPressed(key);

            //Back to main menu.
            if(keyCode == BACKSPACE){
                startScreen = true;
                game.setBoard(null);
                game.setTurn(0);
                game.getScore().resetScoreboard();
            }
        }
    }


    public void keyReleased(){
        startMenu.setKeyCodeVar(0);
        keyCode = 0;
    }


    public static void main(String[] args){
        String[] processingArgs = {"MySketch"};
        mainMySketch = new Main_MySketch();
        PApplet.runSketch(processingArgs, mainMySketch);
    }
}
