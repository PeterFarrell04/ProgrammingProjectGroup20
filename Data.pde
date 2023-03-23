class Data {
  float x, y, width, height;
  String flightData;
  PFont font;
  String FL_DATE, MKT_CARRIER, ORIGIN, ORIGIN_CITY_NAME,
    ORIGIN_STATE_ABR, DEST, DEST_CITY_NAME, DEST_STATE_ABR;

  //these variables should be converted to ints
  String MKT_CARRIER_FL_NUM, ORIGIN_WAC, DEST_WAC, CRS_DEP_TIME,
    DEP_TIME, CRS_ARR_TIME, ARR_TIME, CANCELLED, DIVERTED,
    DISTANCE;

  //Data object
  Data(float x, float y, String flightData, PFont font) {
    this.x=x;
    this.y=y;
    this.flightData = flightData;
    this.font = font;

    String[] flightDataArray = split(flightData, ",");
    this.FL_DATE = flightDataArray[0];
    this.MKT_CARRIER = flightDataArray[1];
    this.MKT_CARRIER_FL_NUM = (flightDataArray[2]);
    this.ORIGIN = flightDataArray[3];
    this.ORIGIN_CITY_NAME = flightDataArray[4];
    this.ORIGIN_STATE_ABR = flightDataArray[5];
    this.ORIGIN_WAC = (flightDataArray[6]);
    this.DEST = flightDataArray[7];
    this.DEST_CITY_NAME = flightDataArray[8];
    this.DEST_STATE_ABR = flightDataArray[9];
    this.DEST_WAC = (flightDataArray[10]);
    this.CRS_DEP_TIME = (flightDataArray[11]);
    this.DEP_TIME = (flightDataArray[12]);
    this.CRS_ARR_TIME = (flightDataArray[13]);
    this.ARR_TIME = (flightDataArray[14]);
    this.CANCELLED = (flightDataArray[15]);
    this.DIVERTED = (flightDataArray[16]);
    this.DISTANCE = (flightDataArray[17]);
  }

  //Returns the flightData from the file you are reading from
  public String getData() {
    return flightData;
  }
}