//Made by David Alexander Adamache

class Screen {
  ArrayList<Widget> widgets;
  color backgroundColor;
  Screen(int backgroundColor) {
    this.backgroundColor = color(backgroundColor);
    widgets = new ArrayList<Widget>();
  }

  // Draw the screen with the background color and a black rectangle at the bottom
  void draw() {
    background(backgroundColor);
    fill(0);
    rect(0, 665, 1300, 300);
    drawWidgets();
  }

  // Check for mouse events on each widget and return the event type
  int getEvent(int mousex, int mousey) {
    int event = 0;
    for (Widget widget : widgets) {
      // Get the event for the current widget
      event = widget.getEvent(mousex, mousey, widget);
      // If the event type is not NULL, return the event
      if (event!=NULL)
      {
        // Return the event type, which is initially set to 0
        return event;
      }
    }
    return event;
  }
  // Draw all widgets on the screen
  void drawWidgets() {
    for (Widget widget : widgets) {
      widget.draw();
    }
  }
  // Add a widget to the ArrayList of widgets
  void addWidget(Widget widget) {
    widgets.add(widget);
  }
}
