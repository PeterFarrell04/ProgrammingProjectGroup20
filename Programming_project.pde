final int NULL=0;
final int BUTTON1=1;
final int BUTTON2=2;
final int BUTTON3=3;


ArrayList<Data> dataList;
PFont font;
PFont fontSmall;
String[] lines;
String answer = "";
Query query;
int queryResultCount = -1;
SearchBar querySearchBar;


//initialises searchbar widget array
ArrayList<SearchBar> searchBars;
ArrayList<DropDown> dropList;
ArrayList<Screen> screens;
int selectedScreen;

BarChart chart;

void setup() {
  
  
  size(1280, 720);
  font = createFont("Calibri", 24);
  fontSmall = createFont("Calibri", 12);
  querySearchBar = new SearchBar(870,80,400,40,font);
  //Creates array of strings of the file data
  lines = loadStrings("flights2k(1).csv");
  
  dataList = new ArrayList<Data>();
  
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
  int dListY = 50;
  dropList.add( new DropDown(dListX,dListY,"Flight Date",font,100));
  dropList.add( new DropDown(dListX,dListY+50,"Origin",font,100));
  dropList.add( new DropDown(dListX,dListY+100,"Destination",font,100));
  dropList.add( new DropDown(dListX,dListY+150,"Flight Number",font,100));
  dropList.add( new DropDown(dListX,dListY+200,"Departure Time",font,100));
  dropList.add( new DropDown(dListX,dListY+250,"Arrival Time",font,100));
  dropList.add( new DropDown(dListX,dListY+300,"Cancelled?",font,100));
  
  //testing queries
  Query q = new Query("MKT_CARRIER_FL_NUM", 2, "CRS_DEP_TIME", 800);
  ArrayList<Data> result = q.run(); //<>//
  for (int i = 0; i < result.size(); i++)
  {
    println(result.get(i).getStrVal("DEST_STATE_ABR"));
  }
  println(q.count);
  
  
  Screen screen1, screen2, screen3;
  Widget widget1, widget2, widget3;

  widget1 = new Widget(5, 678, 300, 40, "Raw Information", color(128, 128, 128), font, BUTTON1);
  widget2 = new Widget(310, 678, 300, 40, "Bar-Chart", color(128, 128, 128), font, BUTTON2);
  widget3 = new Widget(615, 678, 300, 40, "Pie-Chart", color(128, 128, 128), font, BUTTON3);

  screen1 = new Screen(0);
  screen1.addWidget(widget1);
  screen1.addWidget(widget2);
  screen1.addWidget(widget3);

  screen2 = new Screen(1);
  screen2.addWidget(widget1);
  screen2.addWidget(widget2);
  screen2.addWidget(widget3);

  screen3 = new Screen(2);
  screen3.addWidget(widget1);
  screen3.addWidget(widget2);
  screen3.addWidget(widget3);

  screens = new ArrayList<Screen>();
  screens.add(screen1);
  screens.add(screen2);
  screens.add(screen3);

}

void draw() 
{
  background(20);
  
  
  screens.get(selectedScreen).draw();

  if (selectedScreen == 0) {
    for (int i = 0; i < dataList.size(); i++) {
      if (20*i+80 < 670) {
        text(dataList.get(i).getData(), 10, 20*i+80);
        fill(255);
      }
    }
  } else if (selectedScreen == 2) {
    //float[] data = {20, 30, 10, 40};
    //String[] labels = {"Slice 1", "Slice 2", "Slice 3", "Slice 4"};
    //PieChart pieChart = new PieChart(data, labels, width/2, height/2, 200);
    //pieChart.display();
  } else if (selectedScreen == 1) {
    // create and show the bar chart
    chart = new BarChart(50, height-100, width+200, 400, fontSmall, 20);
    for (String line : lines) {
      chart.addData(line);
    }
    chart.showTop();
  }
  
  
   // query search bar
  //textSize(30);
  textFont(font);
  text("Query [dataColumn;searchVal] : ", 870, 40);
  text("Count: ", 870, 130);
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
    //d.update();
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
