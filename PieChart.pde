//Made by Travis Yusuf
//Pie chart Diagram
//Takes in float[] and creates pieChart based on their ratios.

//PUT THIS IN DRAW TO TEST PROGRAM
//float[] data = {20, 30, 10, 40};
//String[] labels = {"Slice 1", "Slice 2", "Slice 3", "Slice 4"};
//PieChart pieChart = new PieChart(data, labels, width/2, height/2, 200);
//pieChart.display();

class PieChart {
  float[] data;
  ArrayList<String> labels;
  int numSlices;
  int x, y;
  int diameter;
  PFont font;

  PieChart(int x, int y, int diameter) {
    
    this.x = x;
    this.y = y;
    this.diameter = diameter;
    this.labels = getLabels();
    this.data = getData();
    this.numSlices = data.length;
    this.font = createFont("Arial", 16);
  }

  // Emma Wijsman
  // returns list of all unique values to use as labels
  ArrayList<String> getLabels()
  {
    ArrayList<String> labels = new ArrayList<String>();
    labels.add(dataList.get(0).getStrVal(getDataName(coarseAnswer)));
    for (int i = 0; i < dataList.size(); i++)
    {
      for (int j = 0; j < labels.size(); j++)
      {
        if ( !labels.contains(dataList.get(i).getStrVal(getDataName(coarseAnswer))) )
        {
          labels.add(dataList.get(i).getStrVal(getDataName(coarseAnswer)));
        }
      }
    }
    return labels;
  }
  
  // Emma Wijsman
  // returns array of floats that count the frequency of each unique value (label)
  float[] getData()
  {
    Query q;
    
    ArrayList<Integer> dataCountList = new ArrayList<Integer>();
    
    for (int i = 0; i < labels.size(); i++)
    {
      q = new Query(getDataName(coarseAnswer), labels.get(i));
      q.run();
      dataCountList.add(q.count);
    }
    
    float[] dataCounts = new float[dataCountList.size()];
    
    for (int i = 0; i < dataCountList.size(); i++)
    {
      dataCounts[i] = dataCountList.get(i);
    }
    
    return dataCounts;
  }

  void display() {
    float lastAngle = 0;
    color[] sliceColors = generateColors(numSlices, color(0, 100, 255), color(255, 100, 0)); // generate a color gradient for the slices
    for (int i = 0; i < numSlices; i++) {
      float sliceAngle = 360.0 / sum(data) * data[i]; // calculate the angle for each slice
      fill(sliceColors[i % sliceColors.length] + 400*i); // Color of slices
      if (i == numSlices-1) {
        fill(#573b88);
      }
      //noStroke(); // no outline
      strokeWeight(2);
      stroke(#541f3f);
      arc(x, y, diameter, diameter, lastAngle, lastAngle + radians(sliceAngle)); // Slice of pie chart
      float labelRadius = diameter/1.8; // Distance from center of pie chart to label
      float labelX = x + cos(lastAngle + radians(sliceAngle / 2)) * labelRadius; // Text x position
      float labelY = y + sin(lastAngle + radians(sliceAngle / 2)) * labelRadius; // Text y position
      textAlign(CENTER, CENTER);
      fill(255); // Text color
      textFont(font);
      text(labels.get(i), labelX, labelY); // Render text on screen
      lastAngle += radians(sliceAngle); // Angle at which the previous slice ended
    }
  }

  // Helper method to generate a color gradient for the slices
  color[] generateColors(int numSlices, color startColor, color endColor) {
    // Create an array to hold the colors for each slice
    color[] colors = new color[numSlices];
    for (int i = 0; i < numSlices; i++) {
      // Calculate the ratio of the current index to the total number of slices
      float colorRatio = (float) i / (numSlices - 1);
      // Generate a color that is a gradient between the start and end colors
      colors[i] = lerpColor(startColor, endColor, colorRatio);
    }
    // Return the array of colors
    return colors;
  }

  // Helper method to sum up the values in the data array
  float sum(float[] arr) {
    float total = 0;
    for (float val : arr) {
      total += val;
    }
    return total;
  }
}




//Extra info
//ARC function works like this
//arc( a, b, c, d , startAngle, stopAngle)
//a  (float)  x-coordinate of the arc's ellipse
//b  (float)  y-coordinate of the arc's ellipse
//c  (float)  width of the arc's ellipse by default
//d  (float)  height of the arc's ellipse by default
//start  (float)  angle to start the arc, specified in radians
//stop  (float)  angle to stop the arc, specified in radians
