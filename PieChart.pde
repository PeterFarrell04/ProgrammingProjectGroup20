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
  String[] labels;
  int numSlices;
  int x, y;
  int diameter;

  PieChart(float[] data, String[] labels, int x, int y, int diameter) {
    this.data = data;
    this.labels = labels;
    this.numSlices = data.length;
    this.x = x;
    this.y = y;
    this.diameter = diameter;
  }

  void display() {
    float lastAngle = 0;
    for (int i = 0; i < numSlices; i++) {
      fill(i *255/numSlices + 100); //Color of slices
      strokeWeight(5); //Outline width
      stroke(#253342); //Outline colour

      arc(x, y, diameter, diameter, lastAngle, lastAngle+radians(data[i]/100*360)); //Slice of pie chart
      float labelX = x + cos(lastAngle + radians(data[i]/2)) * diameter/2; //Text x position
      float labelY = y + sin(lastAngle + radians(data[i]/2)) * diameter/2; //Text y position
      
      textAlign(CENTER, CENTER);
      lastAngle += radians(data[i]/100*360); //Angle at which the previous slice ended
      fill(#9F2B68); //Text colour
      textFont(pieChartFont); //Text font initialised in main
      text(labels[i], labelX, labelY); //renders text on screen
    }
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
