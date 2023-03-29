class Data {
  String flightData;
  PFont font;
  float x;
  float y;
  
  //all values as String
  String FL_DATE, MKT_CARRIER, ORIGIN, ORIGIN_CITY_NAME, 
         ORIGIN_STATE_ABR, DEST, DEST_CITY_NAME, DEST_STATE_ABR, 
         MKT_CARRIER_FL_NUMstring, ORIGIN_WACstring, DEST_WACstring,
         CRS_DEP_TIMEstring, DEP_TIMEstring, CRS_ARR_TIMEstring, 
         ARR_TIMEstring, CANCELLEDstring, DIVERTEDstring, DISTANCEstring;
  
  //numerical values as int
  int MKT_CARRIER_FL_NUM, ORIGIN_WAC, DEST_WAC, CRS_DEP_TIME, 
      DEP_TIME, CRS_ARR_TIME, ARR_TIME, CANCELLED, DIVERTED, 
      DISTANCE;
      
  String[] flightDataArray; 
  
  //Data object
    Data(float x, float y, String flightData, PFont font) {
    this.x=x;
    this.y=y;
    this.flightData = flightData;
    this.font = font;
    
    String[] flightDataArray = flightData.split(",(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)", -1);
    this.FL_DATE = flightDataArray[0];
    this.MKT_CARRIER = flightDataArray[1];
    this.MKT_CARRIER_FL_NUMstring = flightDataArray[2];
    if (this.MKT_CARRIER_FL_NUMstring != "")
    {
      this.MKT_CARRIER_FL_NUM = Integer.valueOf(flightDataArray[2]);
    }
    else
    {
      this.MKT_CARRIER_FL_NUM = -1;
    }
    this.ORIGIN = flightDataArray[3];
    this.ORIGIN_CITY_NAME = flightDataArray[4];
    this.ORIGIN_STATE_ABR = flightDataArray[5];
    this.ORIGIN_WACstring = flightDataArray[6];
    if (this.ORIGIN_WACstring != "")
    {
      this.ORIGIN_WAC = Integer.valueOf(flightDataArray[6]);
    }
    else 
    {
      this.ORIGIN_WAC = -1;
    }
    this.DEST = flightDataArray[7];
    this.DEST_CITY_NAME = flightDataArray[8];
    this.DEST_STATE_ABR = flightDataArray[9];
    this.DEST_WACstring = flightDataArray[10];
    if (this.DEST_WACstring != "")
    {
      this.DEST_WAC = Integer.valueOf(flightDataArray[10]);
    }
    else
    {
      this.DEST_WAC = -1;
    }
    this.CRS_DEP_TIMEstring = flightDataArray[11];
    if (this.CRS_DEP_TIMEstring != "")
    {
      this.CRS_DEP_TIME = Integer.valueOf(flightDataArray[11]);
    }
    else
    {
      this.CRS_DEP_TIME = -1;
    }
    this.DEP_TIMEstring = flightDataArray[12];
    if (this.DEP_TIMEstring != "")
    {
      this.DEP_TIME = Integer.valueOf(flightDataArray[12]);
    }
    else
    {
      this.DEP_TIME = -1;
    }
    this.CRS_ARR_TIMEstring = flightDataArray[13];
    if (this.CRS_ARR_TIMEstring != "")
    {
      this.CRS_ARR_TIME = Integer.valueOf(flightDataArray[13]);
    }
    else
    {
      this.CRS_ARR_TIME = -1;
    }
    this.ARR_TIMEstring = flightDataArray[14];
    if (this.ARR_TIMEstring != "")
    {
      this.ARR_TIME = Integer.valueOf(flightDataArray[14]);
    }
    else
    {
      this.ARR_TIME = -1;
    }
    this.CANCELLEDstring = flightDataArray[15];
    if (this.CANCELLEDstring != "")
    {
      this.CANCELLED = Integer.valueOf(flightDataArray[15]);
    }
    else
    {
      this.CANCELLED = -1;
    }
    this.DIVERTEDstring = flightDataArray[16];
    if (this.DIVERTEDstring != "")
    {
      this.DIVERTED = Integer.valueOf(flightDataArray[16]);
    }
    else
    {
      this.DIVERTED = -1;
    }
    this.DISTANCEstring = flightDataArray[17];
    if (this.DISTANCEstring != "")
    {
      this.DISTANCE = Integer.valueOf(flightDataArray[17]);
    }
    else
    {
      this.DISTANCE = -1;
    }
  }

  
  //Returns the entire set of flightData from the file you are reading from
  public String getData() {
    return flightData;
  }
  
  //returns String user requested data
  public String getStrVal(String input)
  {
   
    switch(input) 
    {
      case "FL_DATE": return this.FL_DATE;
      case "MKT_CARRIER": return this.MKT_CARRIER;
      case "ORIGIN": return this.ORIGIN;
      case "ORIGIN_CITY_NAME": return this.ORIGIN_CITY_NAME;
      case "ORIGIN_STATE_ABR": return this.ORIGIN_STATE_ABR;
      case "DEST": return this.DEST;
      case "DEST_CITY_NAME": return this.DEST_CITY_NAME;
      case "DEST_STATE_ABR": return this.DEST_STATE_ABR;
    }
    return "error";
  }
  
  //returns int user requested data
  public int getIntVal(String input)
  {
   
    switch(input) 
    {
      case "MKT_CARRIER_FL_NUM": return this.MKT_CARRIER_FL_NUM;
      case "ORIGIN_WAC": return this.ORIGIN_WAC;
      case "DEST_WAC": return this.DEST_WAC;
      case "CRS_DEP_TIME": return this.CRS_DEP_TIME;
      case "DEP_TIME": return this.DEP_TIME;
      case "CRS_ARR_TIME": return this.CRS_ARR_TIME;
      case "ARR_TIME": return this.ARR_TIME;
      case "CANCELLED": return this.CANCELLED;
      case "DIVERTED": return this.DIVERTED;
      case "DISTANCE": return this.DISTANCE;
    }
    return -1;
  }
  
  //returns 0 if String, 1 if int
  public int getDataType(String input)
  {
    switch(input) 
    {
      case "FL_DATE": return 0;
      case "MKT_CARRIER": return 0;
      case "MKT_CARRIER_FL_NUM": return 1;
      case "ORIGIN": return 0;
      case "ORIGIN_CITY_NAME": return 0;
      case "ORIGIN_STATE_ABR": return 0;
      case "ORIGIN_WAC": return 1;
      case "DEST": return 0;
      case "DEST_CITY_NAME": return 0;
      case "DEST_STATE_ABR": return 0;
      case "DEST_WAC": return 1;
      case "CRS_DEP_TIME": return 1;
      case "DEP_TIME": return 1;
      case "CRS_ARR_TIME": return 1;
      case "ARR_TIME": return 1;
      case "CANCELLED": return 1;
      case "DIVERTED": return 1;
      case "DISTANCE": return 1;
    }
    return -1;
  }
}
