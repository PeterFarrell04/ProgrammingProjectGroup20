/*
heatmap graph by Travis Yusuf
 
 COLOR GRADIENTS (low to high)
   Green: #d2fbd4, #123f5a 
   Blue: #d1eeea, #2a5674
   Red: #ede5cf, #541f3f
   Purple: #f3e0f7, #63589f
           #f9ddda,#573b88
 */


class heatmap {
  int[][] data; // 2D array to hold the data to be visualized
  int x, y, cellSize; // x and y position of top-left corner of heatmap, size of each cell in the heatmap
  String[] monthLabels = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"}; // labels for the columns (months)
  String[] cityLabels; // array of city/town labels for the rows
  PFont font; // font for the labels

  heatmap(int[][] data, int x, int y, int cellSize, PFont font, String[] cityLabels) { // constructor to initialize the object with a font and city/town labels
    this.data = data;
    this.x = x;
    this.y = y;
    this.cellSize = cellSize;
    this.font = font;
    this.cityLabels = cityLabels;
  }

  void draw() { // method to draw the heatmap
    
    // draw heatmap
    for (int i = 0; i < data.length; i++) { // iterate over the rows of the data
      for (int j = 0; j < data[i].length; j++) { // iterate over the columns of the data
        // normalize data between 0 and 1, map to a color gradient between red and green, and draw a rectangle for each cell
        float value = (float) data[i][j] / maxValue(); // calculate the normalized value of the cell (makes the data points be between 0 and 1 to make for easier colour gradient stuff)(divided my returned value in maxValue() method
        
        //interpolate between red and green based on the normalized value(basically just creates a color gradient) 
        //(LEFT color =lower value, RIGHT color = higher value) 
        int colourValue = lerpColor(color(#d2fbd4), color(#123f5a), value); 
        
        fill(colourValue); // set the fill color to the interpolated color
        rect(x + j * cellSize, y + i * cellSize, cellSize, cellSize); // draw the cell
      }
    }

    // draw column labels (months)
    textAlign(CENTER, TOP); // set text alignment to center horizontally and top vertically
    fill(100);
    textSize(14); // set the font size to 14
    textFont(font); // set the font for the labels
    for (int i = 0; i < monthLabels.length; i++) { // iterate over the month labels
      text(monthLabels[i], x + i * cellSize + cellSize/2, y - 20); // draw the label centered above each column
    }

    // draw row labels (cities/towns)
    textAlign(RIGHT, CENTER); // set text alignment to right horizontally and center vertically
    textSize(14); // set the font size to 14
    textFont(font); // set the font for the labels
    for (int i = 0; i < cityLabels.length; i++) { // iterate over the city/town labels
      text(cityLabels[i], x - 10, y + i * cellSize + cellSize/2); // draw the label to the left of each row
    }
  }
  float maxValue() { // helper method to find the maximum value in the data
    float maxVal = data[0][0]; // assume the first value is the maximum
    for (int i = 0; i < data.length; i++) { // iterate over the rows of the data
      for (int j = 0; j < data[i].length; j++) { // iterate over the columns of the data
        if (data[i][j] > maxVal) { // if the current value is greater than the current maximum
          maxVal = data[i][j]; // update the maximum value
        }
      }
    }
    return maxVal; // return the maximum value
  }

  public void title(int year, PFont font) {
    textAlign(CENTER);
    textFont(font);
    text("Heatmap for " + year, x +225, y - 50);
  }
}


/* CODE TO TEST PROGRAM IN MAIN    
PFont fontSmall;
void setup() {
  size(800, 600);

  // create some random data for the heatmap
  int[][] data = new int[5][12];
  for (int i = 0; i < data.length; i++) {
    for (int j = 0; j < data[i].length; j++) {
      data[i][j] = (int) random(100);
    }
  }

  // create a PFont object to use for the labels
  PFont font = createFont("Arial", 14);

  // create a heatmap object with custom row labels
  int[][] dataPoints = { {205, 200, 300, 100, 150, 250, 350, 450, 500, 400, 300, 200},
                         {150, 300, 250, 100, 200, 150, 350, 400, 450, 400, 350, 250},
                         {100, 150, 200, 250, 300, 350, 400, 450, 500, 450, 400, 350},
                         {50, 100, 150, 200, 250, 300, 350, 400, 450, 400, 350, 300}, 
                         {100, 140, 200, 221, 300, 350, 400, 450, 500, 450, 400, 350} };

  String[] cityLabels = {"Dublin", "Las Vegas", "Tokyo", "Paris", "Rio de Janeiro"};
  heatmap hm = new heatmap(dataPoints, width/4, height/4, 40, font, cityLabels);

  // draw the heatmap
  hm.draw();
  
  // add a title to the heatmap
  hm.title(2023, font);
}

void draw() {
  // empty draw loop
}
 */
