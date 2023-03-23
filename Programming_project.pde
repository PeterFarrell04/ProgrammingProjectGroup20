ArrayList<Data> dataList;
PFont font;
String[] lines;

void setup() {
  size(800, 800);
  font = loadFont("Calibri-9.vlw");

  // load data
  lines = loadStrings("flights2k(1).csv");
}

void draw() {
  background(20);

  //Color of text
  fill(200);
  textFont(font);

  // center bar chart in middle bottom of screen
  float chartWidth = 500;
  float chartHeight = 400;
  float chartX = width/2 - chartWidth/2.5;
  float chartY = height - chartHeight + 350;

  // create bar chart
  BarChart chart = new BarChart(chartX, chartY, chartWidth, chartHeight, font);
  for (String line : lines) {
    chart.addData(line);
  }
  chart.showTop(10);

  //Creates array of strings of the file data
  String[] lines = loadStrings("flights2k(1).csv");
  if (lines != null) { // Check if lines array is not null
    //Creates Data objects and stores it into an ArrayList using a for loop
    dataList = new ArrayList<Data>(); // Initialize the dataList ArrayList
    for (int i = 0; i < lines.length; i++) {
      dataList.add(new Data(width/2, height/2, lines[i], font));

      //Prints to screen
      text(dataList.get(i).getData(), 10, 10 +i*18);
    }
  } else {
    println("Error loading file"); // Print an error message if lines is null
  }
}