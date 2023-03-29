ArrayList<Data> dataList;
PFont font;
PFont fontSmall;
String[] lines;
String answer = "";
Query query;
int queryResultCount = -1;
SearchBar querySearchBar = new SearchBar(870,80,400,40,font);



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
  
  for (int i = 1; i < lines.length; i++) 
  {
    dataList.add(new Data(10, 10, lines[i], font));
    //println(dataList.get(i).getStrVal("ORIGIN_CITY_NAME"));
  }
  
  //initialises searchbar widget array
  searchBars = new ArrayList<SearchBar>();
  
  
  //bar chart search bar
  searchBars.add(new SearchBar(10,40,400,40,font));
  
  //query search bar
  
  searchBars.add(querySearchBar);
  
  //testing queries
  Query q = new Query("DEST_STATE_ABR", "CA");
  ArrayList<Data> result = q.run(); //<>//
  //for (int i = 0; i < result.size(); i++)
  //{
  //  println(result.get(i).getStrVal("DEST_STATE_ABR"));
  //}
  println(q.count);

}

void draw() 
{
  background(20);
  
  // query search bar
  textSize(30);
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