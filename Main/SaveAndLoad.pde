public class SaveAndLoad {
  private XML Data;
  private int size = 8;
  
  public SaveAndLoad(){
    Data = loadXML("Data.xml");
  }
  
  
  public void loadData(ChessBoard board, ScoreBoard score){
    XML[] pieces = Data.getChildren("Spaces/Piece");
  }

  
  public void saveData(ChessBoard board, ScoreBoard score){
    XML[] pieces = Data.getChildren("Spaces/Piece");
    
    //If the size of the board is equal to the save file. (Incase you use a game mode with a bigger/smaller board)
    if(pieces.length == size){
      //XML
      
    } else { //If the size of the board is not equal to the save file. (Incase you use a game mode with a bigger/smaller board)
      
      for(int i = 0; i < size; i++){
        for(int j = 0; j < size; j++){
          
        }
      }
    }
  }
}
