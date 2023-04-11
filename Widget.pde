//Made by David Alexander Adamache

class Widget {
  int x, y, width, height;
  String label;
  int event;
  color widgetColor, labelColor, strokeColour;
  PFont widgetFont;
  int coloured = 15;

  // Constructor for the Widget class
  Widget(int x, int y, int width, int height, String label, color widgetColor, PFont widgetFont, int event) {
    // Set instance variables based on input parameters
    this.x=x;
    this.y=y;
    this.width = width;
    this.height= height;
    this.label=label;
    this.event=event;
    this.widgetColor=widgetColor;
    this.widgetFont=widgetFont;
    // Set default values for labelColor and strokeColour
    labelColor= color(255);
    strokeColour = color(0);
  }

  void draw() {
    stroke(strokeColour);
    fill(widgetColor);
    rect(x, y, width, height);
    fill(labelColor);
    textFont(font);
    // Center the text horizontally and position it at the bottom of the widget
    text(label, (x+width/2)-(textWidth(label)/2), y+height-12);
  }

  // Check if the widget has been clicked on and return the corresponding event
  int getEvent(int mX, int mY, Widget widget) {
    // If the widget is a scrolling widget and is currently being scrolled, return the event
    if (widget == widget6)
      if (mY>y && mY<y+height && scrolling)
        return event;
    // If the mouse is within the boundaries of the widget, return the event
    if (mX>x && mX < x+width && mY >y && mY <y+height) {
      return event;
    } else {
      return NULL;
    }
  }
}
