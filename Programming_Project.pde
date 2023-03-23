ArrayList<Data> dataList;
PFont font;
PFont fontSmall;
String[] lines;
String answer = "";


//initialises searchbar widget array
ArrayList<SearchBar> searchBars;

BarChart chart;

void setup() {
  
  
  size(1280, 720);
  font = createFont("Calibri", 24);
  fontSmall = createFont("Calibri", 12);
  
  //Creates array of strings of the file data
  lines = loadStrings("flights2k(1).csv");
  
  dataList = new ArrayList<Data>();
  
  for (int i = 0; i < lines.length; i++) 
  {
    dataList.add(new Data(lines[i], font));
    println(dataList.get(i).getReqData("ORIGIN_CITY_NAME"));
  }
  
  //initialises searchbar widget array
  searchBars = new ArrayList<SearchBar>();
  
  
  //example searchbar for all test data
  searchBars.add(new SearchBar(10,40,400,40,font));
  

  
}

void draw() 
{
  background(20);
  
  for (int i = 1; i < lines.length; i++) 
  { 
    
    fill(200);
    textFont(font);
    
    //Prints to screen, selected from input from user
    answer = searchBars.get(0).returnAnswer();
    text(dataList.get(i).getReqData(answer),10,22*i+80);
  }
  
  //draws and updates searchbar contents
  for (SearchBar b : searchBars) 
  {
    b.update();
  }
  // create bar chart
  // center bar chart in middle bottom of screen


  
  chart = new BarChart(50, height-50, width+200, 400, fontSmall,20);
  for (String line : lines) 
  {
    chart.addData(line);
  }
  chart.showTop();


}


void mousePressed()
{

  //allows searchbar to detect mouseInput
  for (SearchBar b : searchBars) 
  {
     b.mouseIn();
  }
}

void keyPressed()
{
  //allows searchbar to detect keys
  for (SearchBar b : searchBars) 
  {
     b.keyIn();
  }
}
