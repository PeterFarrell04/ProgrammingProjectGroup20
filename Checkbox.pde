class Checkbox
{
  int GAP = 15;
  int x,y,width,height;
  color widgetColor;
  boolean link = false;
  Checkbox(int x,int y, int width, int height, color widgetColor)
  { 
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.widgetColor = widgetColor;
  }
  
  void draw()
  {
    stroke(0);
    fill(widgetColor);
    if (mouseOver()) stroke(255);
    
    rect(x-width+GAP,y,width,height);
    fill(255);
    if (link)
    {
      rect(x-width/2 -5,y + 4,40,40);
    }
    noStroke();
  }
  boolean mouseOver()
    {
      //checks if the mouse is in collision with the text box
      if (mouseX > x-width && mouseX < x+width)
      {
        if (mouseY > y && mouseY < y+height)
        {
          return true;
        }
      }
      return false;
    }
    
    void mouseIn()
    {
      if (mouseOver()) 
      {
        
        ResetCoarseSearch();
        link ^= true;
      }
    }

}
