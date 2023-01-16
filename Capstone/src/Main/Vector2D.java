//Tobias Friese
//tfries21@student.aau.dk
//06-01-2023
//OOP Software AAU Semester 3

package Main;

//Since we have to work with coordinates, can we create a vector class to work with them more easily.
public class Vector2D{
  
  private int x;
  private int y;
  
  public Vector2D(int newX, int newY){
    x = newX;
    y = newY;
  }
  
  public int getX(){
    return x;
  }
  
  public int getY(){
    return y;
  }
  
  public void setX(int newX){
    x = newX;
  }
  
  public void setY(int newY){
    y = newY;
  }
  
}
