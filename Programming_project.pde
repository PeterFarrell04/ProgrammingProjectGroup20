ArrayList<Data> dataList; //<>//
ArrayList<Data> currentDataList;
PFont font;
PFont fontSmall;
String[] lines;
String pageTitle = "Placeholder Title";
Query query;
int queryResultCount = -1;
scrollBar scroll;
boolean scrolling = false;

Screen screen1, screen2, screen3, screen4;
Widget widget1, widget2, widget3, widget4, widget5, widget6;

//initialises searchbar widget array
ArrayList<DropDown> dropList;
ArrayList<Screen> screens;
int selectedScreen;
float textY = 80;



BarChart chart;

int coarseAnswer = -1;
String fineAnswer;
String datafile = ("flights2k(1).csv");

//Heatmap Stuff
Button heatmapButton1, heatmapButton2, heatmapButton3, heatmapButton4, heatmapButton5, heatmapButton6, heatmapButton7, heatmapButton8, heatmapButton9, heatmapButton10, heatmapButton11;
Heatmap hm;
HeatmapData dataGenerator;
HashMap<Integer, String> columnMap = new HashMap<Integer, String>(); // declare a HashMap to store column names and indices
int dataColumn = 0;
int heatmapYpos;
int dataLength;
int DATA_LENGTH;
int startIndex;
int endIndex;
int startCol;
int endCol;
int heatmapOverallSize;
int maxVal;
int initialHeatmapXpos;
int heatmapXpos;
int[][] heatMapArray;
boolean generateHeatmap;
int BUTTON_SPACING;
boolean onHeatmapScreen;



void setup() {

  //fullScreen();
  size(1280, 720);
  font = createFont("Calibri", 24);
  fontSmall = createFont("Calibri", 12);
  //Creates array of strings of the file data //<>//
  lines = loadStrings(datafile);

  dataList = new ArrayList<Data>();
  currentDataList = dataList;



  scroll = new scrollBar(15, 600, 150, 875, 65);

  for (int i = 1; i < lines.length; i++)
  {
    dataList.add(new Data(10, 10, lines[i], font));
    //println(dataList.get(i).getStrVal("ORIGIN_CITY_NAME"));
  }

  //initialises dropdown widget array
  dropList = new ArrayList<DropDown>();




  //creation of dropdown queries
  int dListX = 980; //<>//
  int dListY = 200;
  dropList.add( new DropDown(dListX, dListY, "Flight Date", font, 60, 0));
  dropList.add( new DropDown(dListX, dListY+50, "Origin", font, 60, 3));
  dropList.add( new DropDown(dListX, dListY+100, "Destination", font, 60, 8));
  dropList.add( new DropDown(dListX, dListY+150, "Flight Number", font, 60, 2));
  dropList.add( new DropDown(dListX, dListY+200, "Departure Time", font, 60, 13));
  dropList.add( new DropDown(dListX, dListY+250, "Arrival Time", font, 60, 15));

  widget1 = new Widget(5, 670, 300, 40, "Raw Information", color(128, 128, 128), font, BUTTON1);
  widget2 = new Widget(310, 670, 300, 40, "Bar-Chart", color(128, 128, 128), font, BUTTON2);
  widget3 = new Widget(615, 670, 300, 40, "Pie-Chart", color(128, 128, 128), font, BUTTON3);
  widget4 = new Widget(920, 670, 300, 40, "Heatmap", color(128, 128, 128), font, BUTTON4);
  widget5 = new Widget(970, 120, 300, 40, "Reset Search", color(200, 0, 0), font, RESETSEARCH);
  widget6 = new Widget(877, 77, 11, 50, "", color(175), font, SCROLLBAR);

  // passing in background colour to screen
  screen1 = new Screen(20);
  screen1.addWidget(widget1);
  screen1.addWidget(widget2);
  screen1.addWidget(widget3);
  screen1.addWidget(widget4);
  screen1.addWidget(widget5);
  screen1.addWidget(widget6);

  screen2 = new Screen(20);
  screen2.addWidget(widget1);
  screen2.addWidget(widget2);
  screen2.addWidget(widget3);
  screen2.addWidget(widget4);
  screen2.addWidget(widget5);

  screen3 = new Screen(20);
  screen3.addWidget(widget1);
  screen3.addWidget(widget2);
  screen3.addWidget(widget3);
  screen3.addWidget(widget4);
  screen3.addWidget(widget5);

  screen4 = new Screen(20);
  screen4.addWidget(widget1);
  screen4.addWidget(widget2);
  screen4.addWidget(widget3);
  screen4.addWidget(widget4);
  //screen4.addWidget(widget5);
  screens = new ArrayList<Screen>();
  screens.add(screen1);
  screens.add(screen2);
  screens.add(screen3);
  screens.add(screen4);

  //Heatmap
  //println(columnMap);
  BUTTON_SPACING = 10;
  heatmapButton1 = new Button(BUTTON_SPACING, 0, 100, 50, "Carrier Flight Nums", 2);
  heatmapButton2 = new Button(BUTTON_SPACING *12, 0, 100, 50, "Origin Airports", 3);
  heatmapButton3 = new Button(BUTTON_SPACING *23, 0, 100, 50, "Origin Cities", 4);
  heatmapButton4 = new Button(BUTTON_SPACING *34, 0, 100, 50, "Origin States", 5);
  heatmapButton5 = new Button(BUTTON_SPACING *45, 0, 100, 50, "Origin WACs", 6);
  heatmapButton6 = new Button(BUTTON_SPACING *56, 0, 100, 50, "Destinations", 7);
  heatmapButton7 = new Button(BUTTON_SPACING *67, 0, 100, 50, "Destination Cities", 8);
  heatmapButton8 = new Button(BUTTON_SPACING *78, 0, 100, 50, "Destination States", 9);
  heatmapButton9 = new Button(BUTTON_SPACING *89, 0, 100, 50, "Destination WACs", 10);
  heatmapButton10 = new Button(BUTTON_SPACING *100, 0, 100, 50, "Departure Time", 11);
  heatmapButton11 = new Button(BUTTON_SPACING *111, 0, 100, 50, "Distance", 17);

  //CHANGE THIS TO CHANGE THE ENTIRE HEATMAP
  dataColumn = 1;   //Values that work:  2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 17
  // 2=MKT_CARRIER_FL_NUM, 3=ORIGIN, 4=ORIGIN_CITY_NAME, 5=ORIGIN_STATE_ABR, 6=ORIGIN_WAC, 7=DEST, 8=DEST_CITY_NAME, 9=DEST_STATE_ABR, 10=DEST_WAC,
  //11=CRS_DEP_TIME, 14=ARR_TIME, 17=DISTANCE
  generateHeatmap = false;
  onHeatmapScreen = false;
}

void draw()
{
  pageTitle = "";
  screens.get(selectedScreen).draw();
  fill(180);
  stroke(0);
  rect(-10, -10, 1300, 70);
  fill(0);



  switch(selectedScreen)
  {
  case 0:
    onHeatmapScreen = false;
    pageTitle += "Raw Information of Flights";
    strokeWeight(1);
    textSize(20);
    if (dataList.size() == 0)
    {
      fill(255);
      text("There are no valid flights with your queries! (Reset Search)", 10, 100);
    }
    for (int i = 0; i < dataList.size(); i++)
    {

      fill(255);
      String output = "";
      switch(coarseAnswer)
      {
      case 0:
        output+=dataList.get(i).getStrVal("FL_DATE");
        break;
      case 3:
        output+=dataList.get(i).getStrVal("ORIGIN_CITY_NAME");
        break;
      case 8:
        output+=dataList.get(i).getStrVal("DEST_CITY_NAME");
        break;
      case 2:
        output+=dataList.get(i).getIntVal("MKT_CARRIER_FL_NUM");
        break;
      case 13:
        output+="Expected Time: ";
        output+=dataList.get(i).getIntVal("CRS_DEP_TIME");
        output+= "              ";
        output+="Actual Time: ";
        output+=dataList.get(i).getIntVal("DEP_TIME");
        break;
      case 15:
        output+="Expected Time: ";
        output+=dataList.get(i).getIntVal("CRS_ARR_TIME");
        output+= "              ";
        output+="Actual Time: ";
        output+=dataList.get(i).getIntVal("ARR_TIME");
        break;
      default:
        output+=dataList.get(i).getData();
        break;
      }
      if (20*i+textY>0 && 20*i+textY <740)
      {
        text(output, 10, (float)(20*i+textY));
      }
    }
    fill(0);
    rect(870, 60, 700, 605);
    fill(180);
    rect(-10, -10, 1300, 70);
    fill(0);
    rect(0, 665, 1300, 300);
    Screen screen = screens.get(selectedScreen);
    scroll.draw();
    for (Widget widget : screen.widgets)
    {
      widget.draw();
    }
    break;

  case 1:
    onHeatmapScreen = false;
    pageTitle += "Bar Chart of Flight Information";
    // create and show the bar chart
    strokeWeight(1);
    chart = new BarChart(50, height-100, width+200, 400, fontSmall, 20);
    fill(255);
    if (dataList.size() > 0)
    {
      for (int i = 0; i < dataList.size(); i++)
      {
        chart.addData(dataList.get(i));
      }
      chart.showTop();
    }else
    {
      text("No data matches your search! (Reset Search)", 250, 720/2);
    }
    break;

  case 2:
    onHeatmapScreen = false;
    pageTitle += "Pie Chart of Flight Information";
    PieChart pieChart = new PieChart(width/4, height/2, 400);
    pieChart.display();
    strokeWeight(1);
    fill(255);
    break;

  case 3:
    onHeatmapScreen = true;
    //pageTitle += "Heatmap of Flight Information";
    strokeWeight(1);
    heatmapButton1.display();
    heatmapButton2.display();
    heatmapButton3.display();
    heatmapButton4.display();
    heatmapButton5.display();
    heatmapButton6.display();
    heatmapButton7.display();
    heatmapButton8.display();
    heatmapButton9.display();
    heatmapButton10.display();
    heatmapButton11.display();

    if (generateHeatmap == true) {
      //println(dataColumn);
      PFont font = createFont("Arial", 10);
      HeatmapData dataGenerator = new HeatmapData(); //Creates new object that will generate the data needed for the Heatmap class
      //Gets the first line of the CSV file to extract column names
      String[] headers = lines[0].split(",(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)", -2);
      //Loops through the column names and add them to the HashMap with their index as the value
      for (int i = 0; i < headers.length; i++) {
        columnMap.put(i, headers[i].trim());
      }

      //println(columnMap);    //Print the HashMap to verify that the column names and indices are correctly mapped
      String title = columnMap.get(dataColumn); //This should be whatever the user inputted.
      //println(title);
      String[] ColumnData = dataGenerator.getUniqueValues(dataColumn);
      //printArray(originWACs);
      int[] frequency = dataGenerator.countValuesInCSV(ColumnData, dataColumn);
      // sort the arrays
      dataGenerator.sortArrays(ColumnData, frequency);
      int heatmapYpos = height/4; //Controls height of heatmap
      int dataLength = ColumnData.length; //Length of data inputted into heatmap (changes in the program)
      int DATA_LENGTH = ColumnData.length;//Constant length of data inputted into heatmap
      int startIndex = 0;  //Start index
      int endIndex = 20;   //End index
      int startCol = 0;    //Start column (Corresponds to the months)
      int endCol = 6;      //End column   (Corresponds to the months)
      int heatmapOverallSize = endIndex - startIndex; // Size of array we need to create
      int maxVal = 0;      //MaxValue for all of the heatmaps (used to create the colour gradient (changes further down))
      int initialHeatmapXpos = 50; // initialize the initial X position
      int heatmapXpos = initialHeatmapXpos; // use this variable to keep track of the current X position
      int[][] heatMapArray = dataGenerator.create2dArray(ColumnData, 6, dataColumn); //Creates 2D array which will be resized
      maxVal = heatMapArray[0][0]; // initialize maxVal to the first value in the array
      for (int j = 1; j < heatMapArray[0].length; j++) { // loop through the columns in the first row
        if (heatMapArray[0][j] > maxVal) { // if the current value is greater than maxVal
          maxVal = heatMapArray[0][j]; // set maxVal to the current value
        }
      }
      //println("MAX VALUE: " + maxVal);

      //Makes data more visible if the squares have little data
      for (int i = 0; i < heatMapArray.length; i++) {
        for (int j = 0; j < heatMapArray[i].length; j++) {
          if (heatMapArray[i][j] < 2) {
            heatMapArray[i][j] += maxVal/(maxVal/4) ; //adds smaller amounts of datat to nodes less than 2
          } else if (heatMapArray[i][j] > 2) {
            heatMapArray[i][j] += maxVal/(maxVal/6); //adds larger data to data nodes greater than 2
          }
        }
      }

      //Creates the heatmap
      if (dataLength >= 20) {
        while (dataLength > 0) { //Once dataLength has reached zero we have created enough heatmaps and we end the loop
          //Resize array
          int[][] resizedArrayInt = dataGenerator.resize2DArray(heatMapArray, startIndex, endIndex, startCol, endCol);
          String[] resizedArrayString = dataGenerator.resize1DArray(ColumnData, heatmapOverallSize, startIndex, endIndex);
          boolean keepLastTwo = true;
          if (dataColumn == 4 || dataColumn == 5 || dataColumn == 8) {
            resizedArrayString = dataGenerator.textParser(resizedArrayString, keepLastTwo);
          }
          //TERMINAL DEBUG HELP CODE
          //println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
          //println("Data length: " + dataLength);
          //println("heatmapYpos: " + heatmapYpos);
          //println("DATA_LENGTH: " + DATA_LENGTH);
          //println("startIndex: " + startIndex);
          //println("endIndex: " + endIndex);
          //println("startCol: " + startCol);
          //println("endCol: " + endCol);
          //println("heatmapOverallSize: " + heatmapOverallSize);
          //println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
          //for (int i = 0; i < resizedArrayInt.length; i++) {
          //  for (int j = 0; j < resizedArrayInt[i].length; j++) {
          //    System.out.print(resizedArrayInt[i][j] + " ");
          //  }
          //  System.out.println();
          //}

          //Heatmap Generation
          Heatmap hm = new Heatmap(resizedArrayInt, heatmapXpos, heatmapYpos, 20, font, resizedArrayString, maxVal); //Initialises new heatmap

          hm.title(title, 2022, font); //add a title to the heatmap

          //Incrementing the parameters for other heatmaps
          startIndex += 20; //Incrementing the startIndex
          endIndex += 20;
          if (endIndex > DATA_LENGTH) {
            endIndex = DATA_LENGTH -1;  //Error handling if we go over the array size we re-initialise our end index to be the DATA_LENGTH (the end of the array)
          } //<>//
          heatmapOverallSize = endIndex - startIndex; //Changes the amount of rows needed for new heatmap //<>//
          heatmapXpos += endCol *35; // increment the current X position //<>//
          dataLength -=20; //Once this reaches zero or below zero we end loop //<>//
          hm.draw(); //Draws heatmap to screen
        }
      }
    }

    break; //<>//
  }
 

  ///Dynamic Title

  if (!dropList.get(1).child.output.equals(""))
  {
    pageTitle += " from " + dropList.get(1).child.output;
  }
  if (!dropList.get(2).child.output.equals(""))
  {
    pageTitle += " to " + dropList.get(2).child.output;
  }
  if (!dropList.get(3).child.output.equals(""))
  {
    pageTitle += " with flight no: " + dropList.get(3).child.output;
  }
  if (!dropList.get(4).child.output.equals(""))
  {
    pageTitle += ", with dep time: " + dropList.get(4).child.output;
  }
  if (!dropList.get(5).child.output.equals(""))
  {
    pageTitle += ", with arrival time: " + dropList.get(5).child.output;
  }
  if (!dropList.get(0).child.output.equals(""))
  {
    pageTitle += ", flown on: " + dropList.get(0).child.output;
  }
  textSize(24);
  textFont(font);
  fill(0);
  textAlign(LEFT);
  if (selectedScreen != 3)
  {
    text(pageTitle, 10, 35);
  }

  textAlign(LEFT);

  for (DropDown d : dropList)
  {
    if (!onHeatmapScreen) {
      d.update();
    }
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
  case RESETSEARCH:
    ResetCoarseSearch();
    ResetFineSearch();
    coarseAnswer = -1;
    fineAnswer = "";
    break;
  }
  for (DropDown d : dropList)
  {  
    d.mouseIn();
  }
}

void keyPressed()
{
  for (DropDown d : dropList)
  {
    d.keyIn();
  }
}

void mouseMoved() {
  int event;
  Screen screen = screens.get(selectedScreen);

  for (Widget widget : screen.widgets) {
    event = widget.getEvent(mouseX, mouseY, widget);
    if (event!= NULL) {
      widget.strokeColour = color(255);
    } else {
      widget.strokeColour = color(0);
    }
  }

  //Heatmap
  heatmapButton1.update();
  heatmapButton2.update();
  heatmapButton3.update();
  heatmapButton4.update();
  heatmapButton5.update();
  heatmapButton6.update();
  heatmapButton7.update();
  heatmapButton8.update();
  heatmapButton9.update();
  heatmapButton10.update();
  heatmapButton11.update();
}

void mouseDragged()
{
  int event;
  Screen screen = screens.get(selectedScreen);

  for (Widget widget : screen.widgets) {
    event = widget.getEvent(mouseX, mouseY, widget);
    if ((event!= NULL && event == SCROLLBAR)||(scrolling && event == SCROLLBAR)) {
      scrolling = true;
      widget.y=mouseY-(widget.height/2);
      if (widget.y<=77)
        widget.y = 77;
      if (widget.y>=scroll.boxHeight)
        widget.y = scroll.boxHeight+2;
      // to do; make it so that the amount the text is displaced on the y axis changes dynamically
      //  to the full length of the scroll bar; bigger the number of data, more y is displaced along bar

      //brute force math
      if (datafile == "flights_full (1).csv")
        textY =((1653710-(widget.y*21475.73)));
      else if (datafile == "flights100k(1).csv")
        textY =((293410-(widget.y*3809.5)));
      else if (datafile == "flights10k(1).csv")
        textY =((29410-(widget.y*380.95)));
      else if (datafile == "flights2k(1).csv")
        textY =((5946-(widget.y*76.19)));
    }
  }
}

void mouseReleased()
{
  scrolling = false;
}
void ResetCoarseSearch()
{
  for (DropDown d : dropList)
  {
    d.filterChild.link = false;
  }
}
void ResetFineSearch()
{
  dataList = currentDataList;
  for (DropDown d : dropList)
  {
    d.child.output = "";
    d.child.input = "";
    d.lastOutput = "";
  }
}



//Heatmap uses this
void mouseClicked() {
  int value = heatmapButton1.clicked();
  if (value > 0) {
    dataColumn = value;
    generateHeatmap = true;
  }
  value = heatmapButton2.clicked();
  if (value > 0) {
    dataColumn = value;
    generateHeatmap = true;
  }
  value = heatmapButton3.clicked();
  if (value > 0) {
    dataColumn = value;
    generateHeatmap = true;
  }
  value = heatmapButton4.clicked();
  if (value > 0) {
    dataColumn = value;
    generateHeatmap = true;
  }
  value = heatmapButton5.clicked();
  if (value > 0) {
    dataColumn = value;
    generateHeatmap = true;
  }
  value = heatmapButton5.clicked();
  if (value > 0) {
    dataColumn = value;
    generateHeatmap = true;
  }
  value = heatmapButton6.clicked();
  if (value > 0) {
    dataColumn = value;
    generateHeatmap = true;
  }
  value = heatmapButton7.clicked();
  if (value > 0) {
    dataColumn = value;
    generateHeatmap = true;
  }
  value = heatmapButton8.clicked();
  if (value > 0) {
    dataColumn = value;
    generateHeatmap = true;
  }
  value = heatmapButton9.clicked();
  if (value > 0) {
    dataColumn = value;
    generateHeatmap = true;
  }
  value = heatmapButton10.clicked();
  if (value > 0) {
    dataColumn = value;
    generateHeatmap = true;
  }
  value = heatmapButton11.clicked();
  if (value > 0) {
    dataColumn = value;
    generateHeatmap = true;
  }
  value = heatmapButton9.clicked();
}
