class Widgets
{
  scrollBar scroll;
  Widgets(scrollBar scrolls)
  {
    this.scroll = scrolls;
  }
  void draw()
  {
    scroll.draw();
  }
  
}
