//Made by Luke Boylan 
//Scroll Bar
//

class scrollBar
{
  int boxWidth;
  int boxHeight;
  int boxColour;
  int boxX;
  int boxY;
  scrollBar(int boxWidth, int boxHeight, int boxColour, int boxX, int boxY)
  {
      this.boxHeight = boxHeight;
      this.boxWidth = boxWidth;
      this.boxColour = boxColour;
      this.boxX=boxX;
      this.boxY=boxY;
  }
  void draw()
  {
    fill(boxColour); //<>//
    rect(boxX,boxY,boxWidth,boxHeight);
    fill(boxColour-25);
    rect(boxX+2,boxY+2,boxWidth-4,8);
    fill(boxColour-25);
    rect(boxX+2,boxY+boxHeight-10,boxWidth-4,8);
  }
  
}
