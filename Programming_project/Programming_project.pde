ArrayList<Data> dataList;
PFont font;
String[] lines;

void setup() {
  size(800, 800);
  font = loadFont("Calibri-9.vlw");
  dataList = new ArrayList<Data>();

  //println("There are " + lines.length + " lines");
  //for (int i = 0; i < lines.length; i++) {
  //println(lines[i]);
  //}
}

void draw() {
  background(20);

  //Creates array of strings of the file data
  String[] lines = loadStrings("flights2k(1).csv");

  //Creates Data objects and stores it into an ArrayList using a for loop
  for (int i = 0; i < lines.length; i++) {
    dataList.add(new Data(width/2, height/2, lines[i], font
    
    //Prints to console
    println(dataList.get(i).getData());
    //Color of text
    fill(200);
    textFont(font);
    
    //Prints to screen
    text(dataList.get(i).getData(), 10, 10 +i*18);
  }
}
