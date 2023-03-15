class Data {
  float x, y, width, height;
  String flightData;
  PFont font;
  
  
  //Data object
  Data(float x, float y, String flightData, PFont font) {
    this.x=x;
    this.y=y;
    this.flightData = flightData;
    this.font = font;
  }
  
  //Returns the flightData from the file you are reading from
  public String getData() {
    return flightData;
  }
}
