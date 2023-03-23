class Data {
  String flightData;
  PFont font;
  float x;
  float y;
  String FL_DATE, MKT_CARRIER, ORIGIN, ORIGIN_CITY_NAME, 
         ORIGIN_STATE_ABR, DEST, DEST_CITY_NAME, DEST_STATE_ABR, 
         MKT_CARRIER_FL_NUMstring, ORIGIN_WACstring, DEST_WACstring,
         CRS_DEP_TIMEstring, DEP_TIMEstring, CRS_ARR_TIMEstring, 
         ARR_TIMEstring, CANCELLEDstring, DIVERTEDstring, DISTANCEstring;
  
  //these variables should be converted to ints
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
    if (this.MKT_CARRIER_FL_NUMstring != null)
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
    if (this.ORIGIN_WACstring != null)
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
    if (this.DEST_WACstring != null)
    {
      this.DEST_WAC = Integer.valueOf(flightDataArray[10]);
    }
    else
    {
      this.DEST_WAC = -1;
    }
    if (this.CRS_DEP_TIMEstring != null)
    {
      this.CRS_DEP_TIME = Integer.valueOf(flightDataArray[11]);
    }
    else
    {
      this.CRS_DEP_TIME = -1;
    }
    if (this.DEP_TIMEstring != null)
    {
      this.DEP_TIME = Integer.valueOf(flightDataArray[12]);
    }
    else
    {
      this.DEP_TIME = -1;
    }
    if (this.CRS_ARR_TIMEstring != null)
    {
      this.CRS_ARR_TIME = Integer.valueOf(flightDataArray[13]);
    }
    else
    {
      this.CRS_ARR_TIME = -1;
    }
    if (this.ARR_TIMEstring != null)
    {
      this.ARR_TIME = Integer.valueOf(flightDataArray[14]);
    }
    else
    {
      this.ARR_TIME = -1;
    }
    if (this.CANCELLEDstring != null)
    {
      this.CANCELLED = Integer.valueOf(flightDataArray[15]);
    }
    else
    {
      this.CANCELLED = -1;
    }
    if (this.DIVERTEDstring != null)
    {
      this.DIVERTED = Integer.valueOf(flightDataArray[16]);
    }
    else
    {
      this.DIVERTED = -1;
    }
    if (this.DISTANCEstring != null)
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
  
  //returns user requested data
  //public String getReqData(String input)
  //{
   
  //  switch(input) 
  //  {
  //    case "FL_DATE": return this.FL_DATE;
  //    case "MKT_CARRIER": return this.MKT_CARRIER;
  //    case "MKT_CARRIER_FL_NUM": return this.MKT_CARRIER_FL_NUM;
  //    case "ORIGIN": return this.ORIGIN;
  //    case "ORIGIN_CITY_NAME": return this.ORIGIN_CITY_NAME;
  //    case "ORIGIN_STATE_ABR": return this.ORIGIN_STATE_ABR;
  //    case "ORIGIN_WAC": return this.ORIGIN_WAC;
  //    case "DEST": return this.DEST;
  //    case "DEST_CITY_NAME": return this.DEST_CITY_NAME;
  //    case "DEST_STATE_ABR": return this.DEST_STATE_ABR;
  //    case "DEST_WAC": return this.DEST_WAC;
  //    case "CRS_DEP_TIME": return this.CRS_DEP_TIME;
  //    case "DEP_TIME": return this.DEP_TIME;
  //    case "CRS_ARR_TIME": return this.CRS_ARR_TIME;
  //    case "ARR_TIME": return this.ARR_TIME;
  //    case "CANCELLED": return this.CANCELLED;
  //    case "DIVERTED": return this.DIVERTED;
  //    case "DISTANCE": return this.DISTANCE;
  //  }
  //  //return "error";
  //  return flightData;
  //}
}
