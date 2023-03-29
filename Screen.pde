class Screen {
  ArrayList<Widget> widgets;
  color backgroundColor;
  Screen(int backgroundColor) {
    this.backgroundColor = color(backgroundColor);
    widgets = new ArrayList<Widget>();
  }

  void draw() {
    background(backgroundColor);
    drawWidgets();
  }

  int getEvent(int mousex, int mousey) {
    int event = 0;
    for (Widget widget : widgets) {
      event = widget.getEvent(mousex, mousey);
      if (event!=NULL) {
        return event;
      }
    }
    return event;
  }
  void drawWidgets() {
    for (Widget widget : widgets) {
      widget.draw();
    }
  }
  void addWidget(Widget widget) {
    widgets.add(widget);
  }
