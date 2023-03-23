ArrayList<Data> dataList;
PFont font;
String[] lines;
int currentScreen = 1;
Screen screen1;
scrollBar scroll;

void settings()
{
   size(SCREENX, SCREENY);
}
void setup() 
{
  font = loadFont("Calibri-9.vlw");
  dataList = new ArrayList<Data>();
  initScreen(currentScreen);
  //println("There are " + lines.length + " lines");
  //for (int i = 0; i < lines.length; i++) {
  //println(lines[i]);
  //}
}

void draw() 
{
  screen1.draw();
  //Creates array of strings of the file data
  //String[] lines = loadStrings("flights2k(1).csv");

  //Creates Data objects and stores it into an ArrayList using a for loop
  //for (int i = 0; i < lines.length; i++) {
    //dataList.add(new Data(width/2, height/2, lines[i], font));

    //Prints to console
    //println(dataList.get(i).getData());
    //Color of text
    //fill(200);
    //textFont(font);

    //Prints to screen
    //text(dataList.get(i).getData(), 10, 10 +i*18);
  //}
}
  void initScreen(int currentScreen)
  {
    switch(currentScreen)
    {
      case 1 :
      // screen1 scroll bar widget parameters : int boxWidth, int boxHeight,int barWidth, int barHeight, int boxColour, int barColour,
      // int barX, int barY, int boxX, int boxY
      screen1 = new Screen(lightBlue, new Widgets(scroll = new scrollBar(15,525,13,45,200,150,721,70,720,60)));
      break;
    }
  }
  
  void mouseDragged() 
  {
    boolean event; 
    event = scroll.getEvent( mouseY);
    if(event)
    {
      scroll.barY = mouseY-(scroll.barHeight/2);
      if(scroll.barY+scroll.barHeight >= (scroll.boxY+scroll.boxHeight)-10)
      scroll.barY = (scroll.boxY+scroll.boxHeight)-10-scroll.barHeight;
      if(scroll.barY <= scroll.boxY+10)
      scroll.barY = scroll.boxY+10;
      draw();
    }
  }
