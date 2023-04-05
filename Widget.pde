class Widget {
  int x, y, width, height;
  String label;
  int event;
  color widgetColor, labelColor, strokeColour;
  PFont widgetFont;
  int coloured = 15;
  
  Widget(int x, int y, int width, int height, String label, color widgetColor, PFont widgetFont, int event) {
    this.x=x;
    this.y=y;
    this.width = width;
    this.height= height;
    this.label=label;
    this.event=event;
    this.widgetColor=widgetColor;
    this.widgetFont=widgetFont;
    labelColor= color(255);
    strokeColour = color(0);
  }
  void draw() {
    stroke(strokeColour);
    fill(widgetColor);
    rect(x, y, width, height);
    fill(labelColor);
    textFont(font);
    text(label, (x+width/2)-(textWidth(label)/2), y+height-12);
  }
  int getEvent(int mX, int mY, Widget widget) {

      if(widget == widget6)
        if(mY>y && mY<y+height && scrolling)
        return event;
    if (mX>x && mX < x+width && mY >y && mY <y+height) {
      return event;
    } else {
      return NULL;
    }
  }
}
