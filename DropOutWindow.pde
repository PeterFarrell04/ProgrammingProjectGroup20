class DropOutWindow
{
  int x,y,width,height;
  color col;
  DropOutWindow(int x, int y, int width, int height, color col)
  {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.col = col;
  }
  
  void draw()
  {
    fill(col);
    rect(x,y,width,height);
  }
}
