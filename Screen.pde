class Screen
{
  int background;
  Widgets widget;
  Screen(int background, Widgets widget1)
  {
    this.background = background;
    this.widget = widget1;
  }
  void draw()
  {
   background(this.background);
   fill(darkerBlue);
   noStroke();
   rect(0,0,SCREENX, 50);
   fill(transBlue);
   noStroke();
   rect(SCREENX*.75, 0, 250, SCREENY);
   widget.draw();
  }
  
}
