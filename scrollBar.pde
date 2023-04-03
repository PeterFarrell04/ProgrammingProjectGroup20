//Made by Luke Boylan 
//Scroll Bar
//

class scrollBar
{
  int boxWidth;
  int boxHeight;
  int barWidth;
  int barHeight;
  int boxColour;
  int barColour;
  int boxX;
  int boxY;
  int barX;
  int barY;
  scrollBar(int boxWidth, int boxHeight, int barWidth, int barHeight, int boxColour, int barColour,
  int barX, int barY, int boxX, int boxY)
  {
      this.barHeight = barHeight;
      this.barWidth = barWidth;
      this.boxHeight = boxHeight;
      this.boxWidth = boxWidth;
      this.boxColour = boxColour;
      this.barColour = barColour;
      this.barX=barX;
      this.barY=barY;
      this.boxX=boxX;
      this.boxY=boxY;
  }
  void draw()
  {
    fill(boxColour); //<>//
    rect(boxX,boxY,boxWidth,boxHeight);
    fill(boxColour-25);
    rect(boxX+1,boxY+1,boxWidth-2,8);
    fill(boxColour-25);
    rect(boxX+1,boxY+boxHeight-9,boxWidth-2,8);
    fill(barColour);
    rect(barX,barY,barWidth,barHeight);
  }
   boolean getEvent(int mY){
     if(mY >= barY && mY <= mY+barHeight)
     {
        return true;
     }
     return false;
  }
}
