import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class BarChart {
  // Class fields
  float x, y, width, height; // Position and dimensions of the chart
  PFont font; // Font used for displaying text
  Map<String, Integer> freq; // Map that stores the frequency of each data point
  List<Map.Entry<String, Integer>> top; // List that stores the sorted frequency data
  int dataPart = getReqData(answer);
  int showAmount;
  // Constructor
  BarChart(float x, float y, float width, float height, PFont font, int showAmount) 
  {
    // Initialise class fields
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.font = font;
    this.freq = new HashMap<String, Integer>();
    this.top = new ArrayList<Map.Entry<String, Integer>>();
    this.showAmount = showAmount;
  }

  // Method for adding data to the chart
  void addData(String flightData) 
  {
    // Split the flight data string into an array
    String[] flightDataArray = flightData.split(",(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)", -1);
    // Get the destination city name from the flight data
    String destCityName = flightDataArray[dataPart];
    //String destCityName = flightDataArray[4];
    // If the destination city name is already in the frequency map, increment its count
    if (freq.containsKey(destCityName)) 
    {
      freq.put(destCityName, freq.get(destCityName) + 1);
      // Otherwise, add the destination city name to the frequency map with a count of 1
    } else {
      freq.put(destCityName, 1);
    }
    
  }

  // Method for showing the top n data points on the chart
  void showTop() 
  {
    // Sort the frequency map by value (i.e., the count of each data point)
    top.addAll(freq.entrySet());
    Collections.sort(top, (a, b) -> b.getValue().compareTo(a.getValue()));
    // Show the top n data points
    
    float xb = x;
     int count = 0;

    
    for (Map.Entry<String, Integer> entry : top) 
    {
      if (count >= showAmount) 
      {
        break;
      }
      
      //print(entry.getValue());
      // Calculate the height of the bar based on the count of the data point
      float barHeight = map(entry.getValue(), 0, top.get(0).getValue(), 0, height);
      // Display the bar on the chart
      fill(255);
      rect(xb, y - barHeight, width * 0.8 / showAmount, barHeight);
      // Display the abbreviation of the data point's name on the chart
      fill(255);
      textFont(font);
      text(entry.getKey(), xb + width/2 * 0.8 / showAmount / 2, y + 20);
      // Increment the x position for the next bar
      count++;
      xb += width * 0.8 / showAmount;
    }
  }
  public int getReqData(String input)
  {
   
    switch(input) 
    {
      case "FL_DATE": return 0;
      case "MKT_CARRIER": return 1;
      case "MKT_CARRIER_FL_NUM": return 2;
      case "ORIGIN": return 3;
      case "ORIGIN_CITY_NAME": return 4;
      case "ORIGIN_STATE_ABR": return 5;
      case "ORIGIN_WAC": return 6;
      case "DEST": return 7;
      case "DEST_CITY_NAME": return 8;
      case "DEST_STATE_ABR": return 9;
      case "DEST_WAC": return 10;
      case "CRS_DEP_TIME": return 11;
      case "DEP_TIME": return 12;
      case "CRS_ARR_TIME": return 13;
      case "ARR_TIME": return 14;
      case "CANCELLED": return 15;
      case "DIVERTED": return 16;
      case "DISTANCE": return 17;
    }
    return 8;
  }
}
