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

  // Constructor
  BarChart(float x, float y, float width, float height, PFont font) {
    // Initialise class fields
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.font = font;
    this.freq = new HashMap<String, Integer>();
    this.top = new ArrayList<Map.Entry<String, Integer>>();
  }

  // Method for adding data to the chart
  void addData(String flightData) {
    // Split the flight data string into an array
    String[] flightDataArray = split(flightData, ",");
    // Get the destination city name from the flight data
    String destCityName = flightDataArray[8];
    //String destCityName = flightDataArray[4];
    // If the destination city name is already in the frequency map, increment its count
    if (freq.containsKey(destCityName)) {
      freq.put(destCityName, freq.get(destCityName) + 1);
      // Otherwise, add the destination city name to the frequency map with a count of 1
    } else {
      freq.put(destCityName, 1);
    }
  }

  // Method for showing the top n data points on the chart
  void showTop(int n) {
    // Sort the frequency map by value (i.e., the count of each data point)
    top.addAll(freq.entrySet());
    Collections.sort(top, (a, b) -> b.getValue().compareTo(a.getValue()));
    // Show the top n data points
    int count = 0;
    for (Map.Entry<String, Integer> entry : top) {
      if (count >= n) {
        break;
      }
      // Calculate the height of the bar based on the count of the data point
      float barHeight = map(entry.getValue(), 0, top.get(0).getValue(), 0, height);
      // Display the bar on the chart
      fill(255);
      rect(x, y - barHeight, width * 0.8 / n, barHeight);
      // Display the abbreviation of the data point's name on the chart
      fill(255);
      text(entry.getKey(), x + width * 0.8 / n / 2, y + 20);
      // Increment the x position for the next bar
      count++;
      x += width * 0.8 / n;
    }
  }
}
