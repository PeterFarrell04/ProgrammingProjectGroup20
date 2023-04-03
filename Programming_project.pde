final int NULL=0;
final int BUTTON1=1;
final int BUTTON2=2;
final int BUTTON3=3;
final int BUTTON4=4;


ArrayList<Data> dataList;
PFont font;
PFont fontSmall;
String[] lines;
String answer = "";
Query query;
int queryResultCount = -1;
SearchBar querySearchBar;
heatmap heatMap;

//initialises searchbar widget array
ArrayList<SearchBar> searchBars;
ArrayList<DropDown> dropList;
ArrayList<Screen> screens;
int selectedScreen;

BarChart chart;

void setup() {
  
  fullScreen();
  font = createFont("Calibri", 24);
  fontSmall = createFont("Calibri", 12);
  querySearchBar = new SearchBar(900,80,400,40,font);
  //Creates array of strings of the file data
  lines = loadStrings("flights2k(1).csv");
  
  dataList = new ArrayList<Data>();

   // create some random data for the heatmap
  int[][] data = new int[5][12];
  for (int i = 0; i < data.length; i++) {
    for (int j = 0; j < data[i].length; j++) {
      data[i][j] = (int) random(100);
    }
  }

  // create a PFont object to use for the labels
  PFont heatmapfont = createFont("Arial", 14);

  // create a heatmap object with custom row labels
  int[][] dataPoints = { {205, 200, 300, 100, 150, 250, 350, 450, 500, 400, 300, 200},
                         {150, 300, 250, 100, 200, 150, 350, 400, 450, 400, 350, 250},
                         {100, 150, 200, 250, 300, 350, 400, 450, 500, 450, 400, 350},
                         {50, 100, 150, 200, 250, 300, 350, 400, 450, 400, 350, 300}, 
                         {100, 140, 200, 221, 300, 350, 400, 450, 500, 450, 400, 350} };

  String[] cityLabels = {"Dublin", "Las Vegas", "Tokyo", "Paris", "Rio de Janeiro"};
  heatMap = new heatmap(dataPoints, width/4, height/4, 40, heatmapfont, cityLabels);
  
  // add a title to the heatmap
  heatMap.title(2023, heatmapfont);
  
  for (int i = 1; i < lines.length; i++) 
  {
    dataList.add(new Data(10, 10, lines[i], font));
    //println(dataList.get(i).getStrVal("ORIGIN_CITY_NAME"));
  }
  
  //initialises searchbar widget array
  searchBars = new ArrayList<SearchBar>();
  dropList = new ArrayList<DropDown>();
  
  
  //example searchbar for all test data
  searchBars.add(new SearchBar(10,40,400,40,font));
  
  
  
  //query search bar
  
  searchBars.add(querySearchBar);
  
  
  //creation of dropdown queries
  int dListX = 960;
  int dListY = 200;
  dropList.add( new DropDown(dListX,dListY,"Flight Date",font,60));
  dropList.add( new DropDown(dListX,dListY+50,"Origin",font,60));
  dropList.add( new DropDown(dListX,dListY+100,"Destination",font,60));
  dropList.add( new DropDown(dListX,dListY+150,"Flight Number",font,60));
  dropList.add( new DropDown(dListX,dListY+200,"Departure Time",font,60));
  dropList.add( new DropDown(dListX,dListY+250,"Arrival Time",font,60));
  dropList.add( new DropDown(dListX,dListY+300,"Cancelled?",font,60));
  
  //testing queries
  Query q = new Query("ORIGIN", "FLL");
  ArrayList<Data> result = q.run(); //<>//
  for (int i = 0; i < result.size(); i++)
  {
    println(result.get(i).getStrVal("DEST_STATE_ABR"));
  }
  println(q.count);
  
  
  Screen screen1, screen2, screen3, screen4;
  Widget widget1, widget2, widget3, widget4;

  widget1 = new Widget(5, 700, 300, 40, "Raw Information", color(128, 128, 128), font, BUTTON1);
  widget2 = new Widget(310, 700, 300, 40, "Bar-Chart", color(128, 128, 128), font, BUTTON2);
  widget3 = new Widget(615, 700, 300, 40, "Pie-Chart", color(128, 128, 128), font, BUTTON3);
  widget4 = new Widget(920, 700, 300, 40, "heatmap" , color(128, 128, 128), font, BUTTON4);

  // passing in background colour to screen
  screen1 = new Screen(20);
  screen1.addWidget(widget1);
  screen1.addWidget(widget2);
  screen1.addWidget(widget3);
  screen1.addWidget(widget4);

  screen2 = new Screen(20);
  screen2.addWidget(widget1);
  screen2.addWidget(widget2);
  screen2.addWidget(widget3);
  screen2.addWidget(widget4);

  screen3 = new Screen(20);
  screen3.addWidget(widget1);
  screen3.addWidget(widget2);
  screen3.addWidget(widget3);
  screen3.addWidget(widget4);
  
  screen4 = new Screen(20);
  screen4.addWidget(widget1);
  screen4.addWidget(widget2);
  screen4.addWidget(widget3);
  screen4.addWidget(widget4);

  screens = new ArrayList<Screen>();
  screens.add(screen1);
  screens.add(screen2);
  screens.add(screen3);
  screens.add(screen4);

}

void draw() 
{
  screens.get(selectedScreen).draw();

  switch(selectedScreen)
  {
  case 0:
    strokeWeight(1);
    for (int i = 0; i < dataList.size(); i++) 
    {
      if (20*i+80 < 670) 
      {
        fill(255);
        text(dataList.get(i).getData(), 10, 20*i+80);
      }
    }
    break;
    
  case 1:
    // create and show the bar chart
    strokeWeight(1);
    chart = new BarChart(50, height-100, width+200, 400, fontSmall, 20);
    for (String line : lines) {
      chart.addData(line);
    }
    chart.showTop();
    break;
    
   case 2:
    float[] data = {20, 30, 10, 40};
    String[] labels = {"Slice 1", "Slice 2", "Slice 3", "Slice 4"};
    PieChart pieChart = new PieChart(data, labels, width/4, height/2, 400);
    pieChart.display();
    strokeWeight(1);
    fill(255);
    break;
    
  case 3:
    strokeWeight(1);
    heatMap.draw();
    fill(255);
    break;
  }
  
  
   // query search bar
  //textSize(30);
  textFont(font);
  text("Query [dataColumn;searchVal] : ", 900, 40);
  text("Count: ", 900, 130);
  text(queryResultCount, 970, 130);
  if (querySearchBar.returnAnswer() != "")
  {
    String[] queryStrArr = querySearchBar.returnAnswer().split(";");
    if (queryStrArr.length == 2)
    {
      try
      {
        int test = Integer.valueOf(queryStrArr[1]);
        query = new Query(queryStrArr[0], test);
      }
      catch (NumberFormatException e)
      {
        query = new Query(queryStrArr[0], queryStrArr[1]);
      }
      query.run();
      queryResultCount = query.count;
    }
  }
  textAlign(LEFT);
  
  for (int i = 1; i < lines.length; i++) 
  {
    
    fill(200);
    textFont(font);
    
    //Prints to screen, selected from input from user
    answer = searchBars.get(0).returnAnswer();
    //text(dataList.get(i).getReqData(answer),10,22*i+80);
  }
  
   // create bar chart only in screen 2
  if (selectedScreen == 1) {
    chart = new BarChart(50, height-100, width+200, 400, fontSmall, 20);
    for (String line : lines) {
      chart.addData(line);
    }
    chart.showTop();
  }
 
  
  //draws and updates searchbar contents
  for (SearchBar b : searchBars) 
  {
    b.update();
  }
  for (DropDown d : dropList) 
  {
    d.update();
  }

}



void mousePressed()
{

  int event = screens.get(selectedScreen).getEvent(mouseX, mouseY);
  switch(event) {
  case BUTTON1:
    selectedScreen = 0;
    break;
  case BUTTON2:
    selectedScreen = 1;
    break;
  case BUTTON3:
    selectedScreen = 2;
    break;
   case BUTTON4:
    selectedScreen = 3;
    break;
  }
  //allows searchbar to detect mouseInput
  for (SearchBar b : searchBars) 
  {
     b.mouseIn();
  }
  for (DropDown d : dropList) 
  {
     d.mouseIn();
  }
}

void keyPressed()
{
  //allows searchbar to detect keys
  for (SearchBar b : searchBars) 
  {
     b.keyIn();
  }
  for (DropDown d : dropList) 
  {
     d.keyIn();
  }
}

void mouseMoved() {
  int event;
  Screen screen = screens.get(selectedScreen);

  for (Widget widget : screen.widgets) {
    event = widget.getEvent(mouseX, mouseY);
    if (event!= NULL) {
      widget.strokeColour = color(255);
    } else {
      widget.strokeColour = color(0);
    }
  }
}
